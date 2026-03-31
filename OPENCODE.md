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

## Available Skills (Slash Commands)

Type `/` to access game development skills:

**Godot-Specific:**
- `/godot-setup` — Configure Godot project settings and structure
- `/godot-review` — Review GDScript code for best practices
- `/godot-optimize` — Profile and optimize Godot performance

**Production:**
- `/start` — Guided onboarding for new projects
- `/brainstorm` — Explore game ideas from scratch
- `/sprint-plan` — Plan development sprints
- `/milestone-review` — Review milestone progress

**Reviews & Analysis:**
- `/design-review` — Review game design documents
- `/code-review` — Review code quality and patterns
- `/balance-check` — Analyze game balance and progression
- `/perf-profile` — Profile and analyze performance

**Creative:**
- `/prototype` — Rapid prototype a mechanic
- `/playtest-report` — Document playtest findings

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

> **First session?** Run `/start` to begin the guided onboarding flow.