# OpenCode Game Studios - Godot 版

AI 驱动的 Godot 4.6.1 游戏开发框架。

**同时支持 GDScript 和 C#** - 可以单独使用一种语言，或在同一项目中混合使用。

[English](./README.md) | 中文文档

---

## 这是什么？

一套协调的 AI agent 系统，用于独立游戏开发：
- **17 个专业技能** 用于 Godot 游戏开发
- **自动化 hooks** 强制质量检查
- **路径范围规则** 编码标准

适配自 [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)。

---

## 快速开始 (5 分钟)

### 方式 A: 交互式引导
```
/start
```
系统检测你的状态并引导你。

### 方式 B: 手动步骤
```
1. /brainstorm "你的想法"      → 游戏概念
2. /setup-engine godot 4.6.1   → 引擎配置
3. /sprint-plan                → Sprint 规划
```

📖 **[完整教程 →](docs/tutorials/snake-tutorial.md)**

---

## 文档

| 文档 | 描述 |
|------|------|
| [SKILLS.md](docs/SKILLS.md) | 所有 17 个技能详细指南 |
| [WORKFLOW.md](docs/WORKFLOW.md) | 典型工作流程 |
| [QUICK-START.md](docs/QUICK-START.md) | 5 分钟入门 |
| [tutorials/](docs/tutorials/) | 实战教程 |

---

## 技能概览

| 分类 | Skills |
|------|--------|
| **领导核心** | `start`, `producer`, `technical-director` |
| **执行支持** | `godot-specialist`, `sprint-plan`, `art-coordinator`, `prototype-mode` |
| **设计支持** | `brainstorm`, `game-designer`, `design-review` |
| **深度技术** | `godot-gdscript`, `godot-csharp`, `godot-shader`, `godot-gdextension`, `code-review` |
| **顾问角色** | `creative-director`, `lead-programmer` |

> 详见 [docs/SKILLS.md](docs/SKILLS.md)

---

## 项目结构

```
.opencode/
├── skills/        → 17 个游戏开发技能
├── hooks/         → 自动化脚本
├── rules/         → 编码标准
└── docs/          → 模板和参考

src/               → 游戏代码 (GDScript, C#, C++)
assets/            → 美术、音效、特效
design/            → GDD、叙事
production/        → Sprint 计划、里程碑
prototypes/        → 一次性原型
tests/             → 测试套件
```

---

## 典型工作流

### Team Lead 周循环
```
周一: /sprint-plan review → 进度检查
周三: /art-coordinator → 美术同步
周五: /producer → 周总结
```

### 新功能开发
```
/design-review → 验证设计
/art-coordinator → 请求美术资产
/prototype-mode → 快速验证 (可选)
/technical-director → 架构检查
/godot-specialist → 实现
/code-review → 质量检查
```

---

## 功能特性

### Skills (18 个)
- Godot 专用: `godot-specialist`, `godot-gdscript`, `godot-csharp`, `godot-shader`, `godot-gdextension`
- 游戏开发核心: `creative-director`, `technical-director`, `producer`, `game-designer`, `lead-programmer`
- 工作流程: `start`, `brainstorm`, `setup-engine`, `sprint-plan`, `code-review`, `design-review`
- 新增: `art-coordinator`, `prototype-mode`

### 双语言支持
- **GDScript**: Godot 原生脚本，快速迭代
- **C#**: .NET 生态系统，复杂数据处理
- **混合使用**: 为每个系统选择合适的工具

### Hooks (4 个)
- Session 开始/结束 — 上下文加载
- Commit 验证 — 消息格式
- Asset 验证 — 命名约定

### Rules (3 个)
- GDScript 标准 — 静态类型、信号
- Gameplay 规则 — 游戏特定模式
- 通用规则 — 最佳实践

---

## 与 oh-my-openagent 集成

兼容 [oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)。

详见 [集成文档](https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/master/AGENTS.md)。

---

## 与 Claude-Code-Game-Studios 的主要区别

| 原版 | 本版本 |
|------|--------|
| `.claude/` 目录 | `.opencode/` 目录 |
| CLAUDE.md | OPENCODE.md |
| 48 个 agents | 17 个专注技能 |
| 多引擎支持 | Godot 专注 |

---

## 贡献

见原项目: [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)

---

## 许可证

MIT License