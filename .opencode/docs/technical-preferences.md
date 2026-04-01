# Technical Preferences

This document defines the technical standards and preferences for the project.

## Engine & Language

- **Engine**: Godot 4.6.1
- **Primary Language**: GDScript
- **Performance Language**: GDExtension (C++/Rust) when needed
- **Version Control**: Git

## Naming Conventions

### GDScript

| Element | Convention | Example |
|---------|------------|---------|
| Classes | PascalCase | `PlayerController` |
| Functions | snake_case | `calculate_damage()` |
| Variables | snake_case | `current_health` |
| Constants | UPPER_SNAKE_CASE | `MAX_HEALTH` |
| Signals | snake_case (past tense) | `health_changed` |
| Files | snake_case | `player_controller.gd` |
| Scenes | PascalCase | `PlayerController.tscn` |
| Private members | underscore prefix | `_internal_state` |

### File Organization

```
project/
├── src/
│   ├── core/           # Engine-independent utilities
│   ├── systems/        # Game systems (audio, save, etc.)
│   ├── gameplay/       # Game-specific logic
│   ├── ui/             # UI components
│   └── utils/          # Helper utilities
├── assets/
│   ├── sprites/
│   ├── audio/
│   ├── fonts/
│   └── resources/      # .tres resource files
├── design/
│   └── gdd/
├── tests/
├── prototypes/
└── production/
```

## Performance Budgets

| Metric | Target |
|--------|--------|
| Frame time | <16.6ms (60fps) |
| Memory | Platform-specific |
| Load time | <3s initial |
| Draw calls | Profile per platform |

## Testing

- **Framework**: GUT (Godot Unit Test)
- **Coverage**: Critical paths required
- **Pattern**: Arrange-Act-Assert

## Forbidden Patterns

- [ ] Untyped variables or functions
- [ ] `$NodePath` in `_process()` or `_physics_process()`
- [ ] Deep inheritance (>3 levels after Node)
- [ ] God-class autoloads
- [ ] Connecting signals in `_process()`
- [ ] Magic numbers without constants
- [ ] Circular dependencies

## Recommended Patterns

- [ ] Static typing everywhere
- [ ] `@onready` for node references
- [ ] Signals for decoupled communication
- [ ] Resources for data-driven design
- [ ] Composition over inheritance
- [ ] State machines for stateful behavior

## Dependencies

- Engine: Godot 4.6.1
- Testing: GUT (Godot Unit Test)
- Version Control: Git

## Code Review Checklist

- [ ] Static typing used
- [ ] Naming conventions followed
- [ ] No forbidden patterns
- [ ] Performance considerations addressed
- [ ] Edge cases handled
- [ ] Error handling present
- [ ] Comments explain "why" not "what"