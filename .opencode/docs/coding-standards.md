# Coding Standards

This document defines the coding standards for the project.

> **See also**: [coordination-rules.md](coordination-rules.md) — Skill collaboration and language selection decisions

> **Note**: C# is the primary language for this project. GDScript is optional for rapid prototyping.

---

## C# Standards (Primary Language)

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Classes | PascalCase | `public partial class PlayerController` |
| Properties | PascalCase | `public float Speed { get; set; }` |
| Private fields | camelCase + underscore | `private float _currentHealth;` |
| Constants | PascalCase | `public const float MaxSpeed = 500f;` |
| Methods | PascalCase | `public void TakeDamage(float amount)` |
| Events | PascalCase + EventHandler | `HealthChangedEventHandler` |

### GlobalClass Attribute

```csharp
// ✅ Register as node type in editor
[GlobalClass]
public partial class PlayerController : CharacterBody2D
{
    // Appears in "Add Node" list
}

// ❌ Without GlobalClass - must create Node first
public partial class PlayerController : CharacterBody2D { }
```

### Export Properties

```csharp
// Basic export
[Export]
public float Speed { get; set; } = 200.0f;

// Range export
[Export(PropertyHint.Range, "0,100,0.1")]
public float Health { get; set; } = 100.0f;

// Node export (Modern - Godot 4.6.1)
[Export]
public ProgressBar HealthBar { get; set; }

// Resource export
[Export]
public Texture2D Icon { get; set; }
```

### Signals

```csharp
// Define signal
[Signal]
public delegate void HealthChangedEventHandler(float newHealth, float maxHealth);

// Emit signal
EmitSignal(SignalName.HealthChanged, Health, MaxHealth);

// Connect (C# event pattern)
public override void _Ready()
{
    Button.Pressed += OnButtonPressed;
    HealthChanged += OnHealthChanged;
}

// Disconnect (prevent memory leak)
public override void _ExitTree()
{
    Button.Pressed -= OnButtonPressed;
    HealthChanged -= OnHealthChanged;
}
```

### Node References

```csharp
// ✅ Modern - Strongly typed export
[Export]
public Sprite2D Sprite { get; set; }

// ✅ Scene Unique Node
private Sprite2D _sprite;
public override void _Ready()
{
    _sprite = GetNode<Sprite2D>("%Sprite");
}

// ❌ Legacy - NodePath pattern
[Export] public NodePath SpritePath { get; set; }
private Sprite2D _sprite;
public override void _Ready()
{
    _sprite = GetNode<Sprite2D>(SpritePath);  // Avoid this
}
```

### Async/Await

```csharp
// Wait for timer
await ToSignal(GetTree().CreateTimer(1.0), SceneTreeTimer.SignalName.Timeout);

// Wait for animation
await ToSignal(AnimationPlayer, AnimationPlayer.SignalName.AnimationFinished);

// Wait for custom signal
await ToSignal(this, SignalName.HealthChanged);
```

### GD.Print vs Console

```csharp
// ✅ Use Godot logging
GD.Print("Normal log");
GD.PushWarning("Warning");
GD.PushError("Error");

// ❌ Don't use Console (won't show in Godot output)
Console.WriteLine("...");  // Invisible
```

### Asset Loading Patterns

```csharp
// ✅ Modern - GD.Load<T> (Godot 4.6.1)
var scene = GD.Load<PackedScene>("res://scenes/player.tscn");
var texture = GD.Load<Texture2D>("res://assets/icon.png");
var audio = GD.Load<AudioStream>("res://audio/jump.wav");

// ✅ Async loading for large assets
var resource = ResourceLoader.LoadThreadedRequest("res://large_asset.tscn");
// Check progress: ResourceLoader.LoadThreadedGetStatus(path)

// ❌ Legacy - ResourceLoader.Load (less idiomatic in Godot 4)
var scene = ResourceLoader.Load<PackedScene>("res://scenes/player.tscn");
```

### Common Patterns

```csharp
// Singleton/Autoload
public partial class GameManager : Node
{
    public static GameManager Instance { get; private set; }
    
    public override void _Ready()
    {
        Instance = this;
    }
}

// State Machine Interface
public interface IState
{
    void Enter();
    void Exit();
    void Update(double delta);
}

// Object Pooling
public partial class BulletPool : Node
{
    private readonly Queue<Bullet> _pool = new();
    
    public Bullet? Get()
    {
        if (_pool.Count == 0) return null;
        var bullet = _pool.Dequeue();
        bullet.SetProcess(true);
        return bullet;
    }
    
    public void Return(Bullet bullet)
    {
        bullet.SetProcess(false);
        bullet.Hide();
        _pool.Enqueue(bullet);
    }
}
```

---

## GDScript Standards (Optional)

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

## Scene-Defined Structural Nodes (场景定义结构性节点)

### Rule

所有结构性子节点必须定义在 `.tscn` 场景文件中，**禁止**在 `_ready()` 或 `_init()` 中通过代码动态创建。

### What are Structural Nodes?

Structural nodes are permanent scene architecture elements that define the shape and behavior of a scene:

| Node Type | Purpose |
|-----------|---------|
| `CollisionShape2D/3D` | Physics collision geometry |
| `Sprite2D/3D` | Visual representation |
| `Camera2D/3D` | Viewport control |
| `AnimationPlayer` | Animation playback |
| `AudioStreamPlayer` | Sound playback |
| `Timer` | Delayed/countdown events |
| `MeshInstance3D` | 3D visual geometry |
| `Light2D/3D` | Lighting effects |
| `Area2D/3D` | Detection zones |

### GDScript Examples

```gdscript
# ✅ Good - Node defined in .tscn, referenced via @onready
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $DamageCooldown

# ❌ Bad - Node created in code
func _ready() -> void:
    var col := CollisionShape2D.new()
    add_child(col)  # Forbidden for structural nodes!

# ❌ Bad - Node created in _init
func _init() -> void:
    var col := CollisionShape2D.new()
    add_child(col)  # Forbidden!
```

### C# Examples

```csharp
// ✅ Good - Node defined in .tscn, referenced via GetNode
private CollisionShape2D _collision;
private Sprite2D _sprite;
private Timer _damageCooldown;

public override void _Ready()
{
    _collision = GetNode<CollisionShape2D>("CollisionShape2D");
    _sprite = GetNode<Sprite2D>("Sprite");
    _damageCooldown = GetNode<Timer>("DamageCooldown");
}

// ❌ Bad - Node created in code
public override void _Ready()
{
    var col = new CollisionShape2D();
    AddChild(col);  // Forbidden for structural nodes!
}

// ❌ Bad - Node created in constructor
public MyClass()
{
    var col = new CollisionShape2D();
    AddChild(col);  // Forbidden!
}
```

### Exception: Dynamic Runtime Entities

`PackedScene.Instantiate()` for dynamic runtime entities **IS allowed**:

```gdscript
# ✅ Allowed - Dynamic instantiation for runtime entities
func spawn_enemy(position: Vector2) -> void:
    var enemyScene := preload("res://scenes/enemy.tscn") as PackedScene
    var enemy := enemyScene.instantiate()
    enemy.position = position
    add_child(enemy)

func shoot_bullet() -> void:
    var bullet := _bulletScene.instantiate()
    bullet.global_position = gun_point.global_position
    get_parent().add_child(bullet)
```

```csharp
// ✅ Allowed - Dynamic instantiation for runtime entities
private PackedScene _enemyScene;

public override void _Ready()
{
    _enemyScene = GD.Load<PackedScene>("res://scenes/enemy.tscn");
}

public void SpawnEnemy(Vector2 position)
{
    var enemy = _enemyScene.Instantiate();
    enemy.Position = position;
    AddChild(enemy);
}
```

**Allowed dynamic entities:**
- Enemies, NPCs, projectiles, pickups
- Particle effects, visual FX
- UI elements spawned at runtime
- Any entity that is created/destroyed during gameplay

### MCP Integration

When MCP is available, use these tools to create scene-defined nodes:

**MCP Available:**
```
godot_create_scene       → Create new .tscn file
godot_add_node          → Add child nodes to scene
godot_save_scene        → Save scene changes
```

**MCP Unavailable:**
When MCP tools are not available, write `.tscn` content directly:

```txt
[gd_scene load_steps=2 format=3 uid="uid://example"]

[ext_resource type="Script" path="res://scripts/player.cs" id="1"]

[node name="Player" type="CharacterBody2D"]
script = ExtResource("1")

[node name="Sprite" type="Sprite2D" parent="."]
position = Vector2(0, -16)

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
```

Then provide manual instructions for adding nodes via Godot Editor.

### Rationale

**代码创建的节点在 Godot Editor 中不可见**，无法在 Inspector 中调整属性，无法可视化调试。`.tscn` 中定义的节点完全可编辑、可调试、符合 Godot 设计哲学。

| Aspect | Code-Created | Scene-Defined |
|--------|-------------|---------------|
| Inspector编辑 | ❌ 不可见 | ✅ 完全可编辑 |
| 可视化调试 | ❌ 不可见 | ✅ Scene面板可见 |
| 属性引用 | ❌ 需要额外代码 | ✅ 直接引用 |
| Godot哲学 | ❌ 违反直觉 | ✅ 符合设计 |
| 团队协作 | ❌ 路径不明确 | ✅ 明确可见 |

---

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

---

## Performance Thresholds

### When to Use GDExtension

**阈值**: 如果一个函数每帧运行 **>1000 次**，考虑 GDExtension

| 场景 | C# (Primary) | GDScript (Optional) | GDExtension |
|------|--------------|---------------------|-------------|
| 游戏逻辑 | ✅ Best | ✅ Good | ⚠️ Overkill |
| UI | ✅ Best | ✅ Good | ❌ |
| 快速原型 | ✅ Good | ✅ Best | ❌ |
| .NET 库集成 | ✅ Best | ❌ | ⚠️ |
| 重数学运算 (寻路) | ✅ Good | ⚠️ Slow | ✅ Best |
| 性能关键 (>1000次/帧) | ✅ Good | ⚠️ Slow | ✅ Best |
| 多线程 | ✅ Best | ⚠️ Limited | ✅ Best |

### Performance Comparison

| Metric | C# | GDScript | GDExtension |
|--------|-----|----------|-------------|
| 执行速度 | 2-5x | 1x (基准) | 10-50x |
| 启动时间 | 中 | 快 | 慢 (编译) |
| 内存占用 | 中 | 低 | 低 |
| 开发迭代 | 快 | 最快 | 慢 |
| AI 代码生成质量 | ✅ Best | Good | Good |

---

## Language Selection Guide

**参考**: `coordination-rules.md` → 语言选择决策

| 需求 | 推荐语言 |
|------|---------|
| 游戏逻辑 | C# (Primary) |
| UI组件 | C# (Primary) |
| 数据处理 | C# |
| .NET库集成 | C# |
| 快速原型 | GDScript (Optional) |
| 性能关键 (>1000次/帧) | GDExtension (C++/Rust) |

---

## Zero Tolerance Policy

### C# 零容忍规则

以下代码模式 **禁止** 使用:

```csharp
// ❌ 禁止 - 使用 Console.WriteLine
Console.WriteLine("...");

// ❌ 禁止 - 缺少 partial 修饰符
public class PlayerController : CharacterBody2D { }

// ❌ 禁止 - 使用 yield
yield return null;

// ❌ 禁止 - NodePath + GetNode 模式
[Export] public NodePath SpritePath { get; set; }
```

### GDScript 零容忍规则

以下代码模式 **禁止** 使用:

```gdscript
# ❌ 禁止 - 无类型声明
var health = 100

# ❌ 禁止 - 无类型参数
func take_damage(amount):

# ❌ 禁止 - 无类型数组
var items = []

# ❌ 禁止 - 硬编码路径在函数内
func _process(_delta):
    $HealthBar.value = health
```

所有代码必须通过静态类型检查。