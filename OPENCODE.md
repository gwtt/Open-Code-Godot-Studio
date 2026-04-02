# OpenCode Game Studios - Godot Edition

AI agent context for Godot 4.6.1 game development.

---

## Technology Stack

- **Engine**: Godot 4.6.1
- **Languages**: GDScript + C# (dual support)
- **Performance**: GDExtension (C++/Rust) when needed
- **Version Control**: Git

---

## Project Structure

```
.opencode/    → Skills, hooks, rules, docs
src/          → Game code (GDScript, C#, C++)
assets/       → Art, audio, VFX
design/       → GDDs, narrative
production/   → Sprint plans
prototypes/   → Throwaway prototypes
tests/        → Test suites
```

---

## Key References

- @.opencode/docs/technical-preferences.md — Technology decisions
- @.opencode/docs/coding-standards.md — GDScript/C# rules
- @.opencode/docs/coordination-rules.md — Agent coordination
- @.opencode/docs/engine-reference/godot/ — **Godot API 更新参考** (填补 LLM 知识空白)

---

## Engine Reference (LLM Knowledge Gap)

Godot 4.4-4.6 的 API 变化不在 LLM 训练数据中（知识截止 May 2025）。

**关键文档：**

| 文档 | 用途 |
|------|------|
| `VERSION.md` | 版本信息 + LLM 知识截止点 |
| `breaking-changes.md` | 4.3→4.6 版本变更详情 |
| `deprecated-apis.md` | 废弃 API + 替代方案表 |
| `current-best-practices.md` | 新最佳实践（Jolt、D3D12 等） |
| `modules/*.md` | 8 个子系统快速参考 |

**Agent 使用流程：**
1. 检查 `deprecated-apis.md` → 避免使用废弃 API
2. 参考 `breaking-changes.md` → 了解版本变更
3. 查阅 `modules/*.md` → 快速获取子系统 API 模式

---

## Available Skills (18) - 3-Tier Architecture

### Tier 1: Directors (战略决策)
`creative-director` `technical-director` `producer` `start`

**Role**: 项目方向、范围控制、技术愿景

### Tier 2: Leads (领域领导 + 委托)
`godot-specialist` `lead-programmer` `sprint-plan` `art-coordinator` `prototype-mode`

**Role**: 领域专家，负责委托给 Specialists

**godot-specialist Dispatcher**: 中央调度器，委托 Godot 技术到 sub-skills

### Tier 3: Specialists (深度技术)
`godot-gdscript` `godot-csharp` `godot-shader` `godot-gdextension` `code-review`

**Role**: 特定技术领域的详细实现

### Support: Consultants (顾问支持)
`brainstorm` `game-designer` `design-review` `setup-engine`

**Role**: 概念探索、设计验证、引擎配置

---

### Tier Collaboration Flow

```
User → Directors (决策方向)
    → Leads (领域匹配)
    → Specialists (具体实现)
```

**规则**: Specialists 先横向咨询同级，再向上升级到 Leads

> 详见 [docs/SKILLS.md](docs/SKILLS.md) 和 [coordination-rules.md](.opencode/docs/coordination-rules.md)

---

## Agent Categories

| Category | Best For |
|----------|----------|
| `visual-engineering` | UI, shaders, VFX |
| `ultrabrain` | Hard logic, algorithms |
| `deep` | Autonomous problem-solving |
| `quick` | Trivial fixes |

Load skills: `task(category="...", load_skills=["godot-gdscript"], prompt="...")`

---

## Collaboration Protocol

**User-driven**: Question → Options → Decision → Draft → Approval

- Ask before writing files
- Show drafts before approval
- No commits without user instruction

---

## 如何将此框架用于你的 OpenCode 项目

这是一个完整的 **Godot AI Agent + Skills 工作流框架**。你可以直接应用到你的项目中。

### 📦 复制到你的项目

**方法 1：复制 `.opencode/` 目录 + OPENCODE.md**

```bash
# 从本项目复制到你的项目
cp -r .opencode/ 你的项目路径/.opencode/
cp OPENCODE.md 你的项目路径/OPENCODE.md
```

**方法 2：下载源码**

```bash
git clone https://github.com/gwtt/Open-Code-Godot-Studio.git
cp -r Open-Code-Godot-Studio/.opencode/ 你的项目路径/
cp Open-Code-Godot-Studio/OPENCODE.md 你的项目路径/
```

---

### 📁 核心文件清单

你的项目需要以下文件：

| 目录/文件 | 作用 | 必须 |
|-----------|------|------|
| `.opencode/skills/` | **18 个 Godot Skills** | ✅ 必须 |
| `.opencode/hooks/` | 自动化脚本（session、commit 验证） | ✅ 推荐 |
| `.opencode/rules/` | GDScript/C# 编码规则 | ✅ 推荐 |
| `.opencode/docs/` | 文档 + Engine Reference | ⚡ 可选 |
| `.opencode/mcp.json` | MCP 服务器配置 | ⚡ 可选 |
| `OPENCODE.md` | AI 入口配置文件 | ✅ 必须 |

---

### 🔧 最小集成（核心文件）

如果你只需要 Skills 功能：

```
你的项目/.opencode/
├── skills/         # 必须 — 18 个 Skills
├── hooks/          # 推荐 — 自动化脚本
└── rules/          # 推荐 — 编码规则
```

**别忘了复制 OPENCODE.md：**
```bash
cp OPENCODE.md 你的项目/
```

然后修改你的版本：
```markdown
## Technology Stack
- **Engine**: Godot 4.x  ← 改成你的版本
```
你的项目/.opencode/
├── skills/         # 必须 — 18 个 Skills
├── hooks/          # 推荐 — 自动化脚本
└── rules/          # 推荐 — 编码规则
```

然后在你的项目根目录创建 `OPENCODE.md`（或 `AGENTS.md`）：

```markdown
# 你的项目名称

## Technology Stack
- **Engine**: Godot 4.x  ← 改成你的版本

运行 `/start` 开始。
```

> ⚠️ **注意**: 不要复制本项目的完整 OPENCODE.md，只需使用上面的最小模板。`/start` skill 会引导你接下来的步骤。

---

### 📌 完整集成（推荐）

复制所有文件获得完整功能：

```bash
cp -r .opencode/ 你的项目/
cp OPENCODE.md 你的项目/
```

目录结构：
```
你的项目/
├── .opencode/
│   ├── skills/         # 18 个 Skills
│   ├── hooks/          # 4 个自动化脚本
│   ├── rules/          # 3 个编码规则
│   ├── docs/           # 文档 + Engine Reference
│   │   ├── coding-standards.md
│   │   ├── technical-preferences.md
│   │   └── engine-reference/godot/
│   ├── mcp.json        # MCP 配置
│   └── package.json    # Node.js 依赖
└── OPENCODE.md         # AI 入口配置
```

---

### 🎯 可用的 18 个 Skills

复制 `.opencode/skills/` 后，你可以使用以下 Skills：

| Skill | 功能 | 调用方式 |
|-------|------|----------|
| `/start` | 项目初始化 | 交互式引导 |
| `/godot-specialist` | Godot API 专家 | 自动检查废弃 API |
| `/godot-gdscript` | GDScript 代码生成 | 遵循编码规则 |
| `/godot-csharp` | C# 代码生成 | .NET 8 模式 |
| `/godot-shader` | Shader 编写 | Godot shading language |
| `/brainstorm` | 游戏创意生成 | MDA 框架 |
| `/game-designer` | 游戏系统设计 | 机制设计 |
| `/design-review` | 设计文档审查 | 验证与反馈 |
| `/sprint-plan` | Sprint 规划 | 任务分解 |
| `/producer` | 项目管理 | 进度追踪 |
| `/technical-director` | 技术架构 | 技术决策 |
| `/code-review` | 代码审查 | 质量检查 |
| `/prototype-mode` | 快速原型 | 验证想法 |

---

### ⚡ 快速开始（最简单方法）

**Step 1：复制文件**

```bash
# 复制 .opencode/ 目录
cp -r .opencode/ 你的项目/.opencode/

# 复制 OPENCODE.md
cp OPENCODE.md 你的项目/
```

**Step 2：修改版本**

编辑 `OPENCODE.md`：
```markdown
## Technology Stack
- **Engine**: Godot 4.x  ← 改成你的版本
```

**Step 3：使用**

在 OpenCode 中打开你的项目，运行：

```
/start
```

系统会自动加载 Skills 并引导你开始。

---

### 🔄 更新 Engine Reference（可选）

如果你的 Godot 版本不同，更新 `VERSION.md`：

```markdown
| **Engine Version** | Godot 4.x  ← 改成你的版本 |
```

---

### 📚 更多文档

- Skills 详细说明：`docs/SKILLS.md`
- 快速入门：`docs/QUICK-START.md`
- 工作流程：`docs/WORKFLOW.md`

---

> **第一次使用？** 复制 `.opencode/` + `OPENCODE.md` 到你的项目，修改版本号，然后运行 `/start`