# OpenCode Game Studios -- Godot Game Development Architecture

Indie game development managed through coordinated OpenCode subagents and skills.
Each agent/skill owns a specific domain, enforcing separation of concerns and quality.

## Technology Stack

- **Engine**: Godot 4.x
- **Language**: GDScript (primary), C# (optional), C++/Rust via GDExtension (performance-critical)
- **Version Control**: Git with trunk-based development
- **Build System**: SCons (engine), Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline

## Project Structure

```
.opencode/
  skills/                # Godot-focused skills (slash commands)
  hooks/                 # Automated validation hooks
  rules/                 # Path-scoped coding standards
  docs/
    templates/           # Document templates (GDD, ADR, etc.)
  agents/                # Agent definitions (for reference)

src/                     # Game source code (GDScript, C#, C++)
assets/                  # Art, audio, VFX, shaders, data files
design/                  # GDDs, narrative docs, level designs
docs/                    # Technical documentation and ADRs
tests/                   # Test suites (GUT for Godot)
tools/                   # Build and pipeline tools
prototypes/              # Throwaway prototypes (isolated from src/)
production/              # Sprint plans, milestones, release tracking
```

## Engine Version Reference

@.opencode/docs/engine-reference/godot/VERSION.md

## Technical Preferences

@.opencode/docs/technical-preferences.md

## Coordination Rules

@.opencode/docs/coordination-rules.md

## Collaboration Protocol

**User-driven collaboration, not autonomous execution.**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval**

- Agents MUST ask "May I write this to [filepath]?" before using Write/Edit tools
- Agents MUST show drafts or summaries before requesting approval
- Multi-file changes require explicit approval for the full changeset
- No commits without user instruction

## Coding Standards

@.opencode/docs/coding-standards.md

## Available Skills (17 Skills)

Type `/` to access game development skills:

### 领导核心 (Leadership Core)
- `/start` — 入口路由，检测团队状态
- `/producer` — 进度管理、范围控制
- `/technical-director` — 架构决策、技术标准

### 执行支持 (Execution Support)
- `/godot-specialist` — Godot 引擎模式和最佳实践
- `/sprint-plan` — Sprint 规划和任务估算
- `/art-coordinator` — 美术协调、资产管道
- `/prototype-mode` — 快速原型验证

### 设计支持 (Design Support)
- `/brainstorm` — 游戏概念探索
- `/game-designer` — 游戏系统和机制设计
- `/design-review` — 设计文档审查

### 深度技术 (Deep Technical)
- `/godot-gdscript` — GDScript 代码模式
- `/godot-shader` — Godot Shader 开发
- `/godot-gdextension` — C++/Rust 原生扩展
- `/code-review` — 代码质量审查

### 其他
- `/setup-engine` — 配置 Godot 引擎
- `/creative-director` — 创意愿景指导
- `/lead-programmer` — 代码架构协调

---

## 📚 新手教程

**第一次使用？** 跟着这个教程一步步完成你的第一个游戏：

👉 **[贪吃蛇实战教程](docs/tutorials/snake-tutorial.md)**

教程包含：
- 完整的开发流程
- 每一步如何与 OpenCode 对话
- 实际代码示例
- 从零到发布的完整指南

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
    ↓
/art-coordinator → 请求美术资产
    ↓
/prototype-mode → 快速验证 (可选)
    ↓
/technical-director → 架构检查
    ↓
/godot-specialist → 实现指导
    ↓
/code-review → 质量检查
```

---

## Agent Categories (OpenCode Integration)

When delegating work, use these OpenCode categories:

| Category | Best For |
|----------|----------|
| `visual-engineering` | UI, shaders, visual effects, styling |
| `ultrabrain` | Hard logic, architecture, algorithms |
| `deep` | Autonomous problem-solving, thorough research |
| `artistry` | Creative approaches, unconventional solutions |
| `quick` | Trivial fixes, typos, simple modifications |

For Godot-specific work, load relevant skills:
- `godot-gdscript` — GDScript patterns, typing, signals
- `godot-shader` — Godot shading language, visual shaders
- `godot-gdextension` — C++/Rust native extensions

## Context Management

@.opencode/docs/context-management.md

> **第一次使用？** 运行 `/start` 开始引导，或查看 [贪吃蛇教程](docs/tutorials/snake-tutorial.md)