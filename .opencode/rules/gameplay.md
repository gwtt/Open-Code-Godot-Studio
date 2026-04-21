# Gameplay Code Rules

Applies to: `src/gameplay/**`

## Enforced Standards

### Data-Driven Design

- All tunable values MUST be `@export` variables or Resources
- NO hardcoded magic numbers in gameplay logic
- Values should be adjustable without code changes

```gdscript
# ✅ Good
@export var move_speed: float = 300.0
@export var jump_height: float = 64.0

# ❌ Bad
velocity.x = 300.0  # Magic number!
```

### Delta Time Usage

- All time-dependent logic MUST use `delta`
- NO assumptions about frame rate
- Physics in `_physics_process(delta)`, visuals in `_process(delta)`

```gdscript
# ✅ Good
func _physics_process(delta: float) -> void:
    velocity += gravity * delta
    position += velocity * delta

# ❌ Bad
func _physics_process(_delta: float) -> void:
    velocity += gravity  # Ignores frame timing!
```

### Component Separation

- Gameplay logic MUST NOT reference UI directly
- Use signals to communicate state changes
- UI observes gameplay, never the reverse

```gdscript
# ✅ Good
signal health_changed(new_health: int, max_health: int)

func take_damage(amount: int) -> void:
    health -= amount
    health_changed.emit(health, max_health)

# ❌ Bad
func take_damage(amount: int) -> void:
    health -= amount
    $UI/HealthBar.value = health  # Direct UI reference!
```

### State Machines

- Use state machines for stateful behavior
- States should be clearly defined
- Transitions should be explicit

```gdscript
# ✅ Good
enum State { IDLE, RUNNING, JUMPING }
var _state: State = State.IDLE

func _physics_process(delta: float) -> void:
    match _state:
        State.IDLE: _process_idle(delta)
        State.RUNNING: _process_running(delta)
        State.JUMPING: _process_jumping(delta)

# ❌ Bad
var is_idle: bool = true
var is_running: bool = false
var is_jumping: bool = false  # Multiple bools = state machine needed
```

### Signals for Communication

- Use signals for child → parent communication
- Use signals for cross-system communication
- Type all signal parameters

```gdscript
# ✅ Good
signal health_changed(new_health: int, max_health: int)
signal died(killer: Node)

# ❌ Bad
signal health_changed  # No types
signal update  # Vague name
```

### Scene-Defined Structural Nodes

- **规则声明**：所有结构性/永久性子节点必须定义在 `.tscn` 场景文件中，禁止在 `_ready()` 中通过 `add_child()` 或 `.new()` 创建
- **结构性节点定义**：CollisionShape2D/3D、Sprite2D/3D、Camera2D/3D、AnimationPlayer、AudioStreamPlayer、Timer、MeshInstance3D、Light2D/3D、Area2D/3D 及其碰撞形状 — 任何构成永久场景架构的节点

```gdscript
# ✅ Good
@onready var collision: CollisionShape2D = $CollisionShape2D

# ❌ Bad
func _ready() -> void:
    var col = CollisionShape2D.new()
    col.shape = CapsuleShape2D.new()
    add_child(col)  # 节点在代码中创建，编辑器 Scene 面板中不可见！
```

```csharp
// ✅ Good
private CollisionShape2D _collision;

// public override void _Ready()
// {
//     _collision = GetNode<CollisionShape2D>("CollisionShape2D");
// }

// ❌ Bad
// public override void _Ready()
// {
//     var col = new CollisionShape2D();
//     col.Shape = new CapsuleShape2D();
//     AddChild(col);  // 节点在代码中创建，编辑器 Scene 面板中不可见！
// }
```

- **明确例外**：通过 `PackedScene.instantiate()` 动态生成的节点（敌人、子弹、粒子等）是允许的 — 仅限于结构性/永久性节点禁止代码创建
- **原因**：在代码中创建的节点在 Godot 编辑器的 Scene 面板中不可见，用户无法编辑属性、调整位置或可视化调试场景结构
- **参考**：当 Godot MCP 可用时，使用 `godot_create_scene` + `godot_add_node` + `godot_save_scene` 构建场景；当 MCP 不可用时，提供 tscn 内容供用户手动创建

## Rationale

These rules ensure:
1. **Tunability** — Designers can adjust without code changes
2. **Consistency** — Frame-rate independent gameplay
3. **Testability** — UI can be mocked or replaced
4. **Maintainability** — Clear patterns reduce cognitive load