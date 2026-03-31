# OpenCode Game Studios - Godot Edition

A comprehensive game development framework adapted from [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) for OpenCode, with primary support for Godot 4.

## Features

### Skills (15 total)

**Godot-Specific (4 skills):**
- `godot-specialist` — Godot Engine architecture and best practices
- `godot-gdscript` — GDScript patterns, typing, and optimization
- `godot-shader` — Shaders, VFX, and rendering
- `godot-gdextension` — C++/Rust native extensions

**Game Development Core (5 skills):**
- `creative-director` — Vision, pillars, and creative direction
- `technical-director` — Architecture and technology decisions
- `producer` — Sprints, milestones, and coordination
- `game-designer` — Mechanics, systems, and balance
- `lead-programmer` — Code architecture and review

**Workflows (6 skills):**
- `start` — Guided onboarding for new projects
- `brainstorm` — Explore and develop game concepts
- `setup-engine` — Configure Godot for your project
- `sprint-plan` — Plan development sprints
- `code-review` — Review code quality and patterns
- `design-review` — Review design documents

### Hooks (4 scripts)
- Session start/stop hooks
- Commit validation
- Asset validation

### Rules (3 rule sets)
- Gameplay code rules
- GDScript standards
- General coding rules

## Project Structure

```
.opencode/
├── skills/              # 15 game development skills
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
├── hooks/               # Automation scripts
├── rules/               # Path-scoped coding standards
└── docs/                # Documentation and templates

design/gdd/              # Game design documents
production/              # Sprint plans and milestones
src/                     # Game source code (to be created)
assets/                  # Game assets (to be created)
```

## Quick Start

1. **New Project?** Run the `start` skill for guided onboarding:
   ```
   Invoke the 'start' skill
   ```

2. **Have an idea?** Run `brainstorm` to develop it:
   ```
   Invoke the 'brainstorm' skill with your idea
   ```

3. **Ready to code?** Run `setup-engine` to configure Godot:
   ```
   Invoke the 'setup-engine' skill
   ```

## Key Differences from Claude-Code-Game-Studios

| Original | Adapted |
|----------|---------|
| `.claude/` directory | `.opencode/` directory |
| CLAUDE.md | OPENCODE.md |
| 48 agents | 15 focused skills |
| Full Unity/Unreal support | Godot-focused |
| Claude-specific format | OpenCode skill format |

## Using the Skills

In OpenCode, invoke skills by name:

```
Use the 'godot-specialist' skill for engine questions
Use the 'code-review' skill to review recent changes
Use the 'sprint-plan' skill to plan your next sprint
```

## Contributing

This is an adaptation of Claude-Code-Game-Studios. For the original project, see:
https://github.com/Donchitos/Claude-Code-Game-Studios

## License

MIT License - See original project for details.