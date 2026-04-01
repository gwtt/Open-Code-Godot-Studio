# MCP 集成指南

> OpenCode Godot Studio - MCP 服务器配置与使用教程

---

## 目录

1. [什么是 MCP？](#1-什么是-mcp)
2. [三大 MCP 服务器介绍](#2-三大-mcp-服务器介绍)
3. [一键接入](#3-一键接入)
4. [使用方法](#4-使用方法)
5. [贪吃蛇项目示例](#5-贪吃蛇项目示例)
6. [常见问题 (FAQ)](#6-常见问题-faq)
7. [最佳实践](#7-最佳实践)
8. [参考链接](#8-参考链接)

---

## 1. 什么是 MCP？

### MCP 协议简介

**MCP (Model Context Protocol)** 是一个开放协议，用于在 AI 应用和外部数据源/工具之间建立无缝连接。

```
用户 → AI Agent (OpenCode) → MCP 服务器 → 外部服务
                                    ↓
                              生成资源 → 保存到项目
```

### 在 OpenCode 中使用 MCP 的价值

| 功能 | 传统方式 | MCP 方式 |
|------|----------|----------|
| 美术资源 | 手绘或购买素材 | AI 生成像素图 |
| 音效资源 | 手动录音或购买 | AI 生成音效 |
| 场景创建 | 手动编辑 | 自动化创建 |
| 调试测试 | 手动运行检查 | MCP 自动化控制 |

### AI 辅助游戏开发工作流程

```
1. 你描述需求 → "生成一个像素风格的贪吃蛇角色"
2. AI 调用 MCP → 选择合适的 MCP 服务器
3. 服务器生成资源 → 图片/音频/场景
4. 资源自动保存 → assets/ 目录
5. 你在 Godot 中使用 → 导入并应用
```

---

## 2. 三大 MCP 服务器介绍

### 🎨 PixelLab MCP - AI 像素艺术生成

**官方地址**: https://pixellab.ai  
**GitHub**: https://github.com/pixellab-code/pixellab-mcp

#### 功能列表

| 工具名称 | 功能描述 | 参数示例 |
|----------|----------|----------|
| `create_character` | 生成像素角色 | `description: "绿色蛇头"`, `n_directions: 8` |
| `animate_character` | 为角色添加动画 | `character_id: "xxx"`, `animation: "walk"` |
| `create_tileset` | 生成瓦片集 | `lower: "草地"`, `upper: "沙地"` |
| `create_isometric_tile` | 生成等距瓦片 | `description: "石砖"`, `size: 32` |

#### 用途

- ✅ 游戏角色精灵
- ✅ 瓦片地图素材
- ✅ UI 图标元素
- ✅ 道具图标

#### 获取 API Key

1. 访问 https://pixellab.ai/dashboard
2. 注册/登录账号
3. 在 Dashboard 中获取 API Token
4. 免费额度 + 付费套餐

#### 配置示例

```json
{
  "pixellab": {
    "type": "http",
    "url": "https://api.pixellab.ai/mcp",
    "headers": {
      "Authorization": "Bearer YOUR_API_TOKEN"
    },
    "enabled": true
  }
}
```

---

### 🔊 ElevenLabs MCP - AI 音频/音乐生成

**官方地址**: https://elevenlabs.io  
**GitHub**: https://github.com/elevenlabs/elevenlabs-mcp

#### 功能列表

| 工具名称 | 功能描述 | 参数示例 |
|----------|----------|----------|
| `generate_speech` | 文本转语音 | `text: "你好世界"`, `voice_id: "xxx"` |
| `generate_sound_effect` | 生成音效 | `prompt: "清脆的叮声"` |
| `list_voices` | 列出可用声音 | 无参数 |

#### 用途

- ✅ 游戏配音/旁白
- ✅ 音效设计
- ✅ 背景音乐

#### 依赖安装

```bash
# 安装 uv (Python 包管理器)
pip install uv

# 或使用官方安装脚本 (Linux/macOS)
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### 获取 API Key

1. 访问 https://elevenlabs.io
2. 注册/登录账号
3. 在 Settings → API Keys 中获取
4. 免费额度 + 付费套餐

#### 配置示例

```json
{
  "elevenlabs": {
    "type": "command",
    "command": "uvx",
    "args": ["elevenlabs-mcp"],
    "env": {
      "ELEVENLABS_API_KEY": "YOUR_API_KEY"
    },
    "enabled": true
  }
}
```

#### 数据驻留设置

支持设置 API 区域（可选）：
- `us` - 美国 (默认)
- `eu` - 欧洲
- `in` - 印度

```json
"env": {
  "ELEVENLABS_API_KEY": "YOUR_API_KEY",
  "ELEVENLABS_API_RESIDENCY": "us"
}
```

---

### 🎮 Godot MCP - Godot 项目控制

**GitHub**: https://github.com/Coding-Solo/godot-mcp

#### 功能列表

| 工具名称 | 功能描述 | 参数示例 |
|----------|----------|----------|
| `create_scene` | 创建新场景 | `scene_path: "res://Scenes/Main.tscn"` |
| `add_node` | 添加节点 | `node_type: "Sprite2D"`, `node_name: "Player"` |
| `load_sprite` | 加载贴图 | `texture_path: "res://icon.svg"` |
| `save_scene` | 保存场景 | `scene_path: "res://Scenes/Main.tscn"` |
| `run_project` | 运行项目 | 无参数 |
| `export_mesh_library` | 导出 MeshLibrary | `scene_path`, `output_path` |

#### 用途

- ✅ 自动化场景创建
- ✅ 批量节点操作
- ✅ 项目调试控制
- ✅ 资源管理

#### 依赖

- **Node.js**: >= 18
- **Godot**: 4.x

#### 配置示例

```json
{
  "godot": {
    "type": "command",
    "command": "npx",
    "args": ["@coding-solo/godot-mcp"],
    "env": {
      "GODOT_PATH": "C:\\Godot\\Godot_v4.6.1.exe",
      "DEBUG": "false"
    },
    "enabled": true
  }
}
```

---

## 3. 一键接入

### Windows 用户

```powershell
# 方法 1: 使用 PowerShell 脚本
.\scripts\setup-mcp.ps1

# 方法 2: 手动配置
# 1. 复制配置模板
Copy-Item .opencode\mcp.example.json .opencode\mcp.json

# 2. 编辑配置文件
notepad .opencode\mcp.json

# 3. 输入你的 API Keys
# 4. 将 enabled 改为 true
```

### Linux/macOS 用户

```bash
# 方法 1: 使用 Shell 脚本
chmod +x scripts/setup-mcp.sh
./scripts/setup-mcp.sh

# 方法 2: 手动配置
cp .opencode/mcp.example.json .opencode/mcp.json
nano .opencode/mcp.json
```

### 手动配置步骤

1. **复制配置模板**
   ```bash
   cp .opencode/mcp.example.json .opencode/mcp.json
   ```

2. **编辑配置文件**
   ```json
   {
     "mcpServers": {
       "pixellab": {
         "enabled": true,  // 改为 true 启用
         "headers": {
           "Authorization": "Bearer YOUR_ACTUAL_TOKEN"  // 替换为真实 Token
         }
       },
       "elevenlabs": {
         "enabled": true,
         "env": {
           "ELEVENLABS_API_KEY": "YOUR_ACTUAL_KEY"  // 替换为真实 Key
         }
       },
       "godot": {
         "enabled": true,
         "env": {
           "GODOT_PATH": "C:\\Godot\\Godot_v4.6.1.exe"  // 替换为你的 Godot 路径
         }
       }
     }
   }
   ```

3. **创建输出目录**
   ```bash
   mkdir -p assets/sprites/generated
   mkdir -p assets/audio/generated
   ```

4. **验证配置**
   - 确保 JSON 格式正确
   - 确保所有启用的服务器都有有效的 API Key

---

## 4. 使用方法

### 在 OpenCode 中使用

#### 基本语法

```
你: [用 MCP名称] [执行的动作]
```

#### 示例 1: 生成像素角色

```
你: 用 PixelLab 生成一个像素风格的贪吃蛇角色，8x8 像素，绿色

AI: 正在调用 PixelLab MCP...
    ✅ 已生成资源：assets/sprites/generated/snake_8x8.png
    建议在 Godot 中创建 Sprite2D 节点并加载此贴图。
```

#### 示例 2: 生成音效

```
你: 用 ElevenLabs 生成吃食物的音效，清脆的叮声

AI: 正在调用 ElevenLabs MCP...
    ✅ 已生成音效：assets/audio/generated/eat_sound.wav
    可在代码中使用 AudioStreamPlayer 播放。
```

#### 示例 3: 创建场景

```
你: 用 Godot MCP 创建一个名为 Player 的新场景，根节点为 CharacterBody2D

AI: 正在调用 Godot MCP...
    ✅ 已创建场景：src/player/player.tscn
    场景已包含 CharacterBody2D 根节点。
```

### 常用命令参考

#### PixelLab 常用命令

| 命令 | 效果 |
|------|------|
| `用 PixelLab 生成一个 [描述] 的像素角色` | 创建角色 |
| `用 PixelLab 为角色 [ID] 添加行走动画` | 添加动画 |
| `用 PixelLab 生成 [主题] 瓦片集` | 创建瓦片 |

#### ElevenLabs 常用命令

| 命令 | 效果 |
|------|------|
| `用 ElevenLabs 生成 [描述] 的音效` | 创建音效 |
| `用 ElevenLabs 将 "[文本]" 转为语音` | 文本转语音 |
| `用 ElevenLabs 列出可用声音` | 查看声音列表 |

#### Godot MCP 常用命令

| 命令 | 效果 |
|------|------|
| `用 Godot MCP 创建场景 [名称]` | 创建场景 |
| `用 Godot MCP 在 [场景] 添加 [类型] 节点` | 添加节点 |
| `用 Godot MCP 运行项目` | 启动项目 |

---

## 5. 贪吃蛇项目示例

### 完整工作流程

#### Step 1: 生成视觉资源

```
你: 我正在开发贪吃蛇游戏，帮我生成所需的像素资源：
    - 蛇头：绿色，8x8 像素
    - 蛇身：绿色渐变，8x8 像素
    - 食物：红色苹果，8x8 像素
    - 特殊食物：金色星星，8x8 像素

AI: 正在批量生成...

✅ 已完成生成：
- assets/sprites/generated/snake_head_8x8.png
- assets/sprites/generated/snake_body_8x8.png
- assets/sprites/generated/food_apple_8x8.png
- assets/sprites/generated/food_star_8x8.png

下一步：在 Godot 中导入这些资源
```

#### Step 2: 生成音效

```
你: 再帮我生成游戏音效：
    - eat_normal：吃普通食物的清脆叮声
    - eat_special：吃特殊食物的欢快音效
    - game_over：游戏结束的低沉警告音

AI: 正在生成音效...

✅ 已完成生成：
- assets/audio/generated/eat_normal.wav
- assets/audio/generated/eat_special.wav
- assets/audio/generated/game_over.wav

音效建议：
- eat_normal: 短促清脆 (0.3-0.5秒)
- eat_special: 欢快愉悦 (0.5-1秒)
- game_over: 低沉警告 (1-2秒)
```

#### Step 3: 集成到项目

```
你: 帮我把这些资源集成到贪吃蛇项目中

AI: 好的！我来帮你更新代码。

1. 在 Godot 项目面板中导入资源
2. 更新 game.gd 使用 Sprite2D 替代 ColorRect
3. 添加音效播放器

代码更新示例：

```gdscript
# 更新蛇的显示
func create_snake_segment(pos: Vector2, is_head: bool):
    var sprite = Sprite2D.new()
    if is_head:
        sprite.texture = load("res://assets/sprites/generated/snake_head_8x8.png")
    else:
        sprite.texture = load("res://assets/sprites/generated/snake_body_8x8.png")
    sprite.position = pos * CELL_SIZE + Vector2(CELL_SIZE/2, CELL_SIZE/2)
    snake_container.add_child(sprite)

# 添加音效播放
func eat_food():
    var sound = AudioStreamPlayer.new()
    sound.stream = load("res://assets/audio/generated/eat_normal.wav")
    add_child(sound)
    sound.play()
    
    score += 10
    # ... 原有逻辑
```

需要我帮你应用这些更改吗？
```

#### Step 4: 测试验证

```
你: 运行游戏测试新资源

AI: 正在启动游戏...

观察结果：
✅ 蛇头显示像素图片
✅ 蛇身显示像素图片
✅ 食物显示苹果图片
✅ 吃食物播放音效

建议：
- 调整蛇的移动速度以匹配动画帧率
- 考虑添加粒子效果增强视觉体验
```

---

## 6. 常见问题 (FAQ)

### Q1: API Key 无效怎么办？

**可能原因**:
- API Key 复制错误（多余空格）
- API Key 过期
- 账户余额不足

**解决方法**:
1. 检查 `.opencode/mcp.json` 中的 API Key 格式
2. 重新从官网获取新的 API Key
3. 检查账户余额和套餐状态

### Q2: 连接失败怎么办？

**PixelLab 连接失败**:
```
检查网络连接
确认 URL 正确: https://api.pixellab.ai/mcp
检查 Authorization header 格式: "Bearer YOUR_TOKEN"
```

**ElevenLabs 连接失败**:
```bash
# 检查 uv 是否安装
uv --version

# 重新安装 uv
pip install uv

# 测试 MCP 连接
uvx elevenlabs-mcp --help
```

**Godot MCP 连接失败**:
```bash
# 检查 Node.js 版本
node --version  # 需要 >= 18

# 检查 Godot 路径
# Windows 示例
dir "C:\Godot\Godot_v4.6.1.exe"

# 测试 npx
npx @coding-solo/godot-mcp --help
```

### Q3: 依赖未安装怎么办？

**安装 Python 和 uv**:
```bash
# 安装 Python (如果没有)
# Windows: 从 python.org 下载安装
# Linux: sudo apt install python3

# 安装 uv
pip install uv
```

**安装 Node.js 和 npx**:
```bash
# 从 nodejs.org 下载安装 Node.js (包含 npm 和 npx)

# 验证安装
node --version
npm --version
npx --version
```

### Q4: Windows 开发者模式？

ElevenLabs MCP 在 Windows 上可能需要启用开发者模式：

1. 打开 Windows 设置
2. 隐私和安全性 → 开发者选项
3. 启用"开发人员模式"

### Q5: 生成的资源在哪里？

资源自动保存到：
- 像素图片: `assets/sprites/generated/`
- 音频文件: `assets/audio/generated/`

可在配置文件中修改 `output.directory`。

### Q6: 如何禁用某个 MCP 服务器？

在 `.opencode/mcp.json` 中设置 `enabled: false`:

```json
{
  "mcpServers": {
    "pixellab": {
      "enabled": false  // 禁用 PixelLab
    }
  }
}
```

---

## 7. 最佳实践

### 资源命名规范

```
像素资源:
- snake_head_8x8.png
- snake_body_8x8.png
- enemy_goblin_16x16.png
- tileset_grass_32x32.png

音效资源:
- sfx_eat_normal.wav
- sfx_eat_special.wav
- sfx_game_over.wav
- bgm_level_01.ogg
```

### 版本控制建议

1. **不要提交 API Keys**
   ```gitignore
   # .gitignore
   .opencode/mcp.json
   ```

2. **提交示例配置**
   ```bash
   git add .opencode/mcp.example.json
   ```

3. **提交生成的资源** (可选)
   ```bash
   git add assets/sprites/generated/
   git add assets/audio/generated/
   ```

### 批量生成策略

1. **一次请求多个资源**
   ```
   生成以下像素资源：
   1. 玩家角色 (16x16, 蓝色战士)
   2. 敌人角色 (16x16, 红色哥布林)
   3. NPC 角色 (16x16, 绿色村民)
   ```

2. **使用一致的风格描述**
   ```
   风格: 经典 JRPG 像素风格
   调色板: 16色复古
   尺寸: 16x16
   ```

3. **审核后使用**
   - 检查生成质量
   - 必要时重新生成
   - 记录成功的提示词

### 性能优化

1. **缓存 API Keys**
   - 使用环境变量
   - 避免频繁修改配置

2. **批量操作**
   - 一次生成多个资源
   - 减少网络请求

3. **资源压缩**
   - 像素图片使用 PNG
   - 音效使用 WAV 或 OGG

---

## 8. 参考链接

### 官方文档

| 服务 | 链接 | 说明 |
|------|------|------|
| PixelLab | https://pixellab.ai | AI 像素艺术平台 |
| PixelLab Dashboard | https://pixellab.ai/dashboard | API Key 管理 |
| ElevenLabs | https://elevenlabs.io | AI 音频平台 |
| ElevenLabs Docs | https://elevenlabs.io/docs | API 文档 |
| Godot MCP | https://github.com/Coding-Solo/godot-mcp | GitHub 仓库 |
| MCP 协议 | https://modelcontextprotocol.io | 协议规范 |

### 本项目相关文件

| 文件 | 路径 | 说明 |
|------|------|------|
| 配置模板 | `.opencode/mcp.example.json` | 示例配置 |
| 用户配置 | `.opencode/mcp.json` | 实际配置 (需创建) |
| 设置脚本 (Win) | `scripts/setup-mcp.ps1` | 一键配置 |
| 设置脚本 (Unix) | `scripts/setup-mcp.sh` | 一键配置 |
| 使用示例 | `docs/mcp/EXAMPLES_CN.md` | 更多示例 |
| 贪吃蛇教程 | `docs/tutorials/snake-tutorial.md` | 项目教程 |

### 社区资源

- [MCP 官方文档](https://modelcontextprotocol.io)
- [OpenCode GitHub](https://github.com/opencode-ai)
- [Godot 官方文档](https://docs.godotengine.org)

---

## 附录：完整配置示例

```json
{
  "$schema": "./mcp.example.json",
  "version": "1.0",
  "mcpServers": {
    "pixellab": {
      "type": "http",
      "url": "https://api.pixellab.ai/mcp",
      "description": "AI 像素艺术生成",
      "enabled": true,
      "headers": {
        "Authorization": "Bearer sk_xxxxxxxxxxxxx"
      },
      "output": {
        "directory": "assets/sprites/generated/",
        "format": "png"
      }
    },
    "elevenlabs": {
      "type": "command",
      "command": "uvx",
      "args": ["elevenlabs-mcp"],
      "description": "AI 音频/音乐生成",
      "enabled": true,
      "env": {
        "ELEVENLABS_API_KEY": "sk_xxxxxxxxxxxxx",
        "ELEVENLABS_MCP_OUTPUT_MODE": "files",
        "ELEVENLABS_API_RESIDENCY": "us"
      },
      "output": {
        "directory": "assets/audio/generated/",
        "format": "wav"
      }
    },
    "godot": {
      "type": "command",
      "command": "npx",
      "args": ["@coding-solo/godot-mcp"],
      "description": "Godot 项目控制",
      "enabled": true,
      "env": {
        "GODOT_PATH": "C:\\Godot\\Godot_v4.6.1.exe",
        "DEBUG": "false"
      }
    }
  },
  "globalSettings": {
    "timeout": 30000,
    "retryAttempts": 3,
    "logLevel": "info"
  }
}
```

---

> 💡 **提示**: 遇到问题？查看 [常见问题](#6-常见问题-faq) 或在项目中提出 Issue。

> 📝 **贡献**: 发现文档错误或有改进建议？欢迎提交 PR！