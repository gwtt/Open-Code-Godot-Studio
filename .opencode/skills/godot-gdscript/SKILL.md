---
name: godot-gdscript
description: GDScript specialist for all GDScript code quality: static typing enforcement, design patterns, signal architecture, coroutine patterns, performance optimization, and GDScript-specific idioms.
license: MIT
---

# GDScript Specialist Skill

**Tier 3: Specialist — Enforcement Role**

This skill ensures clean, typed, and performant GDScript across Godot 4 projects.

## Purpose

Use this skill when:
- Writing or reviewing GDScript code
- Designing signal architecture
- Implementing GDScript design patterns (state machines, observer, etc.)
- Optimizing GDScript performance
- Enforcing static typing standards

## Coding Standards Reference

**MUST follow**: `.opencode/docs/coding-standards.md`

All GDScript code must comply with:
- Static typing (MANDATORY)
- Naming conventions (snake_case, PascalCase, UPPER_SNAKE_CASE)
- File organization standards
- Signal architecture patterns
- Performance thresholds (>1000 calls/frame → consider GDExtension)

**Zero Tolerance**: Untyped code is forbidden. All variables, parameters, and return types must have explicit type annotations.

## Static Typing (Mandatory)

ALL variables must have explicit type annotations:

```gdscript
var health: float = 100.0          # YES
var inventory: Array[Item] = []    # YES - typed array
var health = 100.0                 # NO - untyped
```

ALL function parameters and return types must be typed:

```gdscript
func take_damage(amount: float, source: Node3D) -> void:    # YES
func get_items() -> Array[Item]:                              # YES
func take_damage(amount, source):                             # NO
```

Use `@onready` instead of `$` in `_ready()`:

```gdscript
@onready var health_bar: ProgressBar = %HealthBar    # YES - unique name
@onready var sprite: Sprite2D = $Visuals/Sprite2D    # YES - typed path
```

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Classes | PascalCase | `class_name PlayerCharacter` |
| Functions | snake_case | `func calculate_damage()` |
| Variables | snake_case | `var current_health: float` |
| Constants | UPPER_SNAKE_CASE | `const MAX_SPEED: float = 500.0` |
| Signals | snake_case, past tense | `signal health_changed`, `signal died` |
| Enums | PascalCase name, UPPER_SNAKE_CASE values | `enum DamageType { PHYSICAL, MAGICAL }` |
| Private | underscore prefix | `var _internal_state: int` |

## File Organization

One `class_name` per file — file name matches class in snake_case:
- `player_character.gd` → `class_name PlayerCharacter`

Section order:
1. `class_name` declaration
2. `extends` declaration
3. Constants and enums
4. Signals
5. `@export` variables
6. Public variables
7. Private variables (`_prefixed`)
8. `@onready` variables
9. Built-in virtual methods (`_ready`, `_process`, `_physics_process`)
10. Public methods
11. Private methods
12. Signal callbacks (`_on_*`)

## Signal Architecture

- **Signals for upward communication** — child → parent, system → listeners
- **Direct calls for downward** — parent → child
- **Typed parameters**:

```gdscript
signal health_changed(new_health: float, max_health: float)
signal item_added(item: Item, slot_index: int)
```

- **Connect in _ready()**:

```gdscript
func _ready() -> void:
    health_component.health_changed.connect(_on_health_changed)
```

- **Use CONNECT_ONE_SHOT** for one-time events
- **Disconnect when freeing** — prevents errors

## Coroutines and Async

```gdscript
await get_tree().create_timer(1.0).timeout
await animation_player.animation_finished
```

- Return `Signal` or use signals to notify completion
- Check `is_instance_valid(self)` after await
- Don't chain more than 3 awaits — extract to functions

## Export Variables

```gdscript
@export var move_speed: float = 300.0
@export var jump_height: float = 64.0
@export_range(0.0, 1.0, 0.05) var crit_chance: float = 0.1

@export_group("Combat")
@export var attack_damage: float = 10.0
@export var attack_range: float = 2.0
```

## Design Patterns

### State Machine (Simple)

```gdscript
enum State { IDLE, RUNNING, JUMPING, FALLING, ATTACKING }
var _current_state: State = State.IDLE
```

### State Machine (Complex)

Node-based: each state is a child Node with `enter()`, `exit()`, `process()`

### Resource Pattern

```gdscript
class_name WeaponData extends Resource
@export var damage: float = 10.0
@export var attack_speed: float = 1.0
@export var weapon_type: WeaponType
```

Resources are shared — use `resource.duplicate()` for per-instance data.

### Autoload Pattern

Only for global systems: `EventBus`, `GameManager`, `SaveManager`, `AudioManager`

```gdscript
var game_manager: GameManager = GameManager  # typed autoload access
```

### Composition Over Inheritance

```gdscript
@onready var health_component: HealthComponent = %HealthComponent
@onready var hitbox_component: HitboxComponent = %HitboxComponent
```

Maximum inheritance depth: 3 levels (after `Node` base)

## Performance

### Process Functions

```gdscript
set_process(false)
set_physics_process(false)
```

Disable when not needed. Re-enable only when node has work.

### Hot Path Rules

- Cache node references in `@onready` — never `get_node()` in `_process`
- Use `StringName` for frequent comparisons (`&"animation_name"`)
- Avoid `Array.find()` — use Dictionary lookups
- Object pooling for spawn/despawn objects
- Profile with built-in Profiler — identify frames > 16ms
- Use typed arrays `Array[Type]` — faster than untyped

### GDScript vs GDExtension Boundary

| Stay in GDScript | Move to GDExtension |
|------------------|---------------------|
| Game logic, state | Heavy math, pathfinding |
| UI, scene transitions | Procedural generation |
| Standard gameplay | >1000 calls/frame |

## Anti-Patterns

- ❌ Untyped variables/functions (disables compiler optimizations)
- ❌ `$NodePath` in `_process` instead of `@onready` caching
- ❌ Deep inheritance instead of composition
- ❌ Signals for synchronous communication
- ❌ String comparisons instead of enums/StringName
- ❌ Dictionaries for structured data (use typed Resources)
- ❌ God-class Autoloads
- ❌ Editor signal connections (invisible in code)

## Scene Assembly Protocol (NEW - replaces tscn generation)

### ⚠️ NEVER generate .tscn files directly

LLM-generated scene files are prone to errors:
- Invalid node paths
- Wrong resource UID references
- Property type mismatches

### Instead: Provide Assembly Guide

**After generating GDScript, output:**

```markdown
## Scene Assembly Instructions

### Node Tree
```
[RootNode] (type)
├── [Child1] (type) — purpose
├── [Child2] (type) — purpose
│   └── [SubChild] (type) — purpose
```

### Required Components
| Node | Properties | Script |
|------|------------|--------|
| Player | position: (100, 200) | player_controller.gd |

### Assembly Steps
1. Create root: Add Node → [NodeType]
2. Attach script: Drag file to node
3. Add children: Add Node → set properties
4. Enable Unique Names: Right-click → Access as Unique Name
```

**ASK**: "Scripts created. Follow assembly guide in editor?"

## Completion Recommendations (NEW)

### After GDScript Implementation

**Step 1: Quick LSP Check**

**TRY**: `lsp_diagnostics` on modified .gd files

**IF errors found**:
```
⚠️ LSP detected [N] issues. Fix before review.
Run `/code-review` after fixing.
```

**Step 2: Suggest Next Steps**

| Implementation Type | Recommended Next Steps |
|---------------------|------------------------|
| Core gameplay code | `/code-review` → Review quality |
| UI code | `/design-review --system UI` → UX validation |
| Performance-critical | Profile in Godot editor first |
| New system | `/technical-director` → Architecture check |

**ASK**: "Would you like to run `/code-review` on these changes?"

## Version Awareness

1. Read `.opencode/docs/engine-reference/godot/VERSION.md`
2. Check `deprecated-apis.md` for APIs you plan to use
3. Check `breaking-changes.md` for version transitions
4. Read `current-best-practices.md` for new GDScript features