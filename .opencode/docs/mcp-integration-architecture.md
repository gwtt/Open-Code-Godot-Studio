# MCP 整合架构文档

> AI 驱动的 Godot 游戏开发工作流整合方案

---

## 概述

本文档描述如何将 AI 图片生成 (PixelLab) 和音频生成 (ElevenLabs) MCP 服务整合到 Godot 游戏开发工作流中，实现端到端的 AI 驱动资产生成。

---

## 架构设计

### 核心理念

**Godot MCP 作为控制中心**，协调 AI 生成服务和 Godot 编辑器操作。

```
用户请求 → OpenCode Agent
    ↓
┌─────────────────────────────────────────┐
│          Godot MCP (控制中心)            │
│  ┌─────────────┐    ┌─────────────────┐ │
│  │ PixelLab    │    │ ElevenLabs      │ │
│  │ (图片生成)   │    │ (音频生成)       │ │
│  └─────────────┘    └─────────────────┘ │
└─────────────────────────────────────────┘
    ↓
验证 → assets/sprites/generated/ 或 assets/audio/generated/
    ↓
自动导入 Godot 场景 (autoApprove: load_sprite, create_scene)
    ↓
Skill 更新 → art-coordinator 确认, sprint-plan 跟踪
```

### MCP 服务角色

| MCP 服务 | 角色 | 主要工具 |
|----------|------|----------|
| **Godot MCP** | 控制中心 | `create_scene`, `add_node`, `load_sprite`, `run_project` |
| **PixelLab** | 图片生成 | `create_character`, `create_tileset`, `create_map_object` |
| **ElevenLabs** | 音频生成 | `text_to_sound_effects`, `compose_music`, `text_to_speech` |

---

## 配置指南

### 1. MCP 服务配置

编辑 `.opencode/mcp.json`:

```json
{
  "mcpServers": {
    "pixellab": {
      "enabled": true,
      "type": "remote",
      "url": "https://api.pixellab.ai/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_PIXELLAB_TOKEN"
      }
    },
    "elevenlabs": {
      "enabled": true,
      "type": "local",
      "command": ["uvx", "elevenlabs-mcp"],
      "environment": {
        "ELEVENLABS_API_KEY": "YOUR_ELEVENLABS_KEY"
      }
    },
    "godot": {
      "enabled": true,
      "type": "local",
      "command": ["npx", "@coding-solo/godot-mcp"],
      "environment": {
        "GODOT_PATH": "${GODOT_PATH}"
      },
      "autoApprove": [
        "load_sprite",
        "create_scene",
        "add_node",
        "save_scene"
      ]
    }
  }
}
```

### 2. 环境变量设置

**Windows (PowerShell)**:
```powershell
$env:GODOT_PATH = "C:\Godot\Godot_v4.6.1-stable_win64.exe"
$env:ELEVENLABS_API_KEY = "your-api-key"
```

**Linux/macOS**:
```bash
export GODOT_PATH="/usr/bin/godot4"
export ELEVENLABS_API_KEY="your-api-key"
```

### 3. 一键配置脚本

运行项目提供的配置脚本:

```powershell
# Windows
.\scripts\setup-mcp.ps1

# Linux/macOS
chmod +x scripts/setup-mcp.sh
./scripts/setup-mcp.sh
```

---

## 工作流程

### 图片资产生成流程

```
1. 用户: "/art-coordinator AI 生成角色"
    ↓
2. art-coordinator: 定义规格 (16x16, 4方向, 像素风)
    ↓
3. 调用 PixelLab MCP:
   pixellab_create_character({
     description: "16x16 pixel knight, top-down, 4 directions",
     n_directions: 4,
     size: 16
   })
    ↓
4. 输出: assets/sprites/generated/char_knight_16x16.png
    ↓
5. 验证: 尺寸、风格、命名
    ↓
6. 可选: Godot MCP 自动导入
   godot_load_sprite({
     scenePath: "Scenes/Player.tscn",
     nodePath: "Sprite2D",
     texturePath: "assets/sprites/generated/char_knight_16x16.png"
   })
    ↓
7. 更新 sprint-plan: 标记资产完成
```

### 音频资产生成流程

```
1. 用户: "/art-coordinator AI 生成跳跃音效"
    ↓
2. art-coordinator: 定义规格 (0.5秒, 欢快, 卡通风格)
    ↓
3. 调用 ElevenLabs MCP:
   elevenlabs_text_to_sound_effects({
     text: "cartoon jump sound, quick whoosh, playful",
     duration_seconds: 0.5
   })
    ↓
4. 输出: assets/audio/generated/sfx_jump_01.wav
    ↓
5. 验证: 时长、风格、音质
    ↓
6. 更新 sprint-plan: 标记资产完成
```

---

## 时间估算对比

### AI 驱动 vs 人工创作

| 资产类型 | AI 驱动 | 人工创作 | 效率提升 |
|----------|---------|----------|----------|
| Sprite (角色) | 30秒-3分钟 | 2-8小时 | **90%+** |
| Sprite (道具) | 15秒-1分钟 | 1-4小时 | **95%+** |
| UI 元素 | 10秒-30秒 | 0.5-2小时 | **95%+** |
| Tileset | 30秒-3分钟 | 2-8小时 | **90%+** |
| 音效 | 15秒-1分钟 | 0.5-2小时 | **95%+** |
| 音乐循环 | 30秒-3分钟 | 2-8小时 | **90%+** |

### 估算包含的内容

**AI 驱动估算包含**:
- ✅ 提示词编写时间
- ✅ MCP 调用等待时间
- ✅ 结果验证时间
- ✅ 重命名和移动时间
- ✅ 质量检查时间

**人工创作估算包含**:
- ✅ 设计和草图时间
- ✅ 制作和修改时间
- ✅ 反馈和调整时间
- ✅ 最终交付时间

---

## Skills 整合

### art-coordinator Skill

**新增 Phase 3B: AI-Driven Generation**

触发条件: MCP 服务已启用

流程:
1. 检查 MCP 状态
2. 定义资产规格
3. 调用 MCP 工具
4. 验证生成结果
5. 自动化导入 (可选)
6. 更新项目文档

### sprint-plan Skill

**新增估算模式选择**

选项:
- A) AI 驱动 (秒级估算) — MCP 已启用时推荐
- B) 人工创作 (小时级估算) — 混合团队场景
- C) 混合模式 — 部分资产 AI，部分人工

动态选择:
- 自动检测 MCP 状态
- 根据用户偏好选择模式
- 在 Sprint 文档中标注生成模式

---

## 最佳实践

### 提示词编写技巧

**图片生成提示词**:
```
✅ 好的提示词:
"16x16 pixel art knight character, top-down view, 4 directions (up/down/left/right), 
medieval fantasy style, shiny armor, red cape, detailed helmet"

❌ 不好的提示词:
"knight"  // 太模糊，无法控制输出
```

**音频生成提示词**:
```
✅ 好的提示词:
"cartoon jump sound effect, quick whoosh sound, playful and energetic, 
0.5 seconds, 8-bit game style"

❌ 不好的提示词:
"jump sound"  // 缺乏风格和时长信息
```

### 命名规范

**自动生成的文件应遵循项目命名规范**:

| 资产类型 | 命名格式 | 示例 |
|----------|----------|------|
| Sprite | `[type]_[name]_[variant].png` | `char_knight_16x16.png` |
| UI | `ui_[element]_[state].png` | `ui_button_hover.png` |
| 音效 | `sfx_[action]_[variant].wav` | `sfx_jump_01.wav` |
| 音乐 | `music_[location]_[mood].ogg` | `music_forest_calm.ogg` |

### 质量检查清单

生成后必须验证:
- [ ] 尺寸是否符合规格
- [ ] 风格是否一致
- [ ] 命名是否正确
- [ ] 文件格式是否正确
- [ ] Godot 导入是否成功
- [ ] 游戏内显示是否正常

---

## 故障排除

### 常见问题

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| MCP 服务连接失败 | API Key 无效或网络问题 | 检查 API Key，确认网络连接 |
| 生成质量不满意 | 提示词不够具体 | 调整提示词，添加更多细节 |
| 资产导入失败 | 路径不正确 | 使用 `res://` 路径，检查目录结构 |
| 时间估算不准 | 未考虑验证时间 | 增加 20% buffer |
| 风格不一致 | 提示词风格描述不一 | 使用统一的风格词汇表 |

### 回退方案

**IF MCP 服务不可用**:
1. 回退到人工创作模式
2. 使用 sprint-plan 的人工估算
3. 创建传统资产请求文档

---

## 参考资源

### MCP 官方文档
- [MCP 协议规范](https://modelcontextprotocol.info/specification/)
- [MCP 最佳实践](https://modelcontextprotocol.info/docs/best-practices/)
- [MCP 服务生态](https://modelcontextprotocol.info/docs/examples/)

### 项目内部文档
- [MCP 配置指南](.opencode/docs/mcp-setup-guide.md)
- [MCP 使用示例](docs/mcp/EXAMPLES_CN.md)
- [贪吃蛇教程 (含 MCP)](docs/tutorials/snake-tutorial.md)

### MCP 服务
- [PixelLab 官网](https://pixellab.ai)
- [ElevenLabs 官网](https://elevenlabs.io)
- [Godot MCP](https://github.com/Coding-Solo/godot-mcp)

---

## 更新日志

### 2026-04-03
- 初始版本创建
- 添加 AI 驱动估算模式
- 整合 art-coordinator 和 sprint-plan skills
- 定义 MCP 整合架构

---

## 下一步

1. **启用 MCP 服务**: 运行 `scripts/setup-mcp.ps1`
2. **测试生成流程**: 使用 `/art-coordinator AI 生成资产`
3. **校准时间估算**: 记录实际生成时间，调整估算表
4. **建立风格词汇表**: 创建项目特定的提示词模板

---

> 本文档与 `sprint-plan` 和 `art-coordinator` skills 同步更新。如有冲突，以 skills 文件为准。