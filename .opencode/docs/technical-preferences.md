# Technical Preferences

This document defines the technical standards and preferences for the project.

---

## Engine & Language

- **Engine**: Godot 4.6.1
- **Languages**: C# (primary) + GDScript (optional)
- **Performance**: GDExtension (C++/Rust) when needed
- **Version Control**: Git

### Language Selection Guide

| Use C# When (Primary) | Use GDScript When (Optional) |
|-----------------------|------------------------------|
| Default choice for all new code | Quick prototyping only |
| Need .NET ecosystem | Small-medium team learning Godot |
| External .NET libraries | Very simple game logic |
| Complex data processing | Rapid iteration without compilation |
| Large codebase | Prefer lightweight syntax |
| Better AI code generation | |

---

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

### C#

| Element | Convention | Example |
|---------|------------|---------|
| Classes | PascalCase | `PlayerController` |
| Methods | PascalCase | `TakeDamage()` |
| Properties | PascalCase | `CurrentHealth` |
| Fields (private) | _camelCase | `_internalState` |
| Local variables | camelCase | `currentHealth` |
| Constants | PascalCase | `MaxHealth` |
| Signals | PascalCase (EventHandler) | `HealthChangedEventHandler` |
| Files | PascalCase | `PlayerController.cs` |
| Events | PascalCase | `HealthChanged` |

---

## File Organization

### C# Primary Project Structure

```
project/
├── src/
│   ├── core/           # Engine-independent utilities (C#)
│   ├── systems/        # Game systems (audio, save, etc.)
│   ├── gameplay/       # Game-specific logic (C# primary)
│   │   ├── *.cs        # C# files (primary language)
│   │   └── *.gd        # GDScript files (optional, when needed)
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

### Language-Specific Directories (Optional)

If you prefer separation:

```
src/
├── gdscript/           # GDScript only
├── csharp/             # C# only
└── shared/             # Language-agnostic resources
```

---

## API Style Comparison

| Task | C# (Primary) | GDScript (Optional) |
|------|--------------|---------------------|
| Node reference | `[Export] public Sprite2D Sprite { get; set; }` | `@onready var sprite = $Sprite` |
| Signal | `[Signal] delegate void HealthChangedEventHandler(float val);` | `signal health_changed(val)` |
| Export | `[Export] public float Speed { get; set; }` | `@export var speed: float` |
| Ready | `public override void _Ready()` | `func _ready():` |
| Process | `public override void _Process(double delta)` | `func _process(delta):` |
| Print | `GD.Print("hello")` | `print("hello")` |
| Random | `GD.Randf()` | `randf()` |

---

## Performance Budgets

| Metric | Target |
|--------|--------|
| Frame time | <16.6ms (60fps) |
| Memory | Platform-specific |
| Load time | <3s initial |
| Draw calls | Profile per platform |

---

## Testing

| Language | Framework |
|----------|-----------|
| GDScript | GUT (Godot Unit Test) |
| C# | NUnit / xUnit |

---

## Forbidden Patterns

### GDScript
- [ ] Untyped variables or functions
- [ ] `$NodePath` in `_process()` or `_physics_process()`
- [ ] Deep inheritance (>3 levels)
- [ ] God-class autoloads
- [ ] Connecting signals in `_process()`
- [ ] Magic numbers without constants

### C#
- [ ] `Console.WriteLine()` (use `GD.Print()`)
- [ ] Missing `partial` on Godot classes
- [ ] Using `yield` (use `await ToSignal()`)
- [ ] NodePath + GetNode pattern (use direct `[Export]` node type)
- [ ] Hardcoded node paths (use Scene Unique Nodes `%Name`)
- [ ] Event memory leaks (unsubscribe in `_ExitTree()`)
- [ ] Newtonsoft.Json (use `System.Text.Json`)

### Both Languages
- [ ] Circular dependencies
- [ ] Untyped code
- [ ] Deep inheritance (>3 levels)

---

## Recommended Patterns

### GDScript
- [ ] Static typing everywhere
- [ ] `@onready` for node references
- [ ] Signals for decoupled communication
- [ ] Resources for data-driven design

### C# (Godot 4.6.1)
- [ ] `[GlobalClass]` for custom nodes
- [ ] `[Export]` node types directly (not NodePath)
- [ ] Scene Unique Nodes (`%NodeName`)
- [ ] `System.Text.Json` for serialization
- [ ] `Tr()` for localization
- [ ] async/await with `ToSignal()`
- [ ] Properties for public data

### Both Languages
- [ ] Composition over inheritance
- [ ] State machines for stateful behavior
- [ ] Object pooling for frequent spawns

---

## Dependencies

- **Engine**: Godot 4.6.1
- **Testing GDScript**: GUT
- **Testing C#**: NUnit / xUnit
- **JSON (C#)**: System.Text.Json (.NET 8 built-in)
- **Version Control**: Git

---

## Code Review Checklist

### GDScript
- [ ] Static typing used
- [ ] snake_case conventions
- [ ] Signals properly typed
- [ ] No forbidden patterns

### C#
- [ ] PascalCase conventions
- [ ] Proper use of `[Export]`
- [ ] Events properly connected/disconnected
- [ ] async/await patterns correct

### Both
- [ ] Naming conventions followed
- [ ] Performance considerations addressed
- [ ] Edge cases handled
- [ ] Error handling present
- [ ] Comments explain "why" not "what"