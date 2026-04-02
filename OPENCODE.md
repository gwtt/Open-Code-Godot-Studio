# OpenCode Game Studios - Godot Edition

AI agent context for Godot 4.6.1 game development.

---

## Technology Stack

- **Engine**: Godot 4.6.1
- **Languages**: C# (primary) + GDScript (optional)
- **Performance**: GDExtension (C++/Rust) when needed
- **Version Control**: Git

---

## ⚠️ MANDATORY RULES (强制规则)

> **这些规则不可绕过。所有 Agent 必须遵守。**

### 1. Godot MCP 强制接入

**规则**: 所有 Godot 项目操作必须通过 Godot MCP 工具执行。

| 操作类型 | 强制使用 MCP 工具 |
|----------|------------------|
| 创建场景 | `godot_create_scene` |
| 添加节点 | `godot_add_node` |
| 加载资源 | `godot_load_sprite` |
| 保存场景 | `godot_save_scene` |
| 运行项目 | `godot_run_project` |
| 获取调试输出 | `godot_get_debug_output` |

**禁止行为**:
- ❌ 直接编辑 .tscn 文件（除非 MCP 不可用）
- ❌ 手动创建场景结构（必须使用 MCP）
- ❌ 跳过 MCP 工具直接操作 Godot 项目

**例外**: 代码文件（.cs, .gd）可直接编辑。

### 2. C# 代码优先

**规则**: 所有逻辑代码优先使用 C# 实现。

| 优先级 | 语言 | 用途 |
|--------|------|------|
| **P1 (首选)** | C# | 游戏逻辑、系统、组件 |
| **P2 (可选)** | GDScript | 快速原型、简单脚本 |
| **P3 (特殊)** | GDExtension | 高性能模块 |

**禁止行为**:
- ❌ 默认使用 GDScript（必须优先考虑 C#）
- ❌ 混合语言同一功能（选择一种）

### 3. MCP 配置验证

**规则**: 每次启动前验证 MCP 配置状态。

```
必要检查项:
1. GODOT_PATH 环境变量是否设置
2. mcp.json 中 godot.enabled = true
3. MCP 工具调用是否成功响应
```

**配置文件**: `.opencode/mcp.json`

---

## Project Structure

```
.opencode/    → Skills, hooks, rules, docs
src/          → Game code (C# primary, GDScript optional)
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

Load skills: `task(category="...", load_skills=["godot-csharp"], prompt="...")`

---

## Collaboration Protocol

**User-driven**: Question → Options → Decision → Draft → Approval

- Ask before writing files
- Show drafts before approval
- No commits without user instruction

---

## MCP Tools Reference (Godot MCP)

> **所有场景操作必须通过这些工具执行。**

### 完整工具列表

| 工具 | 功能 | 参数 |
|------|------|------|
| `godot_launch_editor` | 启动 Godot 编辑器 | `projectPath` |
| `godot_run_project` | 运行项目（调试模式） | `projectPath`, `scene` |
| `godot_get_debug_output` | 获取调试输出 | - |
| `godot_stop_project` | 停止运行项目 | - |
| `godot_get_godot_version` | 获取 Godot 版本 | - |
| `godot_list_projects` | 列出项目 | `directory` |
| `godot_get_project_info` | 项目元数据 | `projectPath` |
| `godot_create_scene` | **创建场景** | `projectPath`, `scenePath`, `rootNodeType` |
| `godot_add_node` | **添加节点** | `projectPath`, `scenePath`, `nodeType`, `nodeName`, `parentNodePath` |
| `godot_load_sprite` | 加载精灵贴图 | `projectPath`, `scenePath`, `nodePath`, `texturePath` |
| `godot_export_mesh_library` | 导出 MeshLibrary | `projectPath`, `scenePath`, `outputPath` |
| `godot_save_scene` | **保存场景** | `projectPath`, `scenePath` |
| `godot_get_uid` | 获取 UID (Godot 4.4+) | `projectPath`, `filePath` |
| `godot_update_project_uids` | 更新项目 UID | `projectPath` |

### 使用示例

```typescript
// 创建新场景
godot_create_scene({
  projectPath: "D:/MyGame",
  scenePath: "Scenes/Main.tscn",
  rootNodeType: "Node2D"
})

// 添加节点
godot_add_node({
  projectPath: "D:/MyGame",
  scenePath: "Scenes/Main.tscn",
  nodeType: "Sprite2D",
  nodeName: "Player",
  parentNodePath: "root"
})

// 保存场景
godot_save_scene({
  projectPath: "D:/MyGame",
  scenePath: "Scenes/Main.tscn"
})
```

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
| `.opencode/mcp.json` | MCP 服务器配置 | ✅ **强制** |
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
| `/godot-csharp` | **C# 代码生成** | .NET 8 模式 |
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

**Step 3：配置 MCP**

设置环境变量：
```powershell
# Windows
$env:GODOT_PATH = "C:\Godot\Godot_v4.6.1-stable_win64.exe"
```

或直接编辑 `.opencode/mcp.json` 替换 `${GODOT_PATH}`。

**Step 4：使用**

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

> **第一次使用？** 复制 `.opencode/` + `OPENCODE.md` 到你的项目，修改版本号，配置 GODOT_PATH，然后运行 `/start`