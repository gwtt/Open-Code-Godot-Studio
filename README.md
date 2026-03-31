# OpenCode Game Studios - Godot Edition

A comprehensive game development framework adapted from [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) for OpenCode, with primary support for Godot 4.

[中文文档](./README_CN.md) | English

---

## Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Skills Guide](#skills-guide)
- [Agent & Skill Workflow](#agent--skill-workflow)
- [Integration with oh-my-openagent](#integration-with-oh-my-openagent)
- [Hooks & Rules](#hooks--rules)
- [Project Structure](#project-structure)

---

## Features

### Skills (15 total)

| Category | Skills | Purpose |
|----------|--------|---------|
| **Godot-Specific** | `godot-specialist`, `godot-gdscript`, `godot-shader`, `godot-gdextension` | Engine architecture, scripting, shaders, native bindings |
| **Game Dev Core** | `creative-director`, `technical-director`, `producer`, `game-designer`, `lead-programmer` | Vision, architecture, planning, design, code management |
| **Workflows** | `start`, `brainstorm`, `setup-engine`, `sprint-plan`, `code-review`, `design-review` | Onboarding, ideation, setup, sprint planning, reviews |

### Hooks (4 automation scripts)
- Session start/stop hooks — Context loading and logging
- Commit validation — Message format and TODO checks
- Asset validation — Naming conventions and JSON structure

### Rules (3 coding standards)
- GDScript standards — Static typing, naming, signals
- Gameplay code rules — Game-specific patterns
- General coding rules — Universal best practices

---

## Quick Start

### Step 1: Onboarding (New Projects)

```
Invoke the 'start' skill
```

The `start` skill will ask where you are in your game development journey:

| Option | Description | Recommended Next Step |
|--------|-------------|----------------------|
| **A) No idea yet** | Starting from scratch | `/brainstorm` for creative exploration |
| **B) Vague idea** | Rough theme or genre | `/brainstorm "your idea"` to develop it |
| **C) Clear concept** | Know core idea, need documentation | `/setup-engine` → `/sprint-plan` |
| **D) Existing work** | Already have docs/prototypes/code | Continue based on gaps identified |

### Step 2: Game Concept Development

```
Invoke the 'brainstorm' skill with your idea
```

**Invocation patterns:**
- `/brainstorm` — Open exploration, discover your game concept
- `/brainstorm "space exploration roguelike"` — Develop specific idea
- `/brainstorm open` — Maximum openness to new ideas

**What it produces:**
- Game concept document at `design/gdd/game-concept.md`
- Design pillars (3-5 foundational principles)
- Core loop definition
- Scope assessment (jam/small/medium/large)
- Engine recommendation

### Step 3: Engine Setup

```
Invoke the 'setup-engine' skill
```

**Invocation patterns:**
- `/setup-engine` — Guided setup with questions
- `/setup-engine godot 4.3` — Direct version specification

**What it creates:**
- Updates `OPENCODE.md` with technology stack
- Creates `.opencode/docs/technical-preferences.md`
- Creates `.opencode/docs/engine-reference/godot/VERSION.md`
- Sets up project directory structure (`src/`, `assets/`, `design/`, etc.)

### Step 4: Sprint Planning

```
Invoke the 'sprint-plan' skill
```

**Invocation patterns:**
- `/sprint-plan` — Create new sprint
- `/sprint-plan review` — Review current sprint progress
- `/sprint-plan complete` — Mark sprint complete

**What it produces:**
- Sprint document at `production/sprints/sprint-[N]-[date].md`
- Task breakdown with estimates and owners
- Risk assessment and dependency tracking

---

## Skills Guide

### Godot-Specific Skills

#### `godot-specialist`

**Purpose:** Authority on Godot patterns, APIs, and optimization. Guides GDScript vs C# vs GDExtension decisions.

**When to use:**
- Choosing language for a feature (GDScript, C#, or GDExtension)
- Designing scene/node architecture for new systems
- Setting up input mapping, autoloads, or project settings
- Configuring export presets for any platform
- Optimizing rendering, physics, or memory

**How to invoke:**
```
Invoke the 'godot-specialist' skill for [your question]
```

**Key capabilities:**
- Scene/node architecture guidance (composition over inheritance)
- GDScript standards (static typing, signals, resources)
- Performance best practices
- Language decision matrix

---

#### `godot-gdscript`

**Purpose:** GDScript specialist for code quality, static typing, signals, and optimization.

**When to use:**
- Enforcing static typing throughout your codebase
- Designing signal architecture for decoupling
- Optimizing GDScript performance
- Following GDScript-specific idioms and patterns

**How to invoke:**
```
Invoke the 'godot-gdscript' skill for GDScript patterns and optimization
```

**Key capabilities:**
- Static typing enforcement (`var health: int = 100`)
- Signal patterns (typed parameters, connection best practices)
- Coroutine patterns with `await`
- Performance optimization (minimize `_process`, caching)

---

#### `godot-shader`

**Purpose:** Shaders, VFX, particles, and rendering optimization in Godot 4.

**When to use:**
- Writing custom shaders (spatial, canvas_item, particles)
- Creating visual shader graphs
- Post-processing effects
- Particle system design
- Rendering optimization

**How to invoke:**
```
Invoke the 'godot-shader' skill for shader development
```

---

#### `godot-gdextension`

**Purpose:** C++/Rust native bindings for high-performance modules.

**When to use:**
- Creating custom native nodes
- Performance-critical code (>1000 calls/frame)
- Heavy math operations (pathfinding, physics)
- Integrating external C++/Rust libraries

**How to invoke:**
```
Invoke the 'godot-gdextension' skill for native extension development
```

---

### Game Development Core Skills

#### `creative-director`

**Purpose:** Guardian of game vision, pillars, and creative direction.

**When to use:**
- Defining design pillars and core vision
- Resolving conflicts between competing design options
- Maintaining tone, feel, and identity consistency
- Preventing feature creep

**How to invoke:**
```
Invoke the 'creative-director' skill for vision and pillar decisions
```

**Key capabilities:**
- Pillar definition and conflict resolution
- Tone and identity management
- MDA framework application
- Vision alignment checks

---

#### `technical-director`

**Purpose:** Technical vision, architecture decisions, and technology choices.

**When to use:**
- Making Architecture Decision Records (ADRs)
- Defining system architecture patterns
- Setting performance budgets
- Managing technical debt
- Build/CI strategy

**How to invoke:**
```
Invoke the 'technical-director' skill for architecture decisions
```

---

#### `producer`

**Purpose:** Schedule, resources, scope, and team coordination.

**When to use:**
- Planning sprints and milestones
- Managing scope and feature prioritization
- Tracking progress and identifying blockers
- Risk assessment and mitigation

**How to invoke:**
```
Invoke the 'producer' skill for scheduling and planning
```

---

#### `game-designer`

**Purpose:** Mechanics, systems, progression, economy, and player experience.

**When to use:**
- Designing game mechanics and systems
- Creating progression and economy systems
- Balancing gameplay elements
- Writing design documents (GDDs)

**How to invoke:**
```
Invoke the 'game-designer' skill for system and mechanic design
```

---

#### `lead-programmer`

**Purpose:** Code architecture, review, standards, and programming team coordination.

**When to use:**
- Defining system architecture and coding standards
- Leading code reviews
- Managing technical debt and API boundaries
- Implementation coordination

**How to invoke:**
```
Invoke the 'lead-programmer' skill for code architecture
```

---

### Workflow Skills

#### `start`

**Purpose:** Guided onboarding — asks where you are, then routes to the right workflow.

**Invocation:**
```
Invoke the 'start' skill
```

**Workflow:**
1. Silent project state detection
2. Ask: No idea / Vague / Clear concept / Existing work?
3. Route to appropriate next skill
4. Confirm before proceeding

---

#### `brainstorm`

**Purpose:** Explore game ideas using MDA, player psychology, verb-first design.

**Invocation patterns:**
| Command | Purpose |
|---------|---------|
| `/brainstorm` | Open exploration |
| `/brainstorm "your idea"` | Develop specific concept |
| `/brainstorm open` | Maximum openness |

**Output:** `design/gdd/game-concept.md`

---

#### `setup-engine`

**Purpose:** Configure engine and technical preferences.

**Invocation patterns:**
| Command | Purpose |
|---------|---------|
| `/setup-engine` | Guided setup |
| `/setup-engine godot 4.3` | Specific version |

**Output:** Technical preferences, engine reference docs, project structure

---

#### `sprint-plan`

**Purpose:** Plan sprints with task breakdown and estimation.

**Invocation patterns:**
| Command | Purpose |
|---------|---------|
| `/sprint-plan` | Create new sprint |
| `/sprint-plan review` | Review current sprint |
| `/sprint-plan complete` | Mark sprint complete |

**Output:** `production/sprints/sprint-[N]-[date].md`

---

#### `code-review`

**Purpose:** Review code quality, patterns, performance with structured feedback.

**Invocation patterns:**
| Command | Purpose |
|---------|---------|
| `/code-review` | Review recent changes |
| `/code-review src/player/` | Review directory |
| `/code-review player.gd` | Review specific file |

**Output:** Structured report with severity levels (Blocking/Important/Suggestion)

---

#### `design-review`

**Purpose:** Review design documents and validate pillar alignment.

**Invocation patterns:**
| Command | Purpose |
|---------|---------|
| `/design-review` | Review all design docs |
| `/design-review combat.md` | Review specific document |
| `/design-review --system combat` | Review specific system |

---

## Agent & Skill Workflow

### Understanding OpenCode's Agent System

OpenCode uses a hierarchical agent system for different tasks:

#### Primary Agents

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| **Build** | Full development with all tools | Implementation, file edits, commands |
| **Plan** | Analysis without changes | Planning, reviewing suggestions |

#### Subagents (Background Tasks)

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| **explore** | Read-only codebase exploration | Finding patterns, locating files, understanding structure |
| **librarian** | External documentation lookup | Library docs, API references, OSS examples |
| **oracle** | Read-only consultation | Architecture decisions, debugging, complex logic |
| **metis** | Pre-planning analysis | Scope clarification, ambiguity resolution |
| **momus** | Expert review | Plan evaluation, quality assurance |

#### Task Categories (Domain-Optimized)

| Category | Best For | Example Tasks |
|----------|----------|---------------|
| `visual-engineering` | UI, shaders, VFX, styling | UI components, visual shaders |
| `ultrabrain` | Hard logic, algorithms | Pathfinding, complex systems |
| `deep` | Autonomous problem-solving | Multi-module refactoring |
| `artistry` | Creative approaches | Game concept development |
| `quick` | Trivial fixes | Typos, simple config changes |
| `writing` | Documentation | README, GDDs, technical docs |

### Typical Workflow for Game Development Tasks

```
1. Start: Define your task
   ↓
2. Plan: Use plan agent for work breakdown
   ↓
3. Explore: Fire explore/librarian agents (background) for context
   ↓
4. Execute: Delegate to appropriate category agent
   ↓
5. Review: Use oracle/momus for quality check
   ↓
6. Verify: Run tests, diagnostics, manual QA
```

### When to Invoke Skills vs Agents

| Scenario | Use | Example |
|----------|-----|---------|
| Need specialized knowledge | **Skill** | Godot patterns → `godot-specialist` skill |
| Need codebase exploration | **Agent** | Find auth patterns → `explore` agent |
| Need external docs | **Agent** | JWT security → `librarian` agent |
| Need architecture review | **Agent** | System design → `oracle` agent |
| Need implementation | **Category Task** | UI component → `visual-engineering` |

### Quick Invocation Guide

**Skills (specialized knowledge):**
```
Invoke the 'godot-specialist' skill
Invoke the 'game-designer' skill for economy design
Use the 'code-review' skill on src/player/
```

**Agents (research/exploration):**
```
task(subagent_type="explore", prompt="Find authentication patterns...")
task(subagent_type="librarian", prompt="Search JWT security best practices...")
task(subagent_type="oracle", prompt="Review my architecture approach...")
```

**Category Tasks (implementation):**
```
task(category="visual-engineering", load_skills=["frontend-ui-ux"], prompt="...")
task(category="ultrabrain", load_skills=["godot-gdscript"], prompt="...")
```

---

## Integration with oh-my-openagent

### Compatibility Overview

**Yes, OpenCode Game Studios can integrate with oh-my-openagent (OMO).**

oh-my-openagent is an open-source AI agent harness with multi-model orchestration, featuring:
- **Skill-embedded architecture**: YAML frontmatter in skills (aligns with OpenCode's skill format)
- **MCP Architecture**: Three-tier system (Built-in, Claude Code compatibility, Skill-embedded)
- **Agent Models**: Sisyphus, Atlas, oracle, librarian, explore — similar roles to OpenCode

### Integration Path

Both systems share compatible concepts:

| OpenCode Concept | oh-my-openagent Equivalent |
|------------------|---------------------------|
| Skills (YAML frontmatter) | Skill-embedded definitions |
| explore/librarian agents | Agent models with similar roles |
| Task delegation | MCP orchestration |

### Recommended Integration Patterns

**Pattern A: Skill Bridge**
- Define OpenCode skills as OMO skills in the skill registry
- Allow OMO agents (librarian, explore) to invoke OpenCode skills

**Pattern B: Orchestration Layer**
- Use OMO's MCP + Claude Code compatibility layer
- Model OpenCode task flows as OMO tool sequences

### Key References

- oh-my-openagent GitHub: https://github.com/code-yeongyu/oh-my-openagent
- AGENTS.md architecture: https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/master/AGENTS.md
- npm package: https://registry.npmjs.org/oh-my-openagent

### Integration Next Steps

1. **Create AGENTS.md entry** for OpenCode–OMO bridge
2. **Map skill definitions** between both systems
3. **Test orchestration** with a sample task flow
4. **Document conventions** for cross-system usage

---

## Hooks & Rules

### Hooks (Automation Scripts)

| Hook | Trigger | Purpose |
|------|---------|---------|
| `session-start.sh` | Session begins | Load sprint context, show git activity, check project gaps |
| `session-stop.sh` | Session ends | Log accomplishments, update session history |
| `validate-commit.sh` | Before commit | Check commit message format, validate TODOs |
| `validate-assets.sh` | After asset file write | Validate naming, JSON structure, resource references |

### Rules (Coding Standards)

| Rule File | Applies To | Enforces |
|-----------|------------|----------|
| `gdscript.md` | `**/*.gd` | Static typing, naming conventions, node references, signals |
| `gameplay.md` | `src/gameplay/**` | Gameplay-specific patterns |
| `rules.md` | All code | General best practices |

### Key GDScript Rules

```gdscript
# ✅ Correct - Static typing
var health: int = 100
func take_damage(amount: int) -> void:
    pass

# ❌ Wrong - No types
var health = 100
func take_damage(amount):
    pass
```

---

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
src/                     # Game source code (GDScript, C#, C++)
assets/                  # Game assets (sprites, audio, etc.)
tests/                   # Test suites (GUT for Godot)
prototypes/              # Throwaway prototypes
```

---

## Key Differences from Claude-Code-Game-Studios

| Original | Adapted |
|----------|---------|
| `.claude/` directory | `.opencode/` directory |
| CLAUDE.md | OPENCODE.md |
| 48 agents | 15 focused skills |
| Full Unity/Unreal support | Godot-focused |
| Claude-specific format | OpenCode skill format |

---

## Contributing

This is an adaptation of Claude-Code-Game-Studios. For the original project, see:
https://github.com/Donchitos/Claude-Code-Game-Studios

---

## License

MIT License - See original project for details.