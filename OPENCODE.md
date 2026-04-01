# OpenCode Game Studios - Godot Edition

AI agent context for Godot 4.6.1 game development.

---

## Technology Stack

- **Engine**: Godot 4.6.1
- **Language**: GDScript (primary), C# (optional), C++/Rust via GDExtension
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

---

## Available Skills (17)

### 领导核心
`start` `producer` `technical-director`

### 执行支持
`godot-specialist` `sprint-plan` `art-coordinator` `prototype-mode`

### 设计支持
`brainstorm` `game-designer` `design-review`

### 深度技术
`godot-gdscript` `godot-shader` `godot-gdextension` `code-review`

### 其他
`setup-engine` `creative-director` `lead-programmer`

> 详见 [docs/SKILLS.md](docs/SKILLS.md)

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

> **第一次使用？** 运行 `/start` 或查看 [快速入门](docs/QUICK-START.md)