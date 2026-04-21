# Scene Assembly Guide Template

Use this template when providing scene assembly instructions instead of generating .tscn files.

---

## MCP 场景构建（首选方案）

> **⚠️ 重要声明**：当 Godot MCP 可用时，场景构建**必须**使用 MCP 工具。手动组装**仅在 MCP 不可用时**作为备选方案。

### MCP 工具流程

当 MCP 可用时，**必须**按以下顺序使用工具构建场景：

1. `godot_create_scene` — 创建场景文件
2. `godot_add_node` — 为每个结构节点添加节点（重复调用）
3. `godot_save_scene` — 保存场景

### 核心规则

- **结构节点**（CollisionShape、Sprite、Camera、AnimationPlayer、Timer 等）**必须**通过 MCP 在 .tscn 中创建，**禁止**通过 `add_child()` 在代码中动态添加
- MCP 场景创建完成后，只需编写脚本，使用 `@onready` 引用节点（**禁止**在代码中 `add_child` 结构节点）
- **动态实体**（敌人、子弹等）通过 `PackedScene.instantiate()` 实例化是**允许的**

### 示例：Player 场景的 MCP 构建流程

```bash
# 1. 创建 Player 场景
godot_create_scene("res://scenes/player.tscn", "CharacterBody2D")

# 2. 添加结构节点（按从父到子的顺序）
godot_add_node("res://scenes/player.tscn", "Player", "Sprite", "Sprite2D")
godot_add_node("res://scenes/player.tscn", "Player", "CollisionShape", "CollisionShape2D")
godot_add_node("res://scenes/player.tscn", "Player", "Camera", "Camera2D")
godot_add_node("res://scenes/player.tscn", "Player", "Hitbox", "Area2D")
godot_add_node("res://scenes/player.tscn", "Hitbox", "HitboxCollision", "CollisionShape2D")

# 3. 保存场景
godot_save_scene("res://scenes/player.tscn")
```

### MCP 场景创建后的脚本编写

```csharp
// player_controller.cs — 只需 @onready 引用，MCP 创建的节点无需 add_child
public partial class PlayerController : CharacterBody2D
{
    [Export] private float _speed = 300f;

    // @onready 等效 - 节点已由 MCP 在 .tscn 中创建
    private Sprite2D _sprite;
    private CollisionShape2D _collisionShape;
    private Camera2D _camera;

    public override void _Ready()
    {
        // 获取 MCP 创建的节点（无需实例化）
        _sprite = GetNode<Sprite2D>("Sprite");
        _collisionShape = GetNode<CollisionShape2D>("CollisionShape");
        _camera = GetNode<Camera2D>("Camera");
    }

    public override void _PhysicsProcess(double delta)
    {
        // 移动逻辑...
    }
}
```

---

## Template Structure

### Node Tree Diagram
```
[RootNodeName] (NodeType)
├── [ChildNode1] (NodeType) — Brief purpose
├── [ChildNode2] (NodeType) — Brief purpose
│   └── [SubChild] (NodeType) — Brief purpose
└── [ChildNode3] (NodeType) — Brief purpose
```

### Required Components Table
| Node Name | Type | Required Properties | Attached Script |
|-----------|------|---------------------|-----------------|
| Player | CharacterBody2D | position: (100, 200), speed: 300 | player_controller.gd |
| HealthBar | ProgressBar | value: 100, min: 0, max: 100 | health_bar.gd |
| Sprite | Sprite2D | texture: placeholder.png | — |

### Assembly Steps (Numbered)

> ⚠️ **注意**：此手动指南**仅在 Godot MCP 不可用时**使用。MCP 可用时，请使用上方 **MCP 场景构建方案**。

1. **Create root node**: In Scene dock → Add Node → Select [NodeType]
2. **Attach script**: Drag script file from FileSystem to node, or right-click → Attach Script
3. **Add child nodes**: Right-click root → Add Child Node → Select type
4. **Configure properties**: In Inspector dock, set properties per table above
5. **Enable Unique Names**: Right-click frequently accessed nodes → Access as Unique Name (%Name)
6. **Save scene**: Scene → Save As → `res://scenes/[scene_name].tscn`

### MCP Testing (Optional)
After assembly, test with Godot MCP:
```bash
godot_run_scene("res://scenes/[scene_name].tscn")
```

---

## Example: Tower Defense Tower

### Node Tree
```
Tower (Node2D)
├── Sprite (Sprite2D) — Tower visual
├── RangeIndicator (CircleShape2D) — Attack range visual
├── AttackTimer (Timer) — Cooldown management
└── Hitbox (Area2D) — Detect enemies
    └── CollisionShape (CollisionShape2D) — Hitbox shape
```

### Required Components
| Node | Type | Properties | Script |
|------|------|------------|--------|
| Tower | Node2D | position: (0, 0) | tower.gd |
| Sprite | Sprite2D | texture: tower.png | — |
| RangeIndicator | Node2D | modulate: Color(1, 1, 1, 0.3) | — |
| AttackTimer | Timer | wait_time: 1.0, autostart: true | — |
| Hitbox | Area2D | — | — |

### Assembly Steps
1. Create Tower: Add Node → Node2D → rename to "Tower"
2. Attach `tower.gd`: Drag from FileSystem
3. Add Sprite: Add Child → Sprite2D → set texture
4. Add RangeIndicator: Add Child → Node2D → add CircleShape2D child
5. Add AttackTimer: Add Child → Timer → configure wait_time
6. Add Hitbox: Add Child → Area2D → add CollisionShape2D child
7. Save: `res://scenes/tower.tscn`

---

## Example: Player Character

### Node Tree
```
Player (CharacterBody2D)
├── Sprite (Sprite2D) — Player visual
├── CollisionShape (CollisionShape2D) — Physics collision
├── Camera (Camera2D) — Follow camera
└── Hitbox (Area2D) — Take damage
    └── CollisionShape (CollisionShape2D) — Hitbox shape
```

### Required Components
| Node | Type | Properties | Script |
|------|------|------------|--------|
| Player | CharacterBody2D | position: (100, 100) | player_controller.gd |
| Sprite | Sprite2D | texture: player.png | — |
| CollisionShape | CollisionShape2D | shape: CapsuleShape2D | — |
| Camera | Camera2D | enabled: true | — |
| Hitbox | Area2D | — | — |

### Assembly Steps
1. Create Player: Add Node → CharacterBody2D → rename to "Player"
2. Attach `player_controller.gd`: Drag from FileSystem
3. Add Sprite: Add Child → Sprite2D → set texture
4. Add CollisionShape: Add Child → CollisionShape2D → create CapsuleShape2D
5. Add Camera: Add Child → Camera2D
6. Add Hitbox: Add Child → Area2D → add CollisionShape2D child
7. Save: `res://scenes/player.tscn`

---

## Best Practices

1. **Use Unique Names** for frequently accessed nodes (e.g., `%HealthBar`)
2. **Group related properties** using `@export_group()` in scripts
3. **Test scenes** after assembly using Godot MCP or manual run
4. **Document dependencies** (e.g., required textures, other scenes)
5. **Provide clear naming** for nodes (avoid generic names like "Node", "Node2D")