# GDScript Code Rules

Applies to: `**/*.gd`

## Enforced Standards

### Static Typing (MANDATORY)

- ALL variables must have explicit types
- ALL function parameters must be typed
- ALL function return types must be specified
- Use typed arrays `Array[Type]`

```gdscript
# ✅ Good
var health: int = 100
var inventory: Array[Item] = []
func take_damage(amount: int) -> void:
    pass
func get_items() -> Array[Item]:
    return inventory

# ❌ Bad
var health = 100
var inventory = []
func take_damage(amount):
    pass
func get_items():
    return inventory
```

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Classes | PascalCase | `PlayerCharacter` |
| Functions | snake_case | `calculate_damage()` |
| Variables | snake_case | `current_health` |
| Constants | UPPER_SNAKE_CASE | `MAX_HEALTH` |
| Signals | snake_case past tense | `health_changed` |
| Private | underscore prefix | `_internal_state` |

### Node References

- Use `@onready` for node references
- Prefer unique names (`%NodeName`)
- Type all references

```gdscript
# ✅ Good
@onready var health_bar: ProgressBar = %HealthBar
@onready var sprite: Sprite2D = $Visuals/Sprite2D

# ❌ Bad
func _process(_delta):
    $HealthBar.value = health  # No caching!
```

### File Organization

Standard order within a GDScript file:

1. `class_name` declaration
2. `extends` declaration
3. Constants and enums
4. Signals
5. `@export` variables
6. Public variables
7. Private variables (`_prefix`)
8. `@onready` variables
9. Built-in virtual methods (`_ready`, `_process`, etc.)
10. Public methods
11. Private methods
12. Signal callbacks (`_on_*`)

### Signal Declaration

- Declare signals at the top of the script
- Include types for all parameters
- Use past tense for event names

```gdscript
# ✅ Good
signal health_changed(new_health: int, max_health: int)
signal item_picked_up(item: Item, count: int)
signal died()

# ❌ Bad
signal healthChanged  # Wrong convention
signal update  # Too vague
signal pickup(item)  # No type
```

### Performance Rules

- Disable `_process` when not needed
- Cache node references
- Use `StringName` for frequent string comparisons

```gdscript
# ✅ Good
@onready var sprite: Sprite2D = $Sprite
var animation_name: StringName = &"walk"

func _ready() -> void:
    set_process(false)

func start_processing() -> void:
    set_process(true)

# ❌ Bad
func _process(_delta):
    if false:  # Always false, wasting cycles
        pass
```

### Export Organization

- Group related exports
- Use `@export_range` for numeric constraints
- Provide sensible defaults

```gdscript
# ✅ Good
@export_group("Movement")
@export var move_speed: float = 300.0
@export_range(0.0, 1000.0) var acceleration: float = 1500.0

@export_group("Combat")
@export var damage: int = 10
@export var attack_range: float = 2.0

# ❌ Bad
@export var a: float
@export var b: float
@export var c: float  # No grouping, no defaults, no constraints
```

## Common Anti-Patterns

### Avoid These

```gdscript
# ❌ Untyped variables
var x = 10

# ❌ $ in _process
func _process(_delta):
    $Node.position.x += 1

# ❌ Deep inheritance
class A extends Node
class B extends A
class C extends B
class D extends C  # Too deep!

# ❌ Signals for synchronous requests
signal get_data
# Use a function instead

# ❌ God classes
class GameManager extends Node
# 500 lines of unrelated functionality
```

## Rationale

Static typing provides:
- **Compile-time error detection**
- **Better autocomplete and IDE support**
- **Self-documenting code**
- **Performance optimizations**