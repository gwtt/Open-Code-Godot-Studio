# Coding Standards

This document defines the coding standards for the project.

## GDScript Standards

### Static Typing (MANDATORY)

```gdscript
# ✅ Correct
var health: int = 100
var items: Array[Item] = []
func take_damage(amount: int) -> void:
    pass

# ❌ Wrong
var health = 100
var items = []
func take_damage(amount):
    pass
```

### Naming

```gdscript
# Classes
class_name PlayerController

# Constants
const MAX_HEALTH: int = 100
const MOVE_SPEED: float = 300.0

# Variables
var current_health: int = 100
var _internal_state: int = 0  # Private

# Functions
func calculate_damage(base: int, multiplier: float) -> int:
    return int(base * multiplier)

# Signals
signal health_changed(new_health: int, max_health: int)
signal died()
```

### File Structure

```gdscript
class_name PlayerController
extends CharacterBody2D

# Constants
const MAX_HEALTH: int = 100

# Signals
signal health_changed(new_health: int)

# Exports
@export var move_speed: float = 300.0
@export_group("Combat")
@export var damage: int = 10

# Public Variables
var current_health: int = MAX_HEALTH

# Private Variables
var _is_invulnerable: bool = false

# Onready References
@onready var sprite: Sprite2D = $Sprite
@onready var collision: CollisionShape2D = $CollisionShape2D

# Built-in Methods
func _ready() -> void:
    pass

func _physics_process(delta: float) -> void:
    pass

# Public Methods
func take_damage(amount: int) -> void:
    pass

# Private Methods
func _apply_knockback(direction: Vector2) -> void:
    pass

# Signal Handlers
func _on_hitbox_area_entered(area: Area2D) -> void:
    pass
```

### Node References

```gdscript
# ✅ Correct - Cached with type
@onready var health_bar: ProgressBar = %HealthBar

# ❌ Wrong - Not cached
func _process(_delta):
    $HealthBar.value = health
```

### Signals

```gdscript
# ✅ Correct - Typed parameters
signal health_changed(new_health: int, max_health: int)

func take_damage(amount: int) -> void:
    health -= amount
    health_changed.emit(health, max_health)

# ❌ Wrong - No types
signal health_changed

func take_damage(amount):
    health -= amount
    health_changed.emit(health)
```

### Performance

```gdscript
# ✅ Correct - Disabled when not needed
func _ready() -> void:
    set_process(false)

func activate() -> void:
    set_process(true)

# ❌ Wrong - Always running
func _process(_delta):
    if false:
        do_something()
```

## Architecture Standards

### Composition Over Inheritance

```gdscript
# ✅ Correct - Components
@onready var health: HealthComponent = %HealthComponent
@onready var movement: MovementComponent = %MovementComponent

# ❌ Wrong - Deep inheritance
class A extends Node
class B extends A
class C extends B  # Stop at 2-3 levels max
```

### Dependency Injection

```gdscript
# ✅ Correct - Passed in
class_name Weapon
var owner: Character

func initialize(owner: Character) -> void:
    self.owner = owner

# ❌ Wrong - Reaching out
func _ready():
    owner = get_parent().get_parent()  # Fragile!
```

## Comment Standards

```gdscript
# ✅ Good - Explains why
# Use squared distance to avoid expensive sqrt
if position.distance_squared_to(target) < RANGE_SQUARED:
    attack()

# ❌ Bad - Explains what (obvious)
# Set health to 100
health = 100
```

## Error Handling

```gdscript
# ✅ Good - Guard clauses
func get_item(index: int) -> Item:
    if index < 0 or index >= items.size():
        push_error("Invalid item index: %d" % index)
        return null
    return items[index]

# ❌ Bad - Silent failure
func get_item(index: int) -> Item:
    return items[index]  # Can crash!
```