# 新手实战教程：使用 Skills 开发贪吃蛇游戏

> 本教程面向：Godot新手程序员
> 目标：完整使用 OpenCode Skills 开发一个可运行的贪吃蛇游戏
> 预计时间：2-3小时

---

## 目录

1. [准备阶段：项目初始化](#1-准备阶段项目初始化)
2. [概念阶段：定义游戏](#2-概念阶段定义游戏)
3. [配置阶段：设置引擎](#3-配置阶段设置引擎)
4. [设计阶段：规划系统](#4-设计阶段规划系统)
5. [开发阶段：Sprint规划](#5-开发阶段sprint规划)
6. [原型阶段：快速验证](#6-原型阶段快速验证)
7. [实现阶段：编写代码](#7-实现阶段编写代码)
8. [审查阶段：代码质量](#8-审查阶段代码质量)
9. [完成阶段：测试发布](#9-完成阶段测试发布)

---

## 1. 准备阶段：项目初始化

### 你要做什么
第一次打开项目，让 OpenCode 了解你的状态。

### 与 OpenCode 对话

```
你: /start
```

### OpenCode 会问

```
OpenCode: 你的团队结构是什么？

A) 单人独立开发 — 只有我一个
B) 2人小队 — 我+队友
C) 3人小队 — 我作为队长
D) 更大团队
```

### 你的回答

```
你: A
```

### OpenCode 会继续问

```
OpenCode: 你目前处于哪个阶段？

A) 还没有想法
B) 有模糊想法
C) 概念已清晰
D) 已有工作成果
```

### 你的回答

```
你: B，我想做一个贪吃蛇游戏
```

### OpenCode 会推荐

```
OpenCode: 很好！我建议使用 /brainstorm "贪吃蛇游戏" 来发展你的想法。
```

---

## 2. 概念阶段：定义游戏

### 你要做什么
使用 brainstorm skill 将模糊想法变成具体的游戏概念文档。

### 与 OpenCode 对话

```
你: /brainstorm "贪吃蛇游戏"
```

### OpenCode 会问

```
OpenCode: '贪吃蛇游戏' 这个想法里，最让你兴奋的是什么？
```

### 你的回答示例

```
你: 经典的玩法，简单但有挑战性。我想加入一些现代元素，比如不同颜色的食物有不同效果。
```

### OpenCode 会继续探索

```
OpenCode: 你希望玩家感受到什么？
```

### 你的回答示例

```
你: 紧张感，随着蛇越来越长，操作难度增加。还有成就感，打破自己的最高分。
```

### OpenCode 会询问核心玩法

```
OpenCode: 玩家会重复做什么？核心循环是什么？
```

### 你的回答示例

```
你: 
1. 移动蛇吃食物
2. 蛇变长，得分增加
3. 难度增加（速度加快或障碍物）
4. 撞墙或撞自己，游戏结束
5. 重新开始，挑战更高分
```

### OpenCode 会询问规模

```
OpenCode: 你的项目规模目标是什么？

Jam (48小时-1周) / Small (1-6月) / Medium (6-18月)
```

### 你的回答

```
你: Jam规模，我想快速完成一个可玩的版本
```

### OpenCode 生成概念文档

```
OpenCode: 我为你生成了游戏概念文档，预览如下：

# 贪吃蛇游戏

## Elevator Pitch
经典贪吃蛇玩法，加入现代元素（不同效果的食物），简单但有挑战性。

## Design Pillars
1. 简单易懂 — 方向键控制，一秒上手
2. 渐进难度 — 蛇越长，越紧张
3. 高分挑战 — 打破记录的成就感

## Core Loop
1. 移动蛇 → 吃食物
2. 蛇变长 → 得分增加
3. 速度加快 → 紧张感增加
4. 碰撞 → 游戏结束
5. 重新开始 → 挑战更高分

## Target Player
休闲玩家，喜欢经典小游戏，追求高分挑战

## Key Features
- 经典蛇移动控制
- 普通食物（+1长度，+10分）
- 特殊食物（随机出现，不同效果）
- 分数和最高分记录
- 游戏结束和重新开始

## Scope
Jam规模，1-2天完成

## Recommended Engine
Godot 4 — 2D游戏，GDScript开发快速

---

我可以把这个保存到 design/gdd/game-concept.md 吗？
```

### 你的回答

```
你: 可以
```

---

## 3. 配置阶段：设置引擎

### 你要做什么
配置 Godot 引擎和项目结构。

### 与 OpenCode 对话

```
你: /setup-engine godot 4.6.1
```

### OpenCode 会检测

```
OpenCode: 
Sprint 状态检查
━━━━━━━━━━━━━━━━━━━━━━
游戏概念: ✅ 已定义
当前Sprint: 无
━━━━━━━━━━━━━━━━━━━━━━

正在配置 Godot 4.6.1...
```

### OpenCode 会展示变更预览

```
OpenCode: 
将要创建/修改的文件：
━━━━━━━━━━━━━━━━━━━━━━
1. OPENCODE.md — 更新技术栈
2. .opencode/docs/technical-preferences.md — 编码规范
3. .opencode/docs/engine-reference/godot/VERSION.md — 版本信息
4. 项目目录结构：src/ assets/ design/ tests/ prototypes/ production/
━━━━━━━━━━━━━━━━━━━━━━

确认创建这些文件？(Y/n)
```

### 你的回答

```
你: Y
```

### OpenCode 完成配置

```
OpenCode: 
✅ 引擎配置完成
━━━━━━━━━━━━━━━━━━━━━━
Engine:          Godot 4.6.1
OPENCODE.md:     ✅ 已更新
Tech Prefs:      ✅ 已创建
Project Structure: ✅ 已创建

下一步建议：
1. 在 Godot 中创建新项目
2. 运行 /sprint-plan 来组织工作
━━━━━━━━━━━━━━━━━━━━━━
```

### 💡 实际操作（OpenCode 外）

在 Godot 编辑器中：
1. 新建项目 → 选择项目目录
2. 渲染器选择 → Forward+ (桌面) 或 Compatibility (Web/移动)
3. 创建基本的目录结构（如果 OpenCode 没创建）

---

## 4. 设计阶段：规划系统

### 你要做什么
设计贪吃蛇的具体系统和技术实现。

### 与 OpenCode 对话

```
你: /game-designer 设计贪吃蛇的核心系统
```

### OpenCode 会询问细节

```
OpenCode: 
你想设计哪些方面？

A) 蛇的移动系统
B) 食物生成系统
C) 碰撞检测系统
D) 分数系统
E) 全部
```

### 你的回答

```
你: E，完整的设计
```

### OpenCode 生成设计文档

```
OpenCode: 我为贪吃蛇设计了以下系统：

# 贪吃蛇系统设计

## 1. 蛇移动系统

### 数据结构
- 位置数组: Array[Vector2] — 存储每节身体的位置
- 方向: Vector2 — 当前移动方向
- 速度: float — 移动间隔时间（秒）

### 核心逻辑
```gdscript
# 伪代码
func move_snake():
    # 头部新位置 = 当前位置 + 方向
    var new_head = segments[0] + direction
    
    # 添加新头部
    segments.insert(0, new_head)
    
    # 如果没吃到食物，移除尾部
    if not ate_food:
        segments.pop_back()
```

### 控制输入
- 方向键: 上下左右
- 限制: 不能180度转向（不能直接反向）

---

## 2. 食物系统

### 食物类型
| 类型 | 效果 | 出现概率 |
|------|------|----------|
| 普通 | +1长度, +10分 | 70% |
| 加速 | +1长度, +20分, 速度+10% | 15% |
| 减速 | +1长度, +5分, 速度-10% | 10% |
| 缩短 | -1长度, +15分 | 5% |

### 生成逻辑
```gdscript
func spawn_food():
    var valid_positions = []
    # 找所有不在蛇身上的位置
    for x in range(grid_width):
        for y in range(grid_height):
            if Vector2(x, y) not in snake.segments:
                valid_positions.append(Vector2(x, y))
    
    # 随机选择位置
    food_position = valid_positions[randi() % valid_positions.size()]
    
    # 随机选择食物类型
    food_type = get_random_food_type()
```

---

## 3. 碰撞系统

### 检测类型
1. 墙壁碰撞: 头部超出边界
2. 自身碰撞: 头部位置等于任意身体位置

### 代码逻辑
```gdscript
func check_collision():
    var head = segments[0]
    
    # 墙壁碰撞
    if head.x < 0 or head.x >= grid_width:
        return true
    if head.y < 0 or head.y >= grid_height:
        return true
    
    # 自身碰撞
    for i in range(1, segments.size()):
        if head == segments[i]:
            return true
    
    return false
```

---

## 4. 分数系统

### 数据
- 当前分数: int
- 最高分: int (保存到文件)

### 显示
- 屏幕左上角显示当前分数
- 游戏结束时显示最高分

### 保存
```gdscript
# 使用 Godot 的 ConfigFile
func save_high_score():
    var config = ConfigFile.new()
    config.set_value("game", "high_score", high_score)
    config.save("user://scores.cfg")

func load_high_score():
    var config = ConfigFile.new()
    if config.load("user://scores.cfg") == OK:
        high_score = config.get_value("game", "high_score", 0)
```

---

## 5. 游戏状态

### 状态机
```
Menu → Playing → GameOver → Menu
```

### 每个状态的逻辑
- Menu: 显示标题，等待开始
- Playing: 游戏进行中
- GameOver: 显示分数，等待重新开始

---

我可以把这个保存到 design/gdd/systems/snake-systems.md 吗？
```

### 你的回答

```
你: 可以
```

---

## 5. 开发阶段：Sprint规划

### 你要做什么
规划开发任务，估算时间。

### 与 OpenCode 对话

```
你: /sprint-plan
```

### OpenCode 检测状态

```
OpenCode: 
Sprint 状态检查
━━━━━━━━━━━━━━━━━━━━━━
游戏概念: ✅ 已定义
当前Sprint: 无
━━━━━━━━━━━━━━━━━━━━━━

创建新 Sprint？
```

### 你的回答

```
你: 是
```

### OpenCode 询问时间

```
OpenCode: 
Sprint 持续时间:
A) 1周 (推荐给单人)
B) 2周

开始日期: [默认今天]
```

### 你的回答

```
你: A，今天开始
```

### OpenCode 询问容量

```
OpenCode: 
团队结构: A) 单人
可用时间: [小时/天]

建议容量: 15 story points
```

### 你的回答

```
你: 每天3小时，一周约20小时
```

### OpenCode 生成任务

```
OpenCode: 
根据贪吃蛇设计，我建议以下任务：

## Must Have (必须完成)
| 任务 | 估计 | 状态 |
|------|------|------|
| 基础场景和项目设置 | 2h | [ ] |
| 蛇移动系统 | 3h | [ ] |
| 食物生成系统 | 2h | [ ] |
| 碰撞检测 | 2h | [ ] |
| 分数显示 | 1h | [ ] |
| 游戏状态管理 | 2h | [ ] |

## Should Have (最好有)
| 任务 | 估计 | 状态 |
|------|------|------|
| 特殊食物类型 | 2h | [ ] |
| 最高分保存 | 1h | [ ] |
| 游戏结束界面 | 1h | [ ] |

## Nice to Have (可选)
| 任务 | 估计 | 状态 |
|------|------|------|
| 音效 | 2h | [ ] |
| 粒子效果 | 2h | [ ] |

总计: Must Have 12h + Should Have 4h = 16h
在容量范围内 ✅

保存到 production/sprints/sprint-1-[date].md 吗？
```

### 你的回答

```
你: 可以
```

---

## 6. 原型阶段：快速验证

### 你要做什么
先做一个最简单的原型验证核心玩法。

### 与 OpenCode 对话

```
你: /prototype-mode 我想验证蛇移动和吃食物的核心玩法
```

### OpenCode 会帮你聚焦

```
OpenCode: 
原型: 蛇移动验证

## 核心假设
蛇的移动和吃食物的循环是否有趣？

## 最小范围
包含:
- 蛇可以用方向键移动
- 食物随机出现
- 吃到食物蛇变长

不包含:
- 碰撞检测（暂时不会死）
- 分数系统
- 美术（用方块代替）
- UI

## 时间限制
建议: 1-2小时

## Godot 快速实现
我建议用最简单的方式：

1. 创建 Node2D 场景
2. 用 ColorRect 表示蛇和食物
3. 用 Timer 控制移动速度
4. 简单的网格系统

要查看示例代码吗？
```

### 你的回答

```
你: 是，给我原型代码
```

### OpenCode 提供原型代码

```
OpenCode: 
# 原型代码 - 最小可运行版本

## 场景结构
```
Main (Node2D)
├── SnakeHead (ColorRect) - 蛇头
├── Food (ColorRect) - 食物
└── MoveTimer (Timer) - 移动计时器
```

## 主脚本 main.gd
```gdscript
extends Node2D

# 网格设置
const CELL_SIZE = 20
const GRID_WIDTH = 20
const GRID_HEIGHT = 15

# 蛇数据
var snake_segments: Array[Vector2] = []
var direction = Vector2.RIGHT
var next_direction = Vector2.RIGHT

# 食物位置
var food_pos: Vector2

# 节点引用
@onready var snake_head = $SnakeHead
@onready var food = $Food
@onready var timer = $MoveTimer

func _ready():
    # 初始化蛇（3节）
    snake_segments = [Vector2(5, 7), Vector2(4, 7), Vector2(3, 7)]
    
    # 设置计时器
    timer.wait_time = 0.2  # 200ms移动一次
    timer.start()
    
    # 生成食物
    spawn_food()
    
    # 更新显示
    update_display()

func _process(delta):
    # 处理输入
    if Input.is_action_just_pressed("ui_up") and direction != Vector2.DOWN:
        next_direction = Vector2.UP
    elif Input.is_action_just_pressed("ui_down") and direction != Vector2.UP:
        next_direction = Vector2.DOWN
    elif Input.is_action_just_pressed("ui_left") and direction != Vector2.RIGHT:
        next_direction = Vector2.LEFT
    elif Input.is_action_just_pressed("ui_right") and direction != Vector2.LEFT:
        next_direction = Vector2.RIGHT

func _on_move_timer_timeout():
    # 更新方向
    direction = next_direction
    
    # 计算新头部位置
    var new_head = snake_segments[0] + direction
    
    # 添加新头部
    snake_segments.insert(0, new_head)
    
    # 检查是否吃到食物
    if new_head == food_pos:
        spawn_food()  # 不移除尾部，蛇变长
    else:
        snake_segments.pop_back()  # 移除尾部
    
    # 更新显示
    update_display()

func spawn_food():
    # 简化版：随机位置（忽略蛇身体）
    food_pos = Vector2(
        randi() % GRID_WIDTH,
        randi() % GRID_HEIGHT
    )

func update_display():
    # 更新蛇头位置（简化：只显示头）
    snake_head.position = snake_segments[0] * CELL_SIZE
    snake_head.size = Vector2(CELL_SIZE, CELL_SIZE)
    snake_head.color = Color.GREEN
    
    # 更新食物位置
    food.position = food_pos * CELL_SIZE
    food.size = Vector2(CELL_SIZE, CELL_SIZE)
    food.color = Color.RED
```

## 项目设置
1. 创建新场景 main.tscn
2. 添加节点结构如上
3. 将脚本附加到 Main
4. 运行测试！

这个原型可以在30分钟内完成。运行后：
- 用方向键控制蛇
- 吃红色方块（食物）蛇会变长
- 暂时不会死亡（可以穿墙）

要继续完善吗？
```

### 💡 实际操作

1. 在 Godot 中创建场景和节点
2. 复制脚本
3. 运行测试
4. 验证核心玩法是否有趣

---

## 7. 实现阶段：编写代码

### 你要做什么
基于原型，实现完整的功能代码。

### 与 OpenCode 对话

```
你: /godot-specialist 我想实现完整的贪吃蛇游戏，包含碰撞检测、分数和游戏状态
```

### OpenCode 提供实现指导

```
OpenCode: 
好的，我来帮你实现完整版本。基于原型，我们需要添加：

## 1. 完善场景结构

```
Game (Node2D) - 游戏主场景
├── Grid (Node2D) - 网格容器
│   ├── SnakeContainer (Node2D) - 蛇的所有部分
│   └── Food (Sprite2D/ColorRect) - 食物
├── UI (CanvasLayer)
│   ├── ScoreLabel (Label)
│   └── HighScoreLabel (Label)
├── GameOverUI (CanvasLayer) - 游戏结束界面
│   ├── Panel (ColorRect)
│   ├── FinalScoreLabel (Label)
│   └── RestartButton (Button)
└── GameTimer (Timer)
```

## 2. 完整的游戏脚本 game.gd

```gdscript
extends Node2D

# ==================== 配置 ====================
const CELL_SIZE: int = 20
const GRID_WIDTH: int = 20
const GRID_HEIGHT: int = 15
const INITIAL_SPEED: float = 0.15  # 移动间隔（秒）
const SPEED_INCREASE: float = 0.01  # 每吃一个食物加速

# ==================== 状态 ====================
enum GameState { MENU, PLAYING, GAME_OVER }
var current_state: GameState = GameState.MENU

# 蛇数据
var snake_segments: Array[Vector2] = []
var direction: Vector2 = Vector2.RIGHT
var next_direction: Vector2 = Vector2.RIGHT

# 游戏数据
var food_pos: Vector2
var score: int = 0
var high_score: int = 0
var current_speed: float = INITIAL_SPEED

# 节点引用
@onready var snake_container = $Grid/SnakeContainer
@onready var food_sprite = $Grid/Food
@onready var score_label = $UI/ScoreLabel
@onready var high_score_label = $UI/HighScoreLabel
@onready var game_over_ui = $GameOverUI
@onready var final_score_label = $GameOverUI/Panel/FinalScoreLabel
@onready var restart_button = $GameOverUI/Panel/RestartButton
@onready var timer = $GameTimer

# ==================== 生命周期 ====================
func _ready():
    load_high_score()
    high_score_label.text = "最高分: %d" % high_score
    game_over_ui.hide()
    start_game()

func _process(_delta):
    if current_state != GameState.PLAYING:
        return
    
    handle_input()

# ==================== 输入处理 ====================
func handle_input():
    if Input.is_action_just_pressed("ui_up") and direction != Vector2.DOWN:
        next_direction = Vector2.UP
    elif Input.is_action_just_pressed("ui_down") and direction != Vector2.UP:
        next_direction = Vector2.DOWN
    elif Input.is_action_just_pressed("ui_left") and direction != Vector2.RIGHT:
        next_direction = Vector2.LEFT
    elif Input.is_action_just_pressed("ui_right") and direction != Vector2.LEFT:
        next_direction = Vector2.RIGHT

# ==================== 游戏逻辑 ====================
func start_game():
    current_state = GameState.PLAYING
    score = 0
    current_speed = INITIAL_SPEED
    direction = Vector2.RIGHT
    next_direction = Vector2.RIGHT
    
    # 初始化蛇
    snake_segments = [
        Vector2(5, 7),
        Vector2(4, 7),
        Vector2(3, 7)
    ]
    
    # 清除旧的蛇身体显示
    for child in snake_container.get_children():
        child.queue_free()
    
    # 创建初始蛇身体
    for i in range(snake_segments.size()):
        create_snake_segment(snake_segments[i], i == 0)
    
    # 生成食物
    spawn_food()
    
    # 更新UI
    update_score_display()
    
    # 开始计时器
    timer.wait_time = current_speed
    timer.start()

func _on_game_timer_timeout():
    if current_state != GameState.PLAYING:
        return
    
    # 更新方向
    direction = next_direction
    
    # 计算新头部
    var new_head = snake_segments[0] + direction
    
    # 检查碰撞
    if check_collision(new_head):
        game_over()
        return
    
    # 添加新头部
    snake_segments.insert(0, new_head)
    create_snake_segment(new_head, true)
    
    # 更新旧头部颜色（不再是头）
    if snake_segments.size() > 1:
        var old_head = snake_container.get_child(0)
        old_head.color = Color.GREEN
    
    # 检查是否吃到食物
    if new_head == food_pos:
        eat_food()
    else:
        # 移除尾部
        snake_segments.pop_back()
        var tail = snake_container.get_child(snake_container.get_child_count() - 1)
        tail.queue_free()

func check_collision(head_pos: Vector2) -> bool:
    # 墙壁碰撞
    if head_pos.x < 0 or head_pos.x >= GRID_WIDTH:
        return true
    if head_pos.y < 0 or head_pos.y >= GRID_HEIGHT:
        return true
    
    # 自身碰撞（从第二节开始检查）
    for i in range(1, snake_segments.size()):
        if head_pos == snake_segments[i]:
            return true
    
    return false

func eat_food():
    score += 10
    update_score_display()
    
    # 加速
    current_speed = max(0.05, current_speed - SPEED_INCREASE)
    timer.wait_time = current_speed
    
    # 生成新食物
    spawn_food()

func spawn_food():
    # 找所有有效位置
    var valid_positions: Array[Vector2] = []
    for x in range(GRID_WIDTH):
        for y in range(GRID_HEIGHT):
            var pos = Vector2(x, y)
            if pos not in snake_segments:
                valid_positions.append(pos)
    
    # 随机选择
    if valid_positions.size() > 0:
        food_pos = valid_positions[randi() % valid_positions.size()]
        food_sprite.position = food_pos * CELL_SIZE

func game_over():
    current_state = GameState.GAME_OVER
    timer.stop()
    
    # 更新最高分
    if score > high_score:
        high_score = score
        save_high_score()
        high_score_label.text = "最高分: %d" % high_score
    
    # 显示游戏结束界面
    final_score_label.text = "得分: %d\n最高分: %d" % [score, high_score]
    game_over_ui.show()

func restart_game():
    game_over_ui.hide()
    start_game()

# ==================== 显示相关 ====================
func create_snake_segment(pos: Vector2, is_head: bool):
    var rect = ColorRect.new()
    rect.size = Vector2(CELL_SIZE - 2, CELL_SIZE - 2)  # -2 留出网格线
    rect.position = pos * CELL_SIZE + Vector2(1, 1)    # +1 居中
    rect.color = Color.YELLOW if is_head else Color.GREEN
    snake_container.add_child(rect)

func update_score_display():
    score_label.text = "得分: %d" % score

# ==================== 存档 ====================
func save_high_score():
    var config = ConfigFile.new()
    config.set_value("game", "high_score", high_score)
    config.save("user://scores.cfg")

func load_high_score():
    var config = ConfigFile.new()
    if config.load("user://scores.cfg") == OK:
        high_score = config.get_value("game", "high_score", 0)

# ==================== 信号处理 ====================
func _on_restart_button_pressed():
    restart_game()
```

## 3. 输入映射设置

在 Godot 项目设置中，确保有以下输入动作：
- ui_up (W 或 ↑)
- ui_down (S 或 ↓)
- ui_left (A 或 ←)
- ui_right (D 或 →)

这些是 Godot 默认的，不需要额外配置。

## 4. 游戏结束界面

创建简单的游戏结束界面：
- Panel: 半透明黑色背景
- FinalScoreLabel: 显示分数
- RestartButton: "重新开始" 按钮

将按钮的 pressed 信号连接到 game.gd 的 _on_restart_button_pressed()

---

要我解释任何部分吗？或者你想知道如何添加特殊食物类型？
```

### 💡 实际操作

1. 创建场景结构
2. 复制脚本
3. 连接信号
4. 测试运行

---

## 8. 审查阶段：代码质量

### 你要做什么
让 OpenCode 审查你的代码质量。

### 与 OpenCode 对话

```
你: /code-review game.gd
```

### OpenCode 审查代码

```
OpenCode: 
# 代码审查: game.gd

## 摘要
代码结构清晰，逻辑完整。有一些小问题需要注意。

## 🟡 重要问题

### 1. 类型警告
**问题**: snake_segments 类型可能有问题
```gdscript
# 当前
var snake_segments: Array[Vector2] = []

# 建议 - 显式类型
var snake_segments: Array[Vector2] = [] as Array[Vector2]
```

### 2. 内存泄漏风险
**问题**: create_snake_segment 创建节点但没有在场景树中管理
**修复**: 当前用 queue_free() 是正确的，但建议用 ObjectPool 优化性能

## 🟢 建议

### 1. 添加注释
建议为关键函数添加文档注释：
```gdscript
## 检查碰撞
## @param head_pos: 新头部位置
## @return: 是否发生碰撞
func check_collision(head_pos: Vector2) -> bool:
```

### 2. 提取常量
魔法数字建议提取为常量：
```gdscript
const SCORE_PER_FOOD: int = 10
const MIN_SPEED: float = 0.05
```

## ✅ 优点
- 状态机设计清晰
- 输入处理正确（防止180度转向）
- 存档功能实现正确
- 计时器使用规范

## 统计
| 指标 | 值 |
|------|-----|
| 审查文件 | 1 |
| 审查行数 | ~150 |
| 重要问题 | 2 |
| 建议 | 2 |

---

需要我帮助修复这些问题吗？
```

### 你的回答

```
你: 帮我修复类型问题，其他的我暂时不改
```

### OpenCode 提供修复

```
OpenCode: 
修复类型问题：

将第 13 行:
var snake_segments: Array[Vector2] = []

改为:
var snake_segments: Array[Vector2] = []  # GDScript会自动推断

或者更明确：
var snake_segments: Array = []  # 然后在初始化时添加类型化元素

实际上，你当前的写法在 Godot 4 中是正确的，这个警告可能是误报。
如果想消除警告，可以这样：
var snake_segments := [] as Array[Vector2]

要我应用这个修复吗？
```

---

## 9. 完成阶段：测试发布

### 你要做什么
最终测试和导出。

### 与 OpenCode 对话

```
你: /producer 查看当前进度
```

### OpenCode 报告进度

```
OpenCode: 
# Sprint 1 进度报告

## 完成率: 90%

## ✅ 已完成
- 基础场景和项目设置
- 蛇移动系统
- 食物生成系统
- 碰撞检测
- 分数显示
- 游戏状态管理
- 最高分保存
- 游戏结束界面

## ⏳ 待完成
- 音效 (可选)
- 粒子效果 (可选)

## 建议
游戏核心功能已完成！
可选功能可以在后续 Sprint 中添加。

下一步：
1. 完整测试游戏
2. 修复发现的 Bug
3. 考虑导出发布
```

### 最终测试清单

```
你: /design-review 检查游戏是否完成
```

### OpenCode 设计审查

```
OpenCode: 
# 设计审查: 贪吃蛇游戏

## 核心功能检查

| 功能 | 状态 | 备注 |
|------|------|------|
| 蛇移动控制 | ✅ | 方向键控制，不能反向 |
| 食物生成 | ✅ | 随机位置，不在蛇身上 |
| 吃食物变长 | ✅ | 正确实现 |
| 碰撞检测 | ✅ | 墙壁 + 自身 |
| 分数系统 | ✅ | 显示正常 |
| 最高分保存 | ✅ | 持久化正确 |
| 游戏结束 | ✅ | 正确检测 |
| 重新开始 | ✅ | 按钮功能正常 |

## 游戏体验检查

| 检查项 | 状态 |
|--------|------|
| 控制响应灵敏？ | ✅ |
| 难度渐进？ | ✅ (速度加快) |
| 有成就感？ | ✅ (分数 + 最高分) |
| 重新开始流畅？ | ✅ |

## 建议
游戏核心完成度很高！

可选增强（后续版本）：
1. 音效 - 吃食物、游戏结束
2. 视觉效果 - 蛇的移动动画、食物闪烁
3. 特殊食物 - 加速/减速/缩短
4. 难度选择 - 简单/普通/困难

游戏可以发布了！
```

### 导出指南

```
你: 如何导出这个游戏？
```

### OpenCode 提供导出指导

```
OpenCode: 
# Godot 导出指南

## 1. 配置导出预设

项目 → 导出 → 添加预设：
- Windows Desktop
- macOS (如果需要)
- Linux (如果需要)
- Web (HTML5)

## 2. 配置导出设置

### Windows Desktop
- Unique Name: com.yourname.snake
- Icons: 设置游戏图标

### Web
- 确保勾选 "Ensure Cross Origin Isolation Headers"

## 3. 导出

点击 "导出项目"：
- 选择输出目录
- 点击 "保存"

## 4. 测试导出

运行导出的 .exe 文件，确保一切正常。

## 5. 分发

- Windows: 压缩 .exe 和 .pck 文件
- Web: 上传整个导出目录到服务器

---

需要更详细的导出说明吗？
```

---

## 完整对话流程总结

```
1. /start → 检测团队状态
   ↓
2. /brainstorm "贪吃蛇" → 生成游戏概念文档
   ↓
3. /setup-engine godot 4.6.1 → 配置引擎
   ↓
4. /game-designer → 设计系统
   ↓
5. /sprint-plan → 规划开发任务
   ↓
6. /prototype-mode → 快速原型验证
   ↓
7. /godot-specialist → 完整实现
   ↓
8. /code-review → 代码审查
   ↓
9. /producer → 检查进度
   ↓
10. /design-review → 设计验证
   ↓
导出发布！
```

---

## 常见问题

### Q: 我不知道问什么怎么办？
**A**: 就像和真人对话一样，告诉 OpenCode 你想做什么，它会引导你。

### Q: 代码有问题怎么办？
**A**: 复制错误信息给 OpenCode，它会帮你诊断和修复。

### Q: 想添加新功能？
**A**: 用 `/game-designer` 设计新功能，用 `/godot-specialist` 实现代码。

### Q: 想优化性能？
**A**: 用 `/godot-specialist` 询问优化建议，或用 `/code-review` 检查性能问题。

---

## 技巧总结

| 技巧 | 说明 |
|------|------|
| **明确目标** | 告诉 OpenCode 你想做什么，它会推荐合适的 skill |
| **小步迭代** | 不要一次做完，用 sprint 分阶段 |
| **先原型后实现** | 用 prototype-mode 快速验证想法 |
| **定期审查** | 用 code-review 和 design-review 检查质量 |
| **提问具体** | 问题越具体，回答越有帮助 |

---

*恭喜你完成了贪吃蛇游戏！继续探索更多 skills 来提升你的游戏吧。*