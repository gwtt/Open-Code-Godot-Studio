---
name: setup-engine
description: Configure the project's game engine and version. Pins the engine in OPENCODE.md, creates reference docs, and sets up technical preferences for Godot.
license: MIT
---

# Setup Engine Skill

Configure Godot engine settings, project structure, and technical preferences.

## Workflow

### 1. Parse Arguments

- `/setup-engine` — Guided setup
- `/setup-engine godot 4.3` — Specific version

### 2. Engine Selection (if guided)

If no engine specified:

1. Check for existing game concept in `design/gdd/game-concept.md`
2. If no concept, ask about project needs:
   - 2D, 3D, or both?
   - Target platforms?
   - Team size and experience?
   - Language preferences?
   - Budget constraints?

3. Provide recommendation based on needs

### Godot Decision Matrix

| Factor | Godot 4 |
|--------|---------|
| **Best for** | 2D games, small-mid 3D, solo/small teams |
| **Language** | GDScript (+ C#, C++ via GDExtension) |
| **Cost** | Free, MIT license |
| **Learning curve** | Gentle |
| **2D support** | Excellent (native) |
| **3D quality** | Good (improving rapidly) |
| **Web export** | Yes (native) |
| **Console export** | Via third-party |
| **Open source** | Yes |

### 3. Version Selection

If version not provided:

1. Use WebSearch to find latest stable version
2. Confirm with user: "Latest stable Godot is [version]. Use this?"

### 4. Update OPENCODE.md

Update the Technology Stack section:

```markdown
## Technology Stack

- **Engine**: Godot [version]
- **Language**: GDScript (primary), C++ via GDExtension (performance-critical)
- **Version Control**: Git with trunk-based development
- **Build System**: SCons (engine), Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

### 5. Create Technical Preferences

Create `.opencode/docs/technical-preferences.md`:

```markdown
# Technical Preferences

## Engine & Language

- **Engine**: Godot [version]
- **Primary Language**: GDScript
- **Performance**: GDExtension (C++/Rust) when needed

## Naming Conventions

### GDScript
- Classes: PascalCase (`PlayerController`)
- Variables/functions: snake_case (`move_speed`)
- Signals: snake_case past tense (`health_changed`)
- Files: snake_case (`player_controller.gd`)
- Scenes: PascalCase (`PlayerController.tscn`)
- Constants: UPPER_SNAKE_CASE (`MAX_HEALTH`)

## Performance Budgets

- **Frame time**: <16.6ms (60fps target)
- **Memory**: Platform-specific
- **Load time**: <3s initial

## Testing

- **Framework**: GUT (Godot Unit Test)
- **Coverage**: Critical paths required

## Forbidden Patterns

- [ ] Untyped variables
- [ ] `$NodePath` in `_process()`
- [ ] Deep inheritance (>3 levels)
- [ ] God-class autoloads
- [ ] Connecting signals in `_process()`
```

### 6. Create Engine Reference

Create `.opencode/docs/engine-reference/godot/VERSION.md`:

```markdown
# Godot Version Reference

| Field | Value |
|-------|-------|
| **Engine** | Godot |
| **Version** | [version] |
| **Configured** | [date] |

## Key Features

- GDScript 2.0
- Improved 3D rendering
- Vulkan support
- Native 2D engine

## Notes

[Version-specific notes based on current release]
```

### 7. Create Project Structure

Create standard directories:

```
src/
├── core/           # Core utilities
├── systems/        # Game systems
├── gameplay/       # Game logic
├── ui/             # UI components
└── utils/          # Helpers

assets/
├── sprites/
├── audio/
├── fonts/
└── resources/

design/
├── gdd/
└── levels/

tests/
prototypes/
production/
```

### 8. Output Summary

```
Engine Setup Complete
=====================
Engine:          Godot [version]
OPENCODE.md:     Updated
Tech Prefs:      Created
Reference Docs:  Created
Project Structure: Created

Next Steps:
1. Review .opencode/docs/technical-preferences.md
2. Run /brainstorm if no game concept
3. Design core systems
4. /sprint-plan to organize work
```

## Godot-Specific Setup

### Project Settings Recommendations

```gdscript
# Recommended project settings

# Rendering
rendering/renderer/rendering_method="forward_plus"  # For 3D
# or "gl_compatibility" for broader support

# Input
# Add input map entries for common actions:
# - move_up, move_down, move_left, move_right
# - jump, attack, interact, pause

# Layer Names
# Configure physics and render layers for your game

# Autoloads
# Add only when truly needed:
# - EventBus (global signals)
# - GameManager (state management)
# - SaveManager (persistence)
```

### Initial Autoload Template

```gdscript
# event_bus.gd
extends Node

# Global signals for cross-system communication
signal game_paused
signal game_resumed
signal scene_changed(scene_name: String)
```

## Collaborative Protocol

1. **Ask before creating** — Show what will be created
2. **Use defaults** — Apply sensible defaults, allow customization
3. **Document decisions** — Record why choices were made