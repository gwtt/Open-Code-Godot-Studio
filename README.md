# OpenCode Game Studios - Godot Edition

AI-powered game development framework for Godot 4.6.1.

[中文文档](./README_CN.md) | English

---

## What Is This?

A coordinated AI agent system for indie game development:
- **17 specialized skills** for Godot game dev
- **Automated hooks** for quality enforcement
- **Path-scoped rules** for coding standards

Adapted from [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios).

---

## Quick Start (5 minutes)

### Option A: Interactive Onboarding
```
/start
```
System detects your state and guides you.

### Option B: Manual Steps
```
1. /brainstorm "your idea"    → Game concept
2. /setup-engine godot 4.6.1  → Engine setup
3. /sprint-plan               → Sprint planning
```

📖 **[Step-by-step tutorial →](docs/tutorials/snake-tutorial.md)**

---

## Documentation

| Document | Description |
|----------|-------------|
| [SKILLS.md](docs/SKILLS.md) | All 17 skills detailed guide |
| [WORKFLOW.md](docs/WORKFLOW.md) | Typical workflows |
| [QUICK-START.md](docs/QUICK-START.md) | 5-minute guide |
| [tutorials/](docs/tutorials/) | Hands-on tutorials |

---

## Skills Overview

| Category | Skills |
|----------|--------|
| **Leadership Core** | `start`, `producer`, `technical-director` |
| **Execution Support** | `godot-specialist`, `sprint-plan`, `art-coordinator`, `prototype-mode` |
| **Design Support** | `brainstorm`, `game-designer`, `design-review` |
| **Deep Technical** | `godot-gdscript`, `godot-shader`, `godot-gdextension`, `code-review` |
| **Advisory** | `creative-director`, `lead-programmer` |

> See [docs/SKILLS.md](docs/SKILLS.md) for detailed descriptions.

---

## Project Structure

```
.opencode/
├── skills/        → 17 game dev skills
├── hooks/         → Automation scripts
├── rules/         → Coding standards
└── docs/          → Templates and references

src/               → Game code (GDScript, C#, C++)
assets/            → Art, audio, VFX
design/            → GDDs, narrative
production/        → Sprint plans, milestones
prototypes/        → Throwaway prototypes
tests/             → Test suites
```

---

## Typical Workflows

### Team Lead Weekly Cycle
```
Monday:   /sprint-plan review → Progress check
Wednesday: /art-coordinator → Art sync
Friday:   /producer → Week summary
```

### New Feature Development
```
/design-review → Validate design
/art-coordinator → Request art assets
/prototype-mode → Quick validation (optional)
/technical-director → Architecture check
/godot-specialist → Implementation
/code-review → Quality gate
```

---

## Features

### Skills (17 total)
- Godot-specific: `godot-specialist`, `godot-gdscript`, `godot-shader`, `godot-gdextension`
- Game dev core: `creative-director`, `technical-director`, `producer`, `game-designer`, `lead-programmer`
- Workflows: `start`, `brainstorm`, `setup-engine`, `sprint-plan`, `code-review`, `design-review`
- New: `art-coordinator`, `prototype-mode`

### Hooks (4)
- Session start/stop — Context loading
- Commit validation — Message format
- Asset validation — Naming conventions

### Rules (3)
- GDScript standards — Static typing, signals
- Gameplay rules — Game-specific patterns
- General rules — Best practices

---

## Integration with oh-my-openagent

Compatible with [oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent).

See [integration docs](https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/master/AGENTS.md) for details.

---

## Key Differences from Claude-Code-Game-Studios

| Original | This Version |
|----------|--------------|
| `.claude/` directory | `.opencode/` directory |
| CLAUDE.md | OPENCODE.md |
| 48 agents | 17 focused skills |
| Multi-engine | Godot-focused |

---

## Contributing

See original project: [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)

---

## License

MIT License