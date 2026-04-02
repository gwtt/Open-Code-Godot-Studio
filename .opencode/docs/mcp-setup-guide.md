# MCP 服务器配置指南

> 本文档介绍如何在 OpenCode 中配置三个 MCP 服务器，为 Godot 游戏开发提供 AI 辅助能力。

---

## 目录

1. [MCP 概述](#mcp-概述)
2. [OpenCode 配置格式说明](#opencode-配置格式说明)
3. [三个 MCP 服务器介绍](#三个-mcp-服务器介绍)
4. [前置依赖检查](#前置依赖检查)
5. [API Key 获取](#api-key-获取)
6. [完整配置示例](#完整配置示例)
7. [验证方法](#验证方法)
8. [常见问题解答](#常见问题解答)

---

## MCP 概述

### 什么是 MCP？

**MCP (Model Context Protocol)** 是 Anthropic 提出的标准化协议，用于 AI 模型与外部工具/数据源的交互。它让 AI 能够：

- **调用外部工具**：生成像素艺术、创建音频、控制 Godot 项目
- **访问外部数据**：读取文件、查询 API
- **执行复杂操作**：自动化游戏开发流程

### 为什么需要 MCP？

传统 AI 只能处理文本，通过 MCP 可以：

| 服务器 | 能力 | 游戏开发用途 |
|--------|------|--------------|
| **PixelLab** | 像素艺术生成 | 角色、Tileset、地图素材 |
| **ElevenLabs** | 音频/音乐生成 | 配音、音效、背景音乐 |
| **Godot** | 项目控制 | 创建场景、添加节点、运行测试 |

---

## OpenCode 配置格式说明

### ⚠️ 重要：格式差异

OpenCode 使用**自定义配置格式**，与标准 MCP 格式有关键差异：

| 字段 | 标准 MCP 格式 | OpenCode 格式 | 说明 |
|------|---------------|---------------|------|
| **服务器类型** | `"command"` | `"local"` | 本地进程类型 |
| **命令格式** | `command: "npx", args: ["pkg"]` | `command: ["npx", "pkg"]` | 合并为单个数组 |
| **环境变量** | `env: {...}` | `environment: {...}` | 字段名不同 |
| **远程服务** | `"http"` | `"remote"` | HTTP 服务类型 |

### 错误示例 ❌

```json
{
  "mcpServers": {
    "elevenlabs": {
      "type": "command",           // ❌ 错误！应使用 "local"
      "command": "uvx",            // ❌ 错误！应合并为数组
      "args": ["elevenlabs-mcp"],  // ❌ 错误！OpenCode 不支持分离的 args
      "env": {                     // ❌ 错误！应使用 "environment"
        "ELEVENLABS_API_KEY": "..."
      }
    }
  }
}
```

### 正确示例 ✅

```json
{
  "mcpServers": {
    "elevenlabs": {
      "type": "local",                     // ✅ 正确
      "command": ["uvx", "elevenlabs-mcp"], // ✅ 合并为数组
      "environment": {                      // ✅ 使用 environment
        "ELEVENLABS_API_KEY": "..."
      }
    }
  }
}
```

---

## 三个 MCP 服务器介绍

### 1. PixelLab (Remote)

**类型**：远程 HTTP 服务  
**用途**：AI 像素艺术生成

#### 主要功能

| 工具 | 功能 | 参数 |
|------|------|------|
| `create_character` | 生成像素角色 | `description` (角色描述), `n_directions` (1-8方向) |
| `animate_character` | 角色动画 | `character_id` (角色ID), `animation` (动画类型) |
| `create_topdown_tileset` | Top-down Tileset | `lower_description`, `upper_description` |
| `create_isometric_tile` | 等距瓦片 | `description`, `size` (16-64px) |
| `create_sidescroller_tileset` | 横版 Tileset | `lower_description`, `transition_description` |
| `create_map_object` | 地图装饰物 | `description`, `width`, `height` |

#### 输出配置

```json
"output": {
  "directory": "assets/sprites/generated/",
  "format": "png"
}
```

#### 适用场景

- ✅ Top-down 游戏（RPG、策略）
- ✅ 横版游戏（平台跳跃）
- ✅ 等距视角游戏
- ✅ 快速原型素材生成

---

### 2. ElevenLabs (Local)

**类型**：本地进程服务  
**用途**：AI 音频/音乐生成

#### 主要功能

| 工具 | 功能 | 参数 |
|------|------|------|
| `text_to_speech` | 文本转语音 | `text`, `voice_name` (可选) |
| `speech_to_text` | 语音转文本 | `input_file_path` |
| `text_to_sound_effects` | 生成音效 | `text` (音效描述), `duration_seconds` (0.5-5秒) |
| `compose_music` | 生成音乐 | `prompt` 或 `composition_plan` |
| `voice_clone` | 声音克隆 | `name`, `files` (音频样本) |
| `list_voices` | 列出可用声音 | 无参数 |

#### 输出配置

```json
"output": {
  "directory": "assets/audio/generated/",
  "format": "mp3"
}
```

#### 适用场景

- ✅ 游戏配音（NPC 对话）
- ✅ UI 音效（按钮点击、提示音）
- ✅ 环境音效（风声、水声）
- ✅ 背景音乐生成

---

### 3. Godot MCP (Local)

**类型**：本地进程服务  
**用途**：Godot 项目自动化控制

#### 主要功能

| 工具 | 功能 | 参数 |
|------|------|------|
| `create_scene` | 创建新场景 | `scene_path`, `rootNodeType` |
| `add_node` | 添加节点 | `scene_path`, `nodeType`, `nodeName` |
| `load_sprite` | 加载精灵 | `scene_path`, `nodePath`, `texturePath` |
| `save_scene` | 保存场景 | `scene_path` |
| `run_project` | 运行项目 | `projectPath`, `scene` (可选) |
| `export_mesh_library` | 导出 MeshLibrary | `scene_path`, `output_path` |
| `get_project_info` | 项目信息 | `projectPath` |
| `launch_editor` | 打开编辑器 | `projectPath` |

#### 适用场景

- ✅ 批量创建场景
- ✅ 自动化测试运行
- ✅ 资源导入自动化
- ✅ 快速原型搭建

---

## 前置依赖检查

### ElevenLabs 依赖

**需要**：`uv` (Python 包管理器)

#### 检查命令

```bash
# Windows (PowerShell)
uv --version

# Linux/macOS
uv --version
```

#### 安装命令

```bash
# 使用 pip 安装
pip install uv

# 或使用官方安装脚本
# Windows (PowerShell)
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# Linux/macOS
curl -LsSf https://astral.sh/uv/install.sh | sh
```

---

### Godot MCP 依赖

**需要**：Node.js 18+

#### 检查命令

```bash
node --version  # 应显示 >= v18.0.0
npm --version   # 或 yarn/pnpm
```

#### 安装 Node.js

- **官网下载**：https://nodejs.org/
- **推荐版本**：LTS (长期支持版)
- **最低版本**：v18.0.0

---

### PixelLab 依赖

**无需本地依赖**（远程 HTTP 服务）

只需：
- ✅ 网络连接
- ✅ API Token

---

## API Key 获取

### PixelLab API Token

**获取地址**：https://pixellab.ai/dashboard

#### 步骤

1. 注册/登录 PixelLab
2. 进入 Dashboard
3. 找到 API Token 部分
4. 复制 Token

**配置字段**：
```json
"headers": {
  "Authorization": "Bearer YOUR_PIXELLAB_API_TOKEN"
}
```

---

### ElevenLabs API Key

**获取地址**：https://elevenlabs.io

#### 步骤

1. 注册/登录 ElevenLabs
2. 进入 Profile Settings
3. 找到 API Keys
4. 创建/复制 API Key

**配置字段**：
```json
"environment": {
  "ELEVENLABS_API_KEY": "YOUR_ELEVENLABS_API_KEY"
}
```

---

### Godot 配置

**无需 API Key**，需要配置 Godot 路径。

#### 查找 Godot 路径

**Windows**：
```powershell
# 常见路径
C:\Godot\Godot_v4.6.1.exe
# 或 Steam 版
C:\Program Files\Steam\steamapps\common\Godot Engine\Godot_v4.6.1.exe
```

**Linux/macOS**：
```bash
# 常见路径
/usr/local/bin/godot4
/Applications/Godot.app
```

**配置字段**：
```json
"environment": {
  "GODOT_PATH": "YOUR_GODOT_EXECUTABLE_PATH"
}
```

---

## 完整配置示例

### OpenCode MCP 配置文件

**文件位置**：`.opencode/mcp.json`（或 `mcp.json`）

```json
{
  "$schema": "https://modelcontextprotocol.io/schema/mcp-config",
  "version": "1.0",
  "mcpServers": {
    
    "pixellab": {
      "type": "remote",
      "url": "https://api.pixellab.ai/mcp",
      "description": "PixelLab - AI 像素艺术生成",
      "headers": {
        "Authorization": "Bearer YOUR_PIXELLAB_API_TOKEN"
      }
    },
    
    "elevenlabs": {
      "type": "local",
      "command": ["uvx", "elevenlabs-mcp"],
      "description": "ElevenLabs - AI 音频/音乐生成",
      "environment": {
        "ELEVENLABS_API_KEY": "YOUR_ELEVENLABS_API_KEY",
        "ELEVENLABS_MCP_OUTPUT_MODE": "files",
        "ELEVENLABS_API_RESIDENCY": "us"
      }
    },
    
    "godot": {
      "type": "local",
      "command": ["npx", "@coding-solo/godot-mcp"],
      "description": "Godot MCP - 项目自动化控制",
      "environment": {
        "GODOT_PATH": "C:\\Godot\\Godot_v4.6.1.exe",
        "DEBUG": "false"
      }
    }
    
  }
}
```

---

### 配置步骤总结

1. **检查依赖**
   ```bash
   uv --version      # ElevenLabs 需要
   node --version    # Godot MCP 需要
   ```

2. **获取 API Key**
   - PixelLab: https://pixellab.ai/dashboard
   - ElevenLabs: https://elevenlabs.io

3. **创建配置文件**
   - 复制上述完整配置
   - 替换 `YOUR_xxx` 为实际值

4. **放置文件**
   - 保存为 `.opencode/mcp.json`

---

## 验证方法

### 方法一：启动 OpenCode 检查

```bash
# 启动 OpenCode
opencode

# 在 OpenCode 中检查 MCP 工具
# 输入: /help 或检查工具列表
```

**成功标志**：
- 工具列表中出现 `pixellab_*`, `elevenlabs_*`, `godot_*` 工具
- 无错误提示

---

### 方法二：直接测试 MCP 工具

#### PixelLab 测试

```
列出我的 PixelLab 角色：
```

或使用工具：
```
pixellab_list_characters()
```

---

#### ElevenLabs 测试

```
列出 ElevenLabs 可用声音：
```

或使用工具：
```
elevenlabs_list_models()
```

---

#### Godot 测试

```
获取 Godot 项目信息：
```

或使用工具：
```
godot_get_project_info(projectPath="D:\\path\\to\\your\\godot\\project")
```

---

### 方法三：检查进程启动

**Windows PowerShell**：
```powershell
# 检查 MCP 进程
Get-Process | Where-Object {$_.ProcessName -match "uvx|npx"}
```

**Linux/macOS**：
```bash
# 检查 MCP 进程
ps aux | grep -E "uvx|npx"
```

---

## 常见问题解答

### Q1: 配置文件位置错误？

**问题**：放在了错误目录，OpenCode 无法识别。

**解决**：
```
正确位置: 项目根目录/.opencode/mcp.json
错误位置: 项目根目录/mcp.json (可能不识别)
```

---

### Q2: 格式错误导致无法启动？

**问题**：使用了标准 MCP 格式而非 OpenCode 格式。

**解决**：检查三个关键字段：
- `type: "local"` (不是 `"command"`)
- `command: ["npx", "pkg"]` (不是 `command + args`)
- `environment: {...}` (不是 `env`)

---

### Q3: ElevenLabs 启动失败？

**问题**：缺少 `uv` 依赖。

**解决**：
```bash
pip install uv
uv --version  # 验证安装
```

---

### Q4: Godot MCP 启动失败？

**问题**：Node.js 版本过低或路径错误。

**解决**：
```bash
# 检查 Node.js 版本
node --version  # 必须 >= 18

# 检查 Godot 路径
# Windows: 确保 GODOT_PATH 使用双反斜杠
"GODOT_PATH": "C:\\Godot\\Godot_v4.6.1.exe"
```

---

### Q5: PixelLab 连接失败？

**问题**：API Token 无效或网络问题。

**解决**：
1. 检查 Token 是否正确复制
2. 检查网络连接
3. 确认格式：`Bearer YOUR_TOKEN`（Bearer 后有空格）

---

### Q6: 工具调用超时？

**问题**：默认超时 30 秒可能不够。

**解决**：添加全局设置：
```json
"globalSettings": {
  "timeout": 60000,  // 增加到 60 秒
  "retryAttempts": 3,
  "logLevel": "info"
}
```

---

### Q7: 如何禁用某个 MCP？

**问题**：不需要所有服务器，想禁用部分。

**解决**：删除对应配置块，或设置 `enabled: false`（如果支持）。

---

### Q8: 输出文件在哪里？

**PixelLab**：`assets/sprites/generated/`
**ElevenLabs**：`assets/audio/generated/`

可修改 `output.directory` 字段自定义路径。

---

### Q9: 如何查看 MCP 日志？

**问题**：调试时需要查看详细日志。

**解决**：设置日志级别：
```json
"globalSettings": {
  "logLevel": "debug"  // 或 "info", "warn", "error"
}
```

---

### Q10: 多项目如何共享配置？

**问题**：多个项目使用相同 MCP 配置。

**解决**：
1. 将 `mcp.json` 放在用户级配置目录
2. 或使用环境变量共享 API Key

---

## 参考链接

| 资源 | 链接 |
|------|------|
| **PixelLab Dashboard** | https://pixellab.ai/dashboard |
| **ElevenLabs官网** | https://elevenlabs.io |
| **ElevenLabs MCP** | https://github.com/elevenlabs/elevenlabs-mcp |
| **Godot MCP** | https://github.com/Coding-Solo/godot-mcp |
| **MCP 协议规范** | https://modelcontextprotocol.io |

---

## 下一步

配置完成后，可以：

1. **使用 `/start`**：开始使用 AI 技能
2. **使用 `/art-coordinator`**：请求生成素材
3. **使用 `/prototype-mode`**：快速原型开发

---

> 💡 **提示**：本配置指南专为 OpenCode 设计，如使用其他 MCP 客户端（如 Claude Desktop），请参考标准 MCP 格式。