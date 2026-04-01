<#
MCP 一键配置脚本
功能要点：
- 依赖检查（Python/uv、Node.js/npx、Godot）
- 交互式输入 API Token/Key 和 Godot 路径
- 复制模板配置 .opencode/mcp.example.json 为 .opencode/mcp.json
- 替换占位符并校验 JSON 格式
- 创建输出目录 assets/sprites/generated/ 与 assets/audio/generated/
- 显示成功信息及后续步骤
#>

$ErrorActionPreference = "Stop"

Write-Host "欢迎使用 MCP 一键配置脚本" -ForegroundColor Cyan
Write-Host

# -------------------------- 路径准备 --------------------------
$ScriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot   = (Resolve-Path (Join-Path $ScriptDir ".." )).Path
$OpEncodeDir = Join-Path -Path $RepoRoot -ChildPath ".opencode"
$TemplatePath = Join-Path -Path $OpEncodeDir -ChildPath "mcp.example.json"
$TargetPath   = Join-Path -Path $OpEncodeDir -ChildPath "mcp.json"

if (-Not (Test-Path $TemplatePath)) {
    Write-Host "错误：模板文件未找到：$TemplatePath" -ForegroundColor Red
    exit 1
}

if (-Not (Test-Path $OpEncodeDir)) {
    New-Item -Path $OpEncodeDir -ItemType Directory -Force | Out-Null
}

# -------------------------- 依赖检查 --------------------------
Write-Host "[依赖检查]" -ForegroundColor Yellow

function Test-Command([string]$name) {
    Get-Command $name -ErrorAction SilentlyContinue
}

$pythonCmd = Test-Command -name "python"
if ($null -eq $pythonCmd) {
    Write-Host "- Python 未安装，请安装 Python 并确保在 PATH 中可执行。" -ForegroundColor Red
    $pythonOk = $false
} else {
    $pythonOk = $true
}

if ($pythonOk) {
    try {
        & $pythonCmd.Source -c "import sys; import uv; print('uv version', getattr(uv,'__version__', 'unknown'))" 2>$null | Out-Null
        $uvOk = $true
    } catch {
        $uvOk = $false
    }
} else { $uvOk = $false }

if (-not $uvOk) {
    Write-Host "- uv 包未安装或无法导入。请在相应的 Python 环境中安装 uv。" -ForegroundColor Yellow
} else {
    Write-Host "- Python/uv 可用。" -ForegroundColor Green
}

$nodeCmd = Test-Command -name "node"
if ($null -eq $nodeCmd) {
    Write-Host "- Node.js 未安装，请安装 Node.js 并确保在 PATH 中可执行。" -ForegroundColor Red
    $nodeOk = $false
} else {
    $nodeOk = $true
}

if ($nodeOk) {
    $npxCmd = Test-Command -name "npx"
    if ($null -eq $npxCmd) {
        Write-Host "- npx 未找到，请确保 Node.js 安装包含 npm/npx。" -ForegroundColor Yellow
        $npxOk = $false
    } else {
        $npxOk = $true
    }
} else {
    $npxOk = $false
}

$godotCmd = Test-Command -name "godot"
if ($null -eq $godotCmd) {
    Write-Host "- Godot 未在 PATH 中检测到。准备手动输入 Godot 路径。" -ForegroundColor Yellow
    $godotPathAuto = $null
} else {
    $godotPathAuto = $godotCmd.Source
    Write-Host "- 自动检测到 Godot 路径：$godotPathAuto" -ForegroundColor Green
}

if (-not $pythonOk -or -not $uvOk -or -not $nodeOk) {
    Write-Host "请先满足上述依赖后重新运行脚本，或在本脚本中继续配置（依赖可跳过的话请自行确认后继续）。" -ForegroundColor Yellow
}

Write-Host

# -------------------------- 交互式配置 --------------------------
Write-Host "[交互式配置]" -ForegroundColor Yellow

$pixelLabToken = Read-Host -Prompt "PixelLab API Token（请输入）"
$elevenLabsKey  = Read-Host -Prompt "ElevenLabs API Key（请输入）"

if ($godotPathAuto -ne $null) {
    $godotPrompt = "Godot 路径 (自动检测: $godotPathAuto) - 回车使用自动检测："
} else {
    $godotPrompt = "Godot 路径 (请手动输入完整路径)："
}
$godotInput = Read-Host -Prompt $godotPrompt
if ([string]::IsNullOrWhiteSpace($godotInput) -and $godotPathAuto) {
    $godotPath = $godotPathAuto
} else {
    $godotPath = $godotInput
}

if (-not (Test-Path $godotPath)) {
    Write-Host "警告：输入的 Godot 路径无效或不存在。请确保提供有效路径。" -ForegroundColor Yellow
}

Write-Host

# -------------------------- 创建配置 --------------------------
Write-Host "[创建配置]" -ForegroundColor Yellow

# 复制模板
Copy-Item -Path $TemplatePath -Destination $TargetPath -Force

if (-Not (Test-Path $TargetPath)) {
    Write-Host "错误：无法创建配置文件 $TargetPath" -ForegroundColor Red
    exit 1
}

# 替换占位符
$configRaw = Get-Content -Raw -LiteralPath $TargetPath
$configRaw = $configRaw.Replace("{PIXELLAB_API_TOKEN}", $pixelLabToken)
$configRaw = $configRaw.Replace("{ELEVENLABS_API_KEY}", $elevenLabsKey)
$configRaw = $configRaw.Replace("{GODOT_PATH}", $godotPath)

try {
    # 验证 JSON 语法
    $null = $configRaw | ConvertFrom-Json -ErrorAction Stop
} catch {
    Write-Host "错误：生成的 mcp.json JSON 格式无效，请检查占位符替换是否正确。" -ForegroundColor Red
    exit 1
}

Set-Content -Path $TargetPath -Value $configRaw -Encoding UTF8

Write-Host "配置文件已写入：$TargetPath" -ForegroundColor Green

# -------------------------- 创建输出目录 --------------------------
Write-Host "[创建输出目录]" -ForegroundColor Yellow

$dirs = @("assets/sprites/generated","assets/audio/generated")
foreach ($d in $dirs) {
    $full = Join-Path -Path $RepoRoot -ChildPath $d
    if (-Not (Test-Path $full)) {
        New-Item -Path $full -ItemType Directory -Force | Out-Null
        Write-Host "已创建目录：$full" -ForegroundColor Green
    } else {
        Write-Host "目录已存在：$full" -ForegroundColor Gray
    }
}

# -------------------------- 验证与输出 --------------------------
Write-Host
Write-Host "[成功消息]" -ForegroundColor Green
Write-Host "✅ 配置完成" -ForegroundColor Green
Write-Host "下一步：在 Godot 项目中打开 .opencode/mcp.json，确保 MCP 服务已启用并按需在 UI 中加载。" -ForegroundColor Cyan
