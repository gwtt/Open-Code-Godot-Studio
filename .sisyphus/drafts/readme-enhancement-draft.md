# README Enhancement Draft Content

This file contains draft sections to be merged into README.md. These sections are independent of oh-my-openagent research.

---

## SECTION: Detailed Skill Usage Guide

### Skill Categories Overview

| Category | Skills | Purpose |
|----------|--------|---------|
| **Onboarding** | `start` | First-time guided setup |
| **Ideation** | `brainstorm` | Game concept development |
| **Engine Setup** | `setup-engine` | Configure Godot |
| **Planning** | `sprint-plan` | Development sprint planning |
| **Review** | `code-review`, `design-review` | Quality assurance |
| **Godot Technical** | `godot-specialist`, `godot-gdscript`, `godot-shader`, `godot-gdextension` | Engine-specific guidance |
| **Leadership** | `creative-director`, `technical-director`, `producer`, `game-designer`, `lead-programmer` | Team role simulation |

---

### Onboarding: `start` Skill

**Purpose**: Guided entry point for new projects. Detects project state and routes you to the right workflow.

**Invocation**:
```
Use the 'start' skill
```

**Workflow Steps**:
1. **Detect Project State** (automatic) — Checks for engine config, game concept, source code, prototypes
2. **Ask Where You Are** — Presents 4 options:
   - A) No idea yet
   - B) Vague idea
   - C) Clear concept
   - D) Existing work
3. **Route Based on Answer** — Recommends next skill
4. **Hand Off** — Skill completes after user picks direction

**Example Scenario**:
> User opens a fresh project folder with no files. Invoke `start`. The skill detects empty project, asks "Where are you?", user selects "B: Vague idea", skill recommends `/brainstorm` to develop it.

**Output**: Recommendation for next skill to use.

---

### Ideation: `brainstorm` Skill

**Purpose**: Develop vague game ideas into formalized game concepts using professional frameworks (MDA, player psychology, verb-first design).

**Invocation**:
```
Use the 'brainstorm' skill                           # Open exploration
Use the 'brainstorm' skill with "space exploration"  # Develop specific seed
```

**Workflow Steps**:
1. **Discovery Phase** — Explore interests, player feelings, core verbs, theme
2. **Concept Development** — Apply frameworks:
   - MDA Analysis (Mechanics → Dynamics → Aesthetics)
   - Design Pillars (3-5 foundational principles)
   - Player Psychology (Autonomy, Competence, Relatedness)
   - Target Player persona
3. **Scope Considerations** — Help user understand realistic scope (jam/small/medium/large)
4. **Engine Recommendation** — Recommend Godot based on concept needs
5. **Create Game Concept Document** — Draft `design/gdd/game-concept.md`
6. **User Approval** — Present document, get confirmation before saving

**Example Scenario**:
> User has vague idea "roguelike deckbuilder". Invoke `brainstorm` with seed. Skill explores what makes it unique, defines pillars like "Strategic depth over luck", creates formal concept document with core loop, target player, and recommended scope.

**Output**: `design/gdd/game-concept.md` — Formalized game concept document.

---

### Engine Setup: `setup-engine` Skill

**Purpose**: Configure Godot version, technical preferences, project structure, and coding standards.

**Invocation**:
```
Use the 'setup-engine' skill              # Guided setup
Use the 'setup-engine' skill with godot 4.3  # Specific version
```

**Workflow Steps**:
1. **Engine Selection** — If no version specified, check game concept for recommendations
2. **Version Confirmation** — Find latest stable via web search, confirm with user
3. **Update OPENCODE.md** — Add Technology Stack section
4. **Create Technical Preferences** — `.opencode/docs/technical-preferences.md` with:
   - Naming conventions (PascalCase, snake_case, UPPER_SNAKE_CASE)
   - Performance budgets (frame time, memory, load time)
   - Forbidden patterns (untyped vars, $NodePath in _process, deep inheritance)
   - Testing framework (GUT recommended)
5. **Create Engine Reference** — `.opencode/docs/engine-reference/godot/VERSION.md`
6. **Create Project Structure** — Standard directories:
   ```
   src/      (core, systems, gameplay, ui, utils)
   assets/   (sprites, audio, fonts, resources)
   design/   (gdd, levels)
   tests/
   prototypes/
   production/
   ```

**Example Scenario**:
> After brainstorming a 2D platformer, user invokes `setup-engine`. Skill confirms Godot 4.3, creates technical preferences enforcing static typing, sets up src/ directory structure, creates initial EventBus autoload template.

**Output**: 
- Updated `OPENCODE.md`
- `.opencode/docs/technical-preferences.md`
- `.opencode/docs/engine-reference/godot/VERSION.md`
- Project directory structure

---

### Planning: `sprint-plan` Skill

**Purpose**: Create development sprints with task breakdown, estimation, and progress tracking.

**Invocation**:
```
Use the 'sprint-plan' skill          # Create new sprint
Use the 'sprint-plan' skill with review   # Review current sprint
```

**Workflow Steps**:
1. **Gather Context** — Read game concept, check milestones, review backlog
2. **Sprint Duration** — Ask or default (1 week solo, 2 weeks teams)
3. **Capacity Planning** — Who's available, any time off, calculate velocity
4. **Backlog Review** — Present pending work options for prioritization
5. **Task Breakdown** — For each committed feature:
   - Break into smallest tasks
   - Identify dependencies
   - Estimate (story points or hours)
   - Assign owner
6. **Sprint Scope** — Calculate capacity vs planned work, adjust if over
7. **Create Sprint Document** — `production/sprints/sprint-[N]-[date].md`

**Example Scenario**:
> User has game concept and wants to start coding. Invoke `sprint-plan`. Skill reviews concept, asks for sprint duration (1 week), identifies MVP features from concept, breaks "Player movement" into tasks (input mapping, character controller, animation), estimates 5 points total, creates sprint document with daily update template.

**Output**: `production/sprints/sprint-1-[date].md` — Sprint plan with tasks, estimates, risks.

---

### Code Review: `code-review` Skill

**Purpose**: Review code quality, patterns, performance, and best practices with structured feedback.

**Invocation**:
```
Use the 'code-review' skill                    # Review recent changes
Use the 'code-review' skill with src/player/   # Review specific directory
Use the 'code-review' skill with player.gd     # Review specific file
```

**Workflow Steps**:
1. **Scope Definition** — What to review
2. **Automated Checks** — Static analysis, type checking, syntax errors
3. **Manual Review** — Check:
   - Correctness (edge cases, null safety)
   - Code Quality (naming, readability, no duplication)
   - Architecture (patterns, coupling, layers)
   - Performance (allocations, caching, _process usage)
   - Godot-Specific (static typing, @onready, signals, $ in hot paths)
   - Safety (error handling, memory leaks, thread safety)
4. **Categorize Findings** — Severity levels:
   - 🔴 Blocking (bugs, crashes, security)
   - 🟡 Important (performance, maintainability)
   - 🟢 Suggestion (style, minor improvements)
   - 💡 Info (educational notes)
5. **Generate Report** — Structured markdown report
6. **Follow-Up** — Ask if user wants help fixing issues

**Example Scenario**:
> User completed player movement code. Invoke `code-review` on `src/player/`. Skill finds untyped variable `var speed = 300`, flags as 🟡 Important, suggests `var speed: float = 300.0`. Finds `$HealthBar` in `_process`, flags as 🔴 Blocking for performance, recommends `@onready` caching.

**Output**: Code review report with categorized findings and fix recommendations.

---

### Design Review: `design-review` Skill

**Purpose**: Review game design documents, mechanics, systems for alignment with pillars and player experience goals.

**Invocation**:
```
Use the 'design-review' skill              # Review all design docs
Use the 'design-review' skill with combat.md    # Review specific document
```

**Workflow Steps**:
1. **Load Context** — Read game concept, pillars, target player
2. **Review Categories**:
   - Pillar Alignment (which pillar, conflict check)
   - Player Experience (fantasy, core loop, rewards, progression)
   - Mechanics (rules, edge cases, learning curve, depth)
   - Balance (options balanced, dominant strategies, difficulty curve)
   - Player Psychology (autonomy, competence, relatedness)
   - Scope Reality (achievable, dependencies identified)
3. **Document Quality Check** — Structure, clarity, completeness
4. **Categorize Findings** — Same severity levels as code-review
5. **Generate Report** — Pillar alignment table, issues, suggestions, strengths
6. **Follow-Up** — Offer help revising problematic areas

**Example Scenario**:
> User drafted combat system design. Invoke `design-review` on `combat.md`. Skill checks if combat supports pillars "Tactical depth" and "Meaningful choice", finds dominant strategy issue (one weapon always best), flags as 🔴 Critical for pillar violation, recommends adding trade-offs.

**Output**: Design review report with pillar alignment matrix and actionable recommendations.

---

### Godot Technical Skills

#### `godot-specialist` — Engine Architecture

**Purpose**: Authority on Godot patterns, APIs, optimization. Guides GDScript vs C# vs GDExtension decisions.

**When to Use**:
- Choosing between languages for a feature
- Designing scene/node architecture
- Setting up autoloads, project settings
- Optimizing rendering, physics, memory
- Platform export configuration

**Key Guidance**:
| Feature Type | Recommended Language |
|--------------|---------------------|
| Game logic, UI, state | GDScript |
| Heavy math, pathfinding | GDExtension (C++/Rust) |
| Cross-platform .NET libs | C# |
| Performance-critical (>1000 calls/frame) | GDExtension |

**Best Practices Enforced**:
- Composition over inheritance
- Static typing everywhere
- @onready for node references
- Signals for decoupling
- Minimize `_process()` usage

---

#### `godot-gdscript` — GDScript Patterns

**Purpose**: GDScript-specific quality: static typing, design patterns, signal architecture, optimization.

**When to Use**:
- Writing GDScript code
- Refactoring GDScript patterns
- Performance optimization in GDScript
- Signal architecture design

**Standards Enforced**:
```gdscript
# Naming
class_name PlayerCharacter        # PascalCase
var move_speed: float = 300.0     # snake_case + type
const MAX_HEALTH: int = 100       # UPPER_SNAKE_CASE
signal health_changed(new_hp: int) # typed parameters

# Organization order
# 1. class_name  2. extends  3. constants  4. signals
# 5. @export vars  6. public vars  7. private vars
# 8. @onready vars  9. lifecycle methods  10. public methods
```

---

#### `godot-shader` — Shaders & VFX

**Purpose**: Godot shading language, visual shaders, particles, post-processing, rendering optimization.

**When to Use**:
- Creating custom shaders
- Visual shader graphs
- Particle systems
- Post-processing effects
- Rendering pipeline optimization

---

#### `godot-gdextension` — Native Extensions

**Purpose**: C++/Rust native bindings, custom nodes, high-performance modules.

**When to Use**:
- Performance-critical code (>1000 calls/frame)
- Custom native nodes
- Integration with external C++/Rust libraries
- Memory-sensitive operations

---

### Leadership Skills

These skills simulate team roles. Use them when you need role-specific perspective on decisions.

#### `creative-director` — Vision & Pillars

**Purpose**: Guardian of game's vision, tone, creative direction. Ensures all decisions align with pillars.

**When to Use**:
- Defining or revising game pillars
- Resolving conflicts between design decisions
- Major creative decisions (genre, tone, audience)
- Reviewing feature alignment with vision

**Key Output**: Pillar decision framework — for any decision, ask:
1. Does this support pillar X?
2. Does this conflict with any pillar?
3. Is this essential or feature creep?

---

#### `technical-director` — Architecture & Technology

**Purpose**: Technical vision, architecture decisions, technology choices, performance targets.

**When to Use**:
- Major architecture decisions (ADRs)
- Technology stack choices
- Setting coding standards
- Evaluating technical debt vs feature work
- Performance budget planning

**Key Output**: Architecture Decision Records (ADRs) documenting:
- Context, Decision, Consequences, Alternatives

---

#### `producer` — Schedule & Scope

**Purpose**: Project schedule, resources, scope management, coordination.

**When to Use**:
- Planning sprints and milestones
- Managing scope and priorities
- Tracking progress and blockers
- Risk assessment

**Key Output**: Milestone plans, sprint documents, risk register.

---

#### `game-designer` — Mechanics & Systems

**Purpose**: Creating and refining mechanics, systems, progression, economy.

**When to Use**:
- Designing game mechanics
- Creating progression systems
- Balancing gameplay
- Writing design documents

**Key Output**: System design documents with mechanics, data, UI/UX, edge cases.

---

#### `lead-programmer` — Code Architecture & Standards

**Purpose**: Code architecture, review standards, team coordination, technical debt.

**When to Use**:
- Designing system architecture
- Setting coding standards
- Leading code reviews
- Estimating technical work
- Managing technical debt

**Key Output**: Architecture patterns, code review checklists, estimation scales.

---

## SECTION: OpenCode Agent System Guide

### Agent Types (Built-in)

OpenCode provides specialized subagents for different tasks. Understanding when to use each agent maximizes efficiency.

| Agent | Cost | Purpose | When to Use |
|-------|------|---------|-------------|
| **explore** | FREE | Contextual grep for codebases | Finding patterns, understanding code structure, discovering implementations |
| **librarian** | CHEAP | Reference grep (external docs, OSS, web) | Unfamiliar libraries, official docs, GitHub examples, best practices |
| **oracle** | EXPENSIVE | Read-only consultation | Architecture decisions, debugging after 2+ failures, security/performance concerns |
| **metis** | EXPENSIVE | Pre-planning consultant | Ambiguous requirements, scope clarification, identifying hidden intentions |
| **momus** | EXPENSIVE | Expert reviewer | Plan evaluation, quality assurance, catching gaps and ambiguities |

### Agent Decision Matrix

| Your Need | Recommended Agent | Alternative |
|-----------|-------------------|-------------|
| "How does X work in this codebase?" | `explore` | Direct grep if you know exact pattern |
| "What's the best practice for [library]?" | `librarian` | Web search if library docs are online |
| "Is this architecture decision sound?" | `oracle` | Ask team if available |
| "This request is ambiguous, what's the scope?" | `metis` | Ask user directly if quick |
| "Is this plan complete and verifiable?" | `momus` | Self-review if simple |

### Agent Invocation Syntax

Agents are invoked by the orchestrator (Sisyphus) automatically when patterns match. You can request:

```
Consult oracle for architecture advice on [topic]
Use explore to find implementations of [pattern]
Ask librarian for [library] best practices
```

**Note**: Agents run in background by default. Results arrive via system notification.

---

### Categories (Domain-Optimized Models)

OpenCode uses domain-specific categories for task execution. Each category is optimized for its domain.

| Category | Domain | Best For |
|----------|--------|----------|
| **visual-engineering** | UI, UX, CSS, styling | Frontend components, layouts, animations |
| **ultrabrain** | Hard logic, algorithms | Architecture decisions, complex algorithms |
| **deep** | Autonomous problem-solving | Multi-step research + implementation |
| **artistry** | Creative approaches | Unconventional solutions, outside standard patterns |
| **quick** | Trivial tasks | Typos, single-file changes, simple configs |
| **writing** | Documentation | READMEs, docs, prose |
| **unspecified-low/high** | General tasks | Tasks not matching other categories |

---

### Skills vs Agents: When to Use Each

| Situation | Use Skills | Use Agents |
|-----------|------------|------------|
| Following established workflow | ✅ Skills provide step-by-step guidance | ❌ |
| Domain-specific expertise | ✅ Skills contain specialized knowledge | ❌ |
| Searching codebase | ❌ | ✅ `explore` agent |
| Finding external docs | ❌ | ✅ `librarian` agent |
| Architecture consultation | ❌ | ✅ `oracle` agent |
| Ambiguity resolution | ❌ | ✅ `metis` agent |
| Plan review | ❌ | ✅ `momus` agent |

**Key Insight**: Skills are **instructional guides** you follow. Agents are **workers** you delegate to.

---

### Common Workflow Combinations

| Workflow | Skills Used | Agents Used |
|----------|-------------|-------------|
| **New Project Onboarding** | `start` → `brainstorm` → `setup-engine` | None (user-driven) |
| **Sprint Planning** | `sprint-plan` | `explore` (to understand existing code) |
| **Code Quality Pass** | `code-review` | `explore` (to find patterns), `oracle` (for architecture questions) |
| **Design Validation** | `design-review` | `oracle` (for pillar alignment questions) |
| **Feature Implementation** | `godot-specialist`, `godot-gdscript` | `explore` (find similar code), `librarian` (API docs), `oracle` (complex decisions) |

---

### Cost-Efficient Agent Usage

1. **Start with FREE agents** — `explore` for internal searches
2. **Escalate to CHEAP** — `librarian` for external docs
3. **Use EXPENSIVE sparingly** — `oracle`, `metis`, `momus` for complex/high-value decisions
4. **Parallelize** — Fire multiple agents simultaneously for independent searches
5. **Wait for results** — Don't poll; let system notify you

---

## SECTION: oh-my-openagent Compatibility

### What is oh-my-openagent?

**Oh My OpenAgent (OmO)** is a multi-model agent orchestration harness for OpenCode. It transforms a single AI agent into a coordinated development team that ships code through specialized agent collaboration.

**Official Documentation**: [ohmyopenagent.com/docs](https://ohmyopenagent.com/docs)

**GitHub**: [code-yeongyu/oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)

---

### Architecture Comparison

| Aspect | OpenCode Game Studios | oh-my-openagent |
|--------|----------------------|-----------------|
| **Purpose** | Game dev workflow skills | Multi-agent orchestration |
| **Core** | 15 domain-specific skills | Sisyphus orchestrator + subagents |
| **Structure** | `.opencode/skills/` directory | Plugin-based architecture |
| **Agents** | Built-in (explore, librarian, oracle, metis, momus) | Prometheus (planning), Atlas (execution), Oracle, Librarian, Explore |
| **Categories** | 7 domain categories | 7+ domain categories (visual-engineering, ultrabrain, deep, artistry, quick, writing) |
| **Skills** | Instructional guides in SKILL.md | Skills with embedded MCPs |

---

### Compatibility Status: ✅ COMPATIBLE

**Yes, OpenCode Game Studios can be used with oh-my-openagent.**

OmO provides explicit compatibility with OpenCode-style ecosystems through:

1. **Compatibility Layer** — OpenCode can load OmO configurations without breaking existing setups
2. **Plugin Naming** — Both `oh-my-openagent` and legacy `oh-my-opencode` entries are recognized
3. **Category Alignment** — Both use semantic categories (visual-engineering, ultrabrain, etc.) for routing

**Evidence** (from OmO installation guide):
> "The compatibility layer now prefers the plugin entry `oh-my-openagent`, while legacy `oh-my-opencode` entries still load with a warning. Plugin config loading recognizes both `oh-my-openagent.json[c]` and `oh-my-opencode.json[c]` during the transition."

Source: [installation.md](https://github.com/code-yeongyu/oh-my-openagent/blob/main/docs/guide/installation.md)

---

### Integration Recommendations

| Scenario | Recommendation |
|----------|----------------|
| **Using OmO already** | OpenCode Game Studios skills work alongside OmO — add `.opencode/skills/` directory |
| **Using OpenCode only** | Can adopt OmO later without breaking existing skills setup |
| **New project** | Start with OpenCode Game Studios skills, add OmO orchestration if you need multi-agent coordination |
| **Team coordination** | OmO's three-layer architecture (Planning → Execution → Worker) complements skill-based workflows |

---

### How They Work Together

```
┌─────────────────────────────────────────────────────────────┐
│                    User Request                              │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                 Sisyphus (OmO Orchestrator)                  │
│  Routes to skills or agents based on request type           │
└─────────────────────────────────────────────────────────────┘
                           ↓
        ┌──────────────────┴──────────────────┐
        ↓                                     ↓
┌───────────────────┐                 ┌───────────────────┐
│   OmO Agents      │                 │  Game Studios     │
│  (explore,        │                 │    Skills         │
│   librarian,      │                 │  (godot-specialist│
│   oracle, etc.)   │                 │   brainstorm,     │
│                   │                 │   sprint-plan...) │
└───────────────────┘                 └───────────────────┘
```

**Key Insight**: OmO provides the **orchestration layer** (Sisyphus routing), while Game Studios skills provide **domain-specific workflows** for game development.

---

### Migration Note

If you see a "Using legacy package name" warning:
1. Update your `opencode.json` plugin entry
2. Change `"oh-my-opencode"` → `"oh-my-openagent"`
3. Both naming conventions work during transition

---

### Related Resources

- [OmO Overview](https://github.com/code-yeongyu/oh-my-openagent/blob/main/docs/guide/overview.md)
- [OmO Orchestration Guide](https://github.com/code-yeongyu/oh-my-openagent/blob/main/docs/guide/orchestration.md)
- [OmO Installation (OpenCode compatibility)](https://github.com/code-yeongyu/oh-my-openagent/blob/main/docs/guide/installation.md)

---

## Integration Notes

This draft content should be integrated into README.md as follows:

1. Replace "Using the Skills" section with "Detailed Skill Usage Guide"
2. Add "OpenCode Agent System Guide" as new section
3. Add "Working with Agents and Skills" as new section  
4. Add "oh-my-openagent Compatibility" as new section
5. Keep existing sections (Features, Project Structure, Key Differences, Contributing, License)