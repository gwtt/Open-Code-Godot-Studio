#!/usr/bin/env bash
# ============================================================================
# MCP 一键配置脚本 (Linux/macOS)
# 功能：依赖检测、交互输入、复制模板、占位符替换、目录创建、配置验证
# 使用：chmod +x scripts/setup-mcp.sh && ./scripts/setup-mcp.sh
# ============================================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 路径设置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OPENCODE_DIR="${PROJECT_ROOT}/.opencode"
EXAMPLE_JSON="${OPENCODE_DIR}/mcp.example.json"
OUTPUT_JSON="${OPENCODE_DIR}/mcp.json"

# 日志函数
log() { echo -e "${CYAN}[MCP]${NC} $1"; }
error() { echo -e "${RED}[错误]${NC} $1" >&2; exit 1; }
warn() { echo -e "${YELLOW}[警告]${NC} $1" >&2; }
success() { echo -e "${GREEN}[成功]${NC} $1"; }

# 打印标题
print_header() {
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo ""
}

# 欢迎信息
echo ""
echo -e "${CYAN}╔══════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     MCP 一键配置脚本                ║${NC}"
echo -e "${CYAN}║     OpenCode Godot Studio           ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════╝${NC}"
echo ""

# 步骤 1: 依赖检测
print_header "步骤 1/6: 依赖检测"

# Python 检测
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    error "未找到 Python，请安装 Python 3.8+"
fi
log "Python: $($PYTHON_CMD --version)"

# uv 检测
if $PYTHON_CMD -c "import uv" 2>/dev/null; then
    log "uv: 已安装"
else
    warn "uv 未安装，运行: pip install uv"
fi

# Node.js 检测
if command -v node &> /dev/null; then
    log "Node.js: $(node --version)"
else
    error "未找到 Node.js，请安装 Node.js 18+"
fi

# npx 检测
if command -v npx &> /dev/null; then
    log "npx: $(npx --version)"
else
    warn "npx 未找到"
fi

# Godot 检测
GODOT_PATH=""
if command -v godot &> /dev/null; then
    GODOT_PATH="$(command -v godot)"
    log "Godot: $GODOT_PATH"
else
    # 检查常见路径
    POSSIBLE_PATHS=(
        "/Applications/Godot.app/Contents/MacOS/Godot"
        "/usr/local/bin/godot"
        "/usr/bin/godot"
        "$HOME/.local/bin/godot"
        "$HOME/Applications/Godot.app/Contents/MacOS/Godot"
    )
    for p in "${POSSIBLE_PATHS[@]}"; do
        if [ -x "$p" ]; then
            GODOT_PATH="$p"
            break
        fi
    done
    if [ -n "$GODOT_PATH" ]; then
        log "Godot: $GODOT_PATH"
    else
        warn "未找到 Godot，请稍后手动输入路径"
    fi
fi

# 步骤 2: 交互式输入
print_header "步骤 2/6: API 配置"

echo -e "${YELLOW}请输入以下配置信息：${NC}"
echo ""

# PixelLab API Token
read -p "PixelLab API Token (从 pixellab.ai/dashboard 获取): " PIXELLAB_TOKEN
if [ -z "$PIXELLAB_TOKEN" ]; then
    warn "PixelLab Token 为空，该服务将被禁用"
fi

# ElevenLabs API Key
read -p "ElevenLabs API Key (从 elevenlabs.io 获取): " ELEVENLABS_KEY
if [ -z "$ELEVENLABS_KEY" ]; then
    warn "ElevenLabs Key 为空，该服务将被禁用"
fi

# Godot 路径
if [ -z "$GODOT_PATH" ]; then
    read -p "Godot 可执行文件路径: " GODOT_INPUT
    if [ -n "$GODOT_INPUT" ]; then
        if [ -x "$GODOT_INPUT" ]; then
            GODOT_PATH="$GODOT_INPUT"
        else
            warn "输入的路径不可执行"
        fi
    fi
else
    echo "Godot 路径 (已自动检测): $GODOT_PATH"
    read -p "按 Enter 使用自动检测路径，或输入新路径: " GODOT_INPUT
    if [ -n "$GODOT_INPUT" ] && [ -x "$GODOT_INPUT" ]; then
        GODOT_PATH="$GODOT_INPUT"
    fi
fi

# 步骤 3: 复制模板
print_header "步骤 3/6: 创建配置文件"

if [ ! -f "$EXAMPLE_JSON" ]; then
    error "模板文件不存在: $EXAMPLE_JSON"
fi

# 备份现有配置
if [ -f "$OUTPUT_JSON" ]; then
    BACKUP="${OUTPUT_JSON}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$OUTPUT_JSON" "$BACKUP"
    log "已备份现有配置到: $BACKUP"
fi

cp "$EXAMPLE_JSON" "$OUTPUT_JSON"
success "已创建配置文件: $OUTPUT_JSON"

# 步骤 4: 替换占位符
print_header "步骤 4/6: 配置 API Keys"

# 使用 Python 进行安全的 JSON 替换
$PYTHON_CMD << PYEOF
import json
import os

output_path = "$OUTPUT_JSON"
pixellab_token = "$PIXELLAB_TOKEN"
elevenlabs_key = "$ELEVENLABS_KEY"
godot_path = "$GODOT_PATH"

with open(output_path, 'r', encoding='utf-8') as f:
    config = json.load(f)

# 替换 PixelLab Token
if 'mcpServers' in config and 'pixellab' in config['mcpServers']:
    if pixellab_token:
        if 'headers' not in config['mcpServers']['pixellab']:
            config['mcpServers']['pixellab']['headers'] = {}
        config['mcpServers']['pixellab']['headers']['Authorization'] = f'Bearer {pixellab_token}'
        config['mcpServers']['pixellab']['enabled'] = True
    else:
        config['mcpServers']['pixellab']['enabled'] = False

# 替换 ElevenLabs Key
if 'mcpServers' in config and 'elevenlabs' in config['mcpServers']:
    if elevenlabs_key:
        if 'env' not in config['mcpServers']['elevenlabs']:
            config['mcpServers']['elevenlabs']['env'] = {}
        config['mcpServers']['elevenlabs']['env']['ELEVENLABS_API_KEY'] = elevenlabs_key
        config['mcpServers']['elevenlabs']['enabled'] = True
    else:
        config['mcpServers']['elevenlabs']['enabled'] = False

# 替换 Godot 路径
if 'mcpServers' in config and 'godot' in config['mcpServers']:
    if godot_path:
        if 'env' not in config['mcpServers']['godot']:
            config['mcpServers']['godot']['env'] = {}
        config['mcpServers']['godot']['env']['GODOT_PATH'] = godot_path
        config['mcpServers']['godot']['enabled'] = True
    else:
        config['mcpServers']['godot']['enabled'] = False

with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(config, f, indent=2, ensure_ascii=False)

print("配置更新完成")
PYEOF

success "API Keys 已配置"

# 步骤 5: 创建输出目录
print_header "步骤 5/6: 创建输出目录"

mkdir -p "${PROJECT_ROOT}/assets/sprites/generated"
mkdir -p "${PROJECT_ROOT}/assets/audio/generated"

success "已创建目录:"
echo "  - assets/sprites/generated/"
echo "  - assets/audio/generated/"

# 步骤 6: 验证配置
print_header "步骤 6/6: 验证配置"

if $PYTHON_CMD -c "import json; json.load(open('$OUTPUT_JSON'))" 2>/dev/null; then
    success "配置文件格式验证通过"
else
    error "配置文件格式错误，请检查 JSON 语法"
fi

# 完成信息
echo ""
echo -e "${GREEN}╔══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     ✅ MCP 配置完成！               ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════╝${NC}"
echo ""
echo "配置文件: $OUTPUT_JSON"
echo ""
echo "已启用的服务:"
if [ -n "$PIXELLAB_TOKEN" ]; then
    echo "  ✅ PixelLab - AI 像素艺术生成"
else
    echo "  ⬜ PixelLab - 未配置"
fi
if [ -n "$ELEVENLABS_KEY" ]; then
    echo "  ✅ ElevenLabs - AI 音频生成"
else
    echo "  ⬜ ElevenLabs - 未配置"
fi
if [ -n "$GODOT_PATH" ]; then
    echo "  ✅ Godot MCP - 项目控制"
else
    echo "  ⬜ Godot MCP - 未配置"
fi
echo ""
echo "后续步骤:"
echo "  1. 查看 docs/mcp/MCP_GUIDE_CN.md 了解使用方法"
echo "  2. 在 OpenCode 中使用: '用 PixelLab 生成像素角色'"
echo ""