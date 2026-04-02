# Coding Standards

This document defines the coding standards for the project.

> **See also**: [coordination-rules.md](coordination-rules.md) — Skill collaboration and language selection decisions

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

---

## C# Standards (Godot 4.6.1)

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

## Performance Thresholds

### When to Use GDExtension

**阈值**: 如果一个函数每帧运行 **>1000 次**，考虑 GDExtension

| 场景 | GDScript | C# | GDExtension |
|------|----------|-----|-------------|
| 游戏逻辑 | ✅ Best | ✅ Good | ⚠️ Overkill |
| UI | ✅ Best | ✅ Good | ❌ |
| 快速原型 | ✅ Best | ✅ Good | ❌ |
| .NET 库集成 | ❌ | ✅ Best | ⚠️ |
| 重数学运算 (寻路) | ⚠️ Slow | ✅ Good | ✅ Best |
| 性能关键 (>1000次/帧) | ⚠️ Slow | ✅ Good | ✅ Best |
| 多线程 | ⚠️ Limited | ✅ Best | ✅ Best |

### Performance Comparison

| Metric | GDScript | C# | GDExtension |
|--------|----------|-----|-------------|
| 执行速度 | 1x (基准) | 2-5x | 10-50x |
| 启动时间 | 快 | 中 | 慢 (编译) |
| 内存占用 | 低 | 中 | 低 |
| 开发迭代 | 最快 | 快 | 慢 |

---

## Language Selection Guide

**参考**: `coordination-rules.md` → 语言选择决策

| 需求 | 推荐语言 |
|------|---------|
| 游戏逻辑 | GDScript |
| UI组件 | GDScript 或 C# |
| 数据处理 | C# |
| .NET库集成 | C# |
| 快速原型 | GDScript |
| 性能关键 (>1000次/帧) | GDExtension (C++/Rust) |

---

## Zero Tolerance Policy

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

所有 GDScript 代码必须通过静态类型检查。