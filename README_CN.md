# OpenCode Game Studios - Godot 版

AI 驱动的 Godot 4.6.1 游戏开发框架。

**C# 为主语言**，可选 GDScript - AI 模型对 C# 的代码生成质量更好。

[English](./README.md) | 中文文档

---

## 这是什么？

一套协调的 AI agent 系统，用于独立游戏开发：
- **19 个专业技能** 用于 Godot 游戏开发
- **自动化 hooks** 强制质量检查
- **路径范围规则** 编码标准

适配自 [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)。

---

## 快速开始 (5 分钟)

### 🚀 应用到你的项目

**Step 1: 克隆本项目**
```bash
git clone https://github.com/gwtt/Open-Code-Godot-Studio.git
```

**Step 2: 复制到你的项目**
```bash
# 复制框架到你的 Godot 项目
cp -r Open-Code-Godot-Studio/.opencode/ 你的项目/.opencode/

# 复制 OPENCODE.md（AI 入口配置）
cp Open-Code-Godot-Studio/OPENCODE.md 你的项目/OPENCODE.md
```

**Step 3: 更新你的版本**

编辑 `OPENCODE.md`，修改你的 Godot 版本：
```markdown
## Technology Stack
- **Engine**: Godot 4.x  ← 改成你的版本
```

**Step 4: 在 OpenCode 中使用**

在 OpenCode 中打开你的项目，运行：
```
/start
```

完成！你的项目现在拥有 19 个 Godot AI Skills。

> **你复制的内容:**
> - `.opencode/` — Skills、hooks、rules、engine reference
> - `OPENCODE.md` — AI 入口配置

---

### 📁 最小必需文件

如果你只需要核心功能：

```
你的项目/.opencode/
├── skills/     # 必须 — 19 个 Godot Skills
├── hooks/      # 推荐 — 自动化脚本
└── rules/      # 推荐 — 编码标准
```

---

### 🎯 你将获得

| 组件 | 数量 | 用途 |
|------|------|------|
| **Skills** | 19 个 | Godot 专用 AI 代理 |
| **Hooks** | 4 个 | 自动化（session、commit、asset） |
| **Rules** | 3 个 | 编码标准（GDScript、C#） |
| **Engine Reference** | 12 个文档 | API 更新参考（4.4-4.6） |

---

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
| [SKILLS.md](docs/SKILLS.md) | 所有 19 个技能详细指南 |
| [WORKFLOW.md](docs/WORKFLOW.md) | 典型工作流程 |
| [QUICK-START.md](docs/QUICK-START.md) | 5 分钟入门 |
| [tutorials/](docs/tutorials/) | 实战教程 |

---

## 技能概览

| 分类 | Skills |
|------|--------|
| **领导核心** | `start`, `producer`, `technical-director` |
| **执行支持** | `godot-specialist`, `sprint-plan`, `art-coordinator`, `prototype-mode`, `player-evaluator` |
| **设计支持** | `brainstorm`, `game-designer`, `design-review` |
| **深度技术** | `godot-gdscript`, `godot-csharp`, `godot-shader`, `godot-gdextension`, `code-review` |
| **顾问角色** | `creative-director`, `lead-programmer` |

> 详见 [docs/SKILLS.md](docs/SKILLS.md)

---

## 项目结构

```
.opencode/
├── skills/        → 19 个游戏开发技能
├── hooks/         → 自动化脚本
├── rules/         → 编码标准
└── docs/          → 模板和参考

src/               → 游戏代码 (C# 为主，GDScript 可选，C++ 用于 GDExtension)
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

### Skills (19 个)
- Godot 专用: `godot-specialist`, `godot-gdscript`, `godot-csharp`, `godot-shader`, `godot-gdextension`
- 游戏开发核心: `creative-director`, `technical-director`, `producer`, `game-designer`, `lead-programmer`
- 工作流程: `start`, `brainstorm`, `setup-engine`, `sprint-plan`, `code-review`, `design-review`
- 设计验证: `player-evaluator` (多视角 GDD 评估)
- 新增: `art-coordinator`, `prototype-mode`, `player-evaluator`

### 语言支持
- **C# (主语言)**: .NET 生态系统，更好的 AI 代码生成，复杂数据处理
- **GDScript (可选)**: Godot 原生脚本，快速原型开发
- **GDExtension**: 性能关键的本地代码 (C++/Rust)

### Hooks (4 个)
- Session 开始/结束 — 上下文加载
- Commit 验证 — 消息格式
- Asset 验证 — 命名约定

### Rules (3 个)
- C# 标准 — .NET 8 模式、Godot C# API
- GDScript 标准 — 静态类型、信号
- Gameplay 规则 — 游戏特定模式

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
| 48 个 agents | 19 个专注技能 |
| 多引擎支持 | Godot 专注 |

---

## 贡献

见原项目: [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)

---

## 许可证

MIT License

---

## 快速总结

```bash
# 1. 克隆
git clone https://github.com/gwtt/Open-Code-Godot-Studio.git

# 2. 复制到你的项目
cp -r Open-Code-Godot-Studio/.opencode/ 你的项目/
cp Open-Code-Godot-Studio/OPENCODE.md 你的项目/

# 3. 修改 OPENCODE.md 中的版本号
# 4. 在 OpenCode 中运行 /start
```