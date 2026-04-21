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

## Scene-Defined Structural Nodes (场景定义结构性节点)

### Rule

结构性子节点必须通过 `.tscn` 场景文件定义，禁止在 `_ready()` 中使用 `add_child()` 动态创建。

### 什么是"结构性"节点

以下节点类型属于场景的永久性架构，**必须**在 `.tscn` 中定义：

- `CollisionShape2D` / `CollisionShape3D` — 碰撞体
- `Sprite2D` / `Sprite3D` — 精灵/模型显示
- `Camera2D` / `Camera3D` — 摄像机
- `AnimationPlayer` — 动画控制器
- `AudioStreamPlayer` — 音频播放器
- `Timer` — 定时器
- `MeshInstance3D` — 3D网格
- `Light2D` / `Light3D` — 光源
- `Area2D` / `Area3D` — 区域检测

### ✅ Good

```gdscript
# 节点已在 .tscn 场景文件中定义，通过 @onready 缓存引用
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
    collision.shape = RectangleShape2D.new()  # OK: 组件配置
```

### ❌ Bad

```gdscript
# 在代码中动态创建结构性节点 — 禁止
func _ready() -> void:
    var col := CollisionShape2D.new()
    col.shape = RectangleShape2D.new()
    add_child(col)  # 场景面板不可见，无法调试
```

```gdscript
# 在代码中动态创建精灵 — 禁止
func _ready() -> void:
    var sprite := Sprite2D.new()
    sprite.texture = preload("res://icon.svg")
    add_child(sprite)
```

### 例外：动态实体

`PackedScene.instantiate()` 用于动态生成实体是**允许的**：

```gdscript
# ✅ 允许：动态实例化预制体（敌人、子弹、道具）
var enemy_scene := preload("res://entities/enemy.tscn")
func spawn_enemy(pos: Vector2) -> void:
    var enemy := enemy_scene.instantiate()
    enemy.position = pos
    add_child(enemy)
```

### 原理 (Rationale)

代码创建的节点在 Godot Editor 的场景面板中**不可见**，用户无法：
- 在编辑器中调整属性
- 查看/修改节点位置
- 调试场景结构

正确做法是使用 MCP 工具 `godot_add_node` 创建场景节点，或手动编辑 `.tscn` 文件。

### MCP 集成

- 当 Godot MCP 可用时，使用 `godot_add_node` 创建场景节点
- 当 MCP 不可用时，在 `.tscn` 中手动定义节点，或提供 tscn 内容

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

## Thread Safety & call_deferred

### When to Use call_deferred

| Scenario | Use call_deferred? | Reason |
|----------|-------------------|--------|
| Modifying scene tree from signal | ✅ YES | Signals may fire during physics |
| Removing nodes in collision callback | ✅ YES | Physics thread active |
| Adding children from Thread | ✅ YES | Main thread owns scene tree |
| Normal gameplay logic | ❌ NO | Overhead, not needed |
| _ready() modifications | ❌ NO | Already in main thread |

### Pattern

```gdscript
# ✅ Correct - defer scene tree modifications from physics
func _on_body_entered(body: Node2D) -> void:
    body.queue_free()  # Safe - deferred internally
    call_deferred("spawn_explosion", body.position)

func spawn_explosion(pos: Vector2) -> void:
    var explosion: Node2D = explosion_scene.instantiate()
    explosion.position = pos
    add_child(explosion)  # Now on main thread

# ❌ Wrong - direct scene tree modification from physics callback
func _on_body_entered(body: Node2D) -> void:
    add_child(explosion_scene.instantiate())  # May crash!
```

### Signal Emission from Threads

```gdscript
# ✅ Correct - deferred signal emission
Thread.new().start(func():
    call_deferred("emit_signal", "data_loaded", result)
)

# ❌ Wrong - direct emission from thread
Thread.new().start(func():
    emit_signal("data_loaded", result)  # Unsafe!
```

## Rationale

Static typing provides:
- **Compile-time error detection**
- **Better autocomplete and IDE support**
- **Self-documenting code**
- **Performance optimizations**