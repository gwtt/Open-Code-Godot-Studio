# Coordination Rules

This document defines how agents and skills coordinate and delegate work.

## Delegation Hierarchy

```
User (Final Decision Maker)
    │
    ├── creative-director (Creative Vision)
    │       ├── game-designer
    │       │       └── systems-designer, level-designer, economy-designer
    │       └── narrative-director
    │               └── writer, world-builder
    │
    ├── technical-director (Technical Vision)
    │       ├── lead-programmer
    │       │       ├── gameplay-programmer
    │       │       ├── engine-programmer
    │       │       ├── ai-programmer
    │       │       ├── network-programmer
    │       │       └── ui-programmer
    │       └── godot-specialist
    │               ├── godot-gdscript
    │               ├── godot-shader
    │               └── godot-gdextension
    │
    └── producer (Production Management)
            ├── qa-lead
            │       └── qa-tester
            └── release-manager
```

## Decision Authority

| Decision Type | Authority |
|---------------|-----------|
| Creative direction | creative-director → User |
| Technical architecture | technical-director → User |
| Scope/schedule | producer → User |
| Implementation details | Lead specialists |
| Code style | lead-programmer |

## Conflict Resolution

### Design Conflicts

1. **Identify conflict** — What's the actual disagreement?
2. **Map to pillars** — Which pillars does each option serve?
3. **Escalate** — creative-director evaluates
4. **User decides** — Final authority

### Technical Conflicts

1. **Identify conflict** — What's incompatible?
2. **Evaluate options** — Trade-offs for each approach
3. **Escalate** — technical-director evaluates
4. **User decides** — Final authority

### Scope Conflicts

1. **Identify conflict** — Capacity vs. scope
2. **Present options** — Cut, reduce, or extend timeline
3. **Escalate** — producer evaluates
4. **User decides** — Final authority

## Communication Protocols

### Cross-Team Requests

```markdown
**From**: [Requesting team]
**To**: [Target team]
**Request**: [What's needed]
**Why**: [Context/reason]
**When**: [Timeline]
**Dependencies**: [Any blockers]
```

### Status Updates

```markdown
**Status**: On Track / At Risk / Blocked
**Progress**: [What's done]
**Next**: [What's next]
**Blockers**: [What's stuck]
**Help Needed**: [What support is needed]
```

## Skill Invocation Guidelines

### When to Use Each Skill

| Skill | Use When |
|-------|----------|
| `creative-director` | Vision questions, pillar conflicts |
| `technical-director` | Architecture decisions, tech choices |
| `producer` | Planning, scope, progress |
| `game-designer` | Mechanics, systems, balance |
| `lead-programmer` | Code architecture, review |
| `godot-specialist` | Engine-specific questions |
| `godot-gdscript` | GDScript patterns, optimization |
| `godot-shader` | Shaders, VFX, rendering |
| `godot-gdextension` | Native code, performance |

### Workflow Skills

| Skill | Use When |
|-------|----------|
| `start` | New session, new user |
| `brainstorm` | No concept, exploring ideas |
| `setup-engine` | Configuring Godot |
| `sprint-plan` | Planning work |
| `code-review` | Reviewing code quality |
| `design-review` | Reviewing design documents |

## Domain Boundaries

Agents should NOT modify files outside their domain without explicit coordination:

| Domain | Files |
|--------|-------|
| Gameplay | `src/gameplay/**` |
| Core | `src/core/**` |
| UI | `src/ui/**` |
| Systems | `src/systems/**` |
| Design | `design/**` |
| Tests | `tests/**` |

Cross-domain changes require:
1. Identify affected domains
2. Notify domain owners
3. Coordinate implementation
4. Test integration