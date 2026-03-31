# OpenCode Game Studios - Godot 版

一个全面的游戏开发框架，从 [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) 适配到 OpenCode，主要支持 Godot 4。

[English](./README.md) | 中文文档

---

## 目录

- [功能特性](#功能特性)
- [快速开始](#快速开始)
- [技能指南](#技能指南)
- [Agent 与技能工作流程](#agent-与技能工作流程)
- [与 oh-my-openagent 集成](#与-oh-my-openagent-集成)
- [Hooks 与 Rules](#hooks-与-rules)
- [项目结构](#项目结构)

---

## 功能特性

### 技能（共15个）

| 类别 | 技能 | 用途 |
|------|------|------|
| **Godot专用** | `godot-specialist`, `godot-gdscript`, `godot-shader`, `godot-gdextension` | 引擎架构、脚本、着色器、原生绑定 |
| **游戏开发核心** | `creative-director`, `technical-director`, `producer`, `game-designer`, `lead-programmer` | 视觉方向、架构、计划、设计、代码管理 |
| **工作流程** | `start`, `brainstorm`, `setup-engine`, `sprint-plan`, `code-review`, `design-review` | 入门引导、创意、设置、冲刺计划、评审 |

### Hooks（4个自动化脚本）
- Session 开始/结束 hooks — 上下文加载和日志记录
- Commit 验证 — 消息格式和 TODO 检查
- Asset 验证 — 命名约定和 JSON 结构

### Rules（3个编码标准）
- GDScript 标准 — 静态类型、命名、信号
- Gameplay 代码规则 — 游戏特定模式
- 通用编码规则 — 通用最佳实践

---

## 快速开始

### 步骤1：入门引导（新项目）

```
调用 'start' 技能
```

`start` 技能会询问你在游戏开发旅程中的当前位置：

| 选项 | 描述 | 推荐下一步 |
|------|------|-----------|
| **A) 还没有想法** | 从零开始 | `/brainstorm` 进行创意探索 |
| **B) 有模糊想法** | 大致主题或类型 | `/brainstorm "你的想法"` 来发展它 |
| **C) 有清晰概念** | 知道核心理念，需要文档 | `/setup-engine` → `/sprint-plan` |
| **D) 已有工作** | 已有文档/原型/代码 | 根据发现的缺口继续 |

### 步骤2：游戏概念开发

```
调用 'brainstorm' 技能，传入你的想法
```

**调用模式：**
- `/brainstorm` — 开放探索，发现你的游戏概念
- `/brainstorm "太空探索 roguelike"` — 发展特定想法
- `/brainstorm open` — 最大开放度接受新想法

**产出内容：**
- 游戏概念文档位于 `design/gdd/game-concept.md`
- 设计支柱（3-5个基本原则）
- 核心循环定义
- 规模评估（jam/small/medium/large）
- 引擎推荐

### 步骤3：引擎设置

```
调用 'setup-engine' 技能
```

**调用模式：**
- `/setup-engine` — 有引导的设置，会提问
- `/setup-engine godot 4.3` — 直接指定版本

**创建内容：**
- 更新 `OPENCODE.md` 的技术栈部分
- 创建 `.opencode/docs/technical-preferences.md`
- 创建 `.opencode/docs/engine-reference/godot/VERSION.md`
- 设置项目目录结构（`src/`、`assets/`、`design/` 等）

### 步骤4：冲刺计划

```
调用 'sprint-plan' 技能
```

**调用模式：**
- `/sprint-plan` — 创建新冲刺
- `/sprint-plan review` — 评审当前冲刺进度
- `/sprint-plan complete` — 标记冲刺完成

**产出内容：**
- 冲刺文档位于 `production/sprints/sprint-[N]-[date].md`
- 任务分解，包含估算和负责人
- 风险评估和依赖追踪

---

## 技能指南

### Godot 专用技能

#### `godot-specialist`

**用途：** Godot 模式、API 和优化的权威。指导 GDScript vs C# vs GDExtension 决策。

**何时使用：**
- 为功能选择语言（GDScript、C# 或 GDExtension）
- 设计新系统的场景/节点架构
- 设置输入映射、Autoload 或项目设置
- 配置任意平台的导出预设
- 优化渲染、物理或内存

**如何调用：**
```
调用 'godot-specialist' 技能来解决 [你的问题]
```

**核心能力：**
- 场景/节点架构指导（组合优于继承）
- GDScript 标准（静态类型、信号、资源）
- 性能最佳实践
- 语言决策矩阵

---

#### `godot-gdscript`

**用途：** GDScript 专家，负责代码质量、静态类型、信号和优化。

**何时使用：**
- 在整个代码库中强制静态类型
- 设计解耦的信号架构
- 优化 GDScript 性能
- 遵循 GDScript 特定的惯用模式和模式

**如何调用：**
```
调用 'godot-gdscript' 技能获取 GDScript 模式和优化
```

**核心能力：**
- 静态类型强制（`var health: int = 100`）
- 信号模式（类型化参数、连接最佳实践）
- 使用 `await` 的协程模式
- 性能优化（最小化 `_process`、缓存）

---

#### `godot-shader`

**用途：** Godot 4 中的着色器、VFX、粒子系统和渲染优化。

**何时使用：**
- 编写自定义着色器（spatial、canvas_item、particles）
- 创建可视化着色器图
- 后处理效果
- 粒子系统设计
- 渲染优化

**如何调用：**
```
调用 'godot-shader' 技能进行着色器开发
```

---

#### `godot-gdextension`

**用途：** 高性能模块的 C++/Rust 原生绑定。

**何时使用：**
- 创建自定义原生节点
- 性能关键代码（>1000 次/帧调用）
- 重度数学运算（寻路、物理）
- 集成外部 C++/Rust 库

**如何调用：**
```
调用 'godot-gdextension' 技能进行原生扩展开发
```

---

### 游戏开发核心技能

#### `creative-director`

**用途：** 游戏视觉、支柱和创意方向的守护者。

**何时使用：**
- 定义设计支柱和核心视觉
- 解决竞争设计选项之间的冲突
- 维护基调、感觉和身份一致性
- 防止功能蔓延

**如何调用：**
```
调用 'creative-director' 技能进行视觉和支柱决策
```

**核心能力：**
- 支柱定义和冲突解决
- 基调和身份管理
- MDA 框架应用
- 视觉一致性检查

---

#### `technical-director`

**用途：** 技术视觉、架构决策和技术选择。

**何时使用：**
- 制定架构决策记录（ADR）
- 定义系统架构模式
- 设置性能预算
- 管理技术债务
- 构建/CI 策略

**如何调用：**
```
调用 'technical-director' 技能进行架构决策
```

---

#### `producer`

**用途：** 进度、资源、范围和团队协调。

**何时使用：**
- 计划冲刺和里程碑
- 管理范围和功能优先级
- 追踪进度和识别阻塞点
- 风险评估和缓解

**如何调用：**
```
调用 'producer' 技能进行进度安排和计划
```

---

#### `game-designer`

**用途：** 机制、系统、进度、经济和玩家体验。

**何时使用：**
- 设计游戏机制和系统
- 创建进度和经济系统
- 平衡游戏元素
- 编写设计文档（GDD）

**如何调用：**
```
调用 'game-designer' 技能进行系统和机制设计
```

---

#### `lead-programmer`

**用途：** 代码架构、评审、标准和编程团队协调。

**何时使用：**
- 定义系统架构和编码标准
- 领导代码评审
- 管理技术债务和 API 边界
- 实现协调

**如何调用：**
```
调用 'lead-programmer' 技能进行代码架构
```

---

### 工作流程技能

#### `start`

**用途：** 有引导的入门 — 询问你的位置，然后路由到正确的工作流程。

**调用方式：**
```
调用 'start' 技能
```

**工作流程：**
1. 静默检测项目状态
2. 询问：没有想法 / 模糊 / 清晰概念 / 已有工作？
3. 路由到适当的下一个技能
4. 确认后再继续

---

#### `brainstorm`

**用途：** 使用 MDA、玩家心理学、动词优先设计探索游戏想法。

**调用模式：**
| 命令 | 用途 |
|------|------|
| `/brainstorm` | 开放探索 |
| `/brainstorm "你的想法"` | 发展特定概念 |
| `/brainstorm open` | 最大开放度 |

**输出：** `design/gdd/game-concept.md`

---

#### `setup-engine`

**用途：** 配置引擎和技术偏好。

**调用模式：**
| 命令 | 用途 |
|------|------|
| `/setup-engine` | 有引导的设置 |
| `/setup-engine godot 4.3` | 指定版本 |

**输出：** 技术偏好文档、引擎参考文档、项目结构

---

#### `sprint-plan`

**用途：** 计划冲刺，包含任务分解和估算。

**调用模式：**
| 命令 | 用途 |
|------|------|
| `/sprint-plan` | 创建新冲刺 |
| `/sprint-plan review` | 评审当前冲刺 |
| `/sprint-plan complete` | 标记冲刺完成 |

**输出：** `production/sprints/sprint-[N]-[date].md`

---

#### `code-review`

**用途：** 评审代码质量、模式、性能，提供结构化反馈。

**调用模式：**
| 命令 | 用途 |
|------|------|
| `/code-review` | 评审最近变更 |
| `/code-review src/player/` | 评审目录 |
| `/code-review player.gd` | 评审特定文件 |

**输出：** 结构化报告，包含严重级别（阻塞/重要/建议）

---

#### `design-review`

**用途：** 评审设计文档，验证支柱一致性。

**调用模式：**
| 命令 | 用途 |
|------|------|
| `/design-review` | 评审所有设计文档 |
| `/design-review combat.md` | 评审特定文档 |
| `/design-review --system combat` | 评审特定系统 |

---

## Agent 与技能工作流程

### 理解 OpenCode 的 Agent 系统

OpenCode 使用分层 agent 系统处理不同任务：

#### 主要 Agent

| Agent | 用途 | 何时使用 |
|-------|------|----------|
| **Build** | 全开发，所有工具可用 | 实现、文件编辑、命令执行 |
| **Plan** | 分析，不修改文件 | 计划、评审建议 |

#### 子 Agent（后台任务）

| Agent | 用途 | 何时使用 |
|-------|------|----------|
| **explore** | 只读代码库探索 | 查找模式、定位文件、理解结构 |
| **librarian** | 外部文档查找 | 库文档、API 参考、开源示例 |
| **oracle** | 只读咨询 | 架构决策、调试、复杂逻辑 |
| **metis** | 预计划分析 | 范围澄清、歧义解决 |
| **momus** | 专家评审 | 计划评估、质量保证 |

#### 任务类别（领域优化）

| 类别 | 最适合 | 示例任务 |
|------|--------|----------|
| `visual-engineering` | UI、着色器、VFX、样式 | UI 组件、可视化着色器 |
| `ultrabrain` | 困难逻辑、算法 | 寻路、复杂系统 |
| `deep` | 自主问题解决 | 多模块重构 |
| `artistry` | 创意方法 | 游戏概念开发 |
| `quick` | 小修复 | 错别字、简单配置变更 |
| `writing` | 文档 | README、GDD、技术文档 |

### 游戏开发任务的典型工作流程

```
1. 开始：定义你的任务
   ↓
2. 计划：使用 plan agent 进行工作分解
   ↓
3. 探索：启动 explore/librarian agent（后台）获取上下文
   ↓
4. 执行：委派给适当的类别 agent
   ↓
5. 评审：使用 oracle/momus 进行质量检查
   ↓
6. 验证：运行测试、诊断、手动 QA
```

### 何时调用技能 vs Agent

| 场景 | 使用 | 示例 |
|------|------|------|
| 需要专业知识 | **技能** | Godot 模式 → `godot-specialist` 技能 |
| 需要代码库探索 | **Agent** | 查找认证模式 → `explore` agent |
| 需要外部文档 | **Agent** | JWT 安全 → `librarian` agent |
| 需要架构评审 | **Agent** | 系统设计 → `oracle` agent |
| 需要实现 | **类别任务** | UI 组件 → `visual-engineering` |

### 快速调用指南

**技能（专业知识）：**
```
调用 'godot-specialist' 技能
调用 'game-designer' 技能进行经济设计
使用 'code-review' 技能评审 src/player/
```

**Agent（研究/探索）：**
```
task(subagent_type="explore", prompt="查找认证模式...")
task(subagent_type="librarian", prompt="搜索 JWT 安全最佳实践...")
task(subagent_type="oracle", prompt="评审我的架构方案...")
```

**类别任务（实现）：**
```
task(category="visual-engineering", load_skills=["frontend-ui-ux"], prompt="...")
task(category="ultrabrain", load_skills=["godot-gdscript"], prompt="...")
```

---

## 与 oh-my-openagent 集成

### 兼容性概述

**是的，OpenCode Game Studios 可以与 oh-my-openagent (OMO) 集成。**

oh-my-openagent 是一个开源 AI agent 框架，具有多模型编排能力，特点包括：
- **技能嵌入架构**：技能中的 YAML frontmatter（与 OpenCode 的技能格式一致）
- **MCP 架构**：三层系统（内置、Claude Code 兼容、技能嵌入）
- **Agent 模型**：Sisyphus、Atlas、oracle、librarian、explore — 与 OpenCode 类似的角色

### 集成路径

两个系统共享兼容的概念：

| OpenCode 概念 | oh-my-openagent 对应 |
|---------------|---------------------|
| 技能（YAML frontmatter） | 技能嵌入定义 |
| explore/librarian agent | 类似角色的 agent 模型 |
| 任务委派 | MCP 编排 |

### 推荐集成模式

**模式 A：技能桥接**
- 在技能注册表中将 OpenCode 技能定义为 OMO 技能
- 允许 OMO agent（librarian、explore）调用 OpenCode 技能

**模式 B：编排层**
- 使用 OMO 的 MCP + Claude Code 兼容层
- 将 OpenCode 任务流建模为 OMO 工具序列

### 关键参考

- oh-my-openagent GitHub：https://github.com/code-yeongyu/oh-my-openagent
- AGENTS.md 架构：https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/master/AGENTS.md
- npm 包：https://registry.npmjs.org/oh-my-openagent

### 集成下一步

1. **创建 AGENTS.md 条目** 用于 OpenCode–OMO 桥接
2. **映射技能定义** 在两个系统之间
3. **测试编排** 使用示例任务流
4. **文档约定** 用于跨系统使用

---

## Hooks 与 Rules

### Hooks（自动化脚本）

| Hook | 触发时机 | 用途 |
|------|----------|------|
| `session-start.sh` | Session 开始 | 加载冲刺上下文、显示 git 活动、检查项目缺口 |
| `session-stop.sh` | Session 结束 | 记录成果、更新 session 历史 |
| `validate-commit.sh` | 提交前 | 检查提交消息格式、验证 TODO |
| `validate-assets.sh` | 资产文件写入后 | 验证命名、JSON 结构、资源引用 |

### Rules（编码标准）

| 规则文件 | 适用范围 | 强制内容 |
|----------|----------|----------|
| `gdscript.md` | `**/*.gd` | 静态类型、命名约定、节点引用、信号 |
| `gameplay.md` | `src/gameplay/**` | 游戏特定模式 |
| `rules.md` | 所有代码 | 通用最佳实践 |

### 关键 GDScript 规则

```gdscript
# ✅ 正确 - 静态类型
var health: int = 100
func take_damage(amount: int) -> void:
    pass

# ❌ 错误 - 无类型
var health = 100
func take_damage(amount):
    pass
```

---

## 项目结构

```
.opencode/
├── skills/              # 15 个游戏开发技能
│   ├── godot-specialist/
│   ├── godot-gdscript/
│   ├── godot-shader/
│   ├── godot-gdextension/
│   ├── creative-director/
│   ├── technical-director/
│   ├── producer/
│   ├── game-designer/
│   ├── lead-programmer/
│   ├── start/
│   ├── brainstorm/
│   ├── setup-engine/
│   ├── sprint-plan/
│   ├── code-review/
│   └── design-review/
├── hooks/               # 自动化脚本
├── rules/               # 路径范围的编码标准
└── docs/                # 文档和模板

design/gdd/              # 游戏设计文档
production/              # 冲刺计划和里程碑
src/                     # 游戏源代码（GDScript、C#、C++）
assets/                  # 游戏资产（精灵、音频等）
tests/                   # 测试套件（GUT for Godot）
prototypes/              # 临时原型
```

---

## 与 Claude-Code-Game-Studios 的主要区别

| 原版 | 适配版 |
|------|--------|
| `.claude/` 目录 | `.opencode/` 目录 |
| CLAUDE.md | OPENCODE.md |
| 48 个 agent | 15 个专注技能 |
| 完整 Unity/Unreal 支持 | Godot 专注 |
| Claude 特定格式 | OpenCode 技能格式 |

---

## 贡献

这是 Claude-Code-Game-Studios 的适配版。原项目见：
https://github.com/Donchitos/Claude-Code-Game-Studios

---

## 许可证

MIT 许可证 - 详情见原项目。