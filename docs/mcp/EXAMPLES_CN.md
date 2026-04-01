# MCP 使用示例集

> 实际场景中使用 MCP 服务器的详细示例

---

## 目录

1. [像素角色生成 (PixelLab)](#示例-1-像素角色生成-pixellab)
2. [游戏音效生成 (ElevenLabs)](#示例-2-游戏音效生成-elevenlabs)
3. [自动化场景创建 (Godot MCP)](#示例-3-自动化场景创建-godot-mcp)
4. [完整工作流 - 贪吃蛇项目](#示例-4-完整工作流---贪吃蛇项目)
5. [批量生成瓦片集](#示例-5-批量生成瓦片集)
6. [生成角色动画](#示例-6-生成角色动画)
7. [创建敌人 AI 场景](#示例-7-创建敌人-ai-场景)
8. [生成游戏 UI 元素](#示例-8-生成游戏-ui-元素)

---

## 示例 1: 像素角色生成 (PixelLab)

### 场景
需要为游戏创建主角的像素精灵图。

### 用户输入
```
用 PixelLab 生成一个像素风格的勇士角色：
- 16x16 像素
- 蓝色盔甲、金色头盔
- 经典 JRPG 风格
- 需要 4 个方向（上下左右）
```

### AI 执行流程

1. **调用工具**: `create_character`
2. **参数构建**:
   ```json
   {
     "description": "像素风格勇士角色，16x16像素，蓝色盔甲金色头盔，经典JRPG风格",
     "n_directions": 4
   }
   ```
3. **生成资源**
4. **保存位置**: `assets/sprites/generated/hero_warrior_16x16.png`

### 输出结果
```
✅ 已生成角色精灵图
📍 保存位置: assets/sprites/generated/hero_warrior_16x16.png
📐 尺寸: 16x16 像素 (每帧)
🔀 方向: 4方向 (上下左右)
```

### 后续步骤

在 Godot 中：
1. 将图片拖入项目
2. 创建 Sprite2D 节点
3. 设置 HFrames/VFrames
4. 创建动画播放器

---

## 示例 2: 游戏音效生成 (ElevenLabs)

### 场景
需要为贪吃蛇游戏生成各种音效。

### 用户输入
```
用 ElevenLabs 为贪吃蛇生成以下音效：
1. eat_normal - 吃普通食物的清脆叮声，短促欢快
2. eat_special - 吃特殊食物的闪亮音效，带有魔法感
3. game_over - 游戏结束的低沉警告音
4. button_click - 按钮点击的轻微反馈音
```

### AI 执行流程

逐个调用 `generate_sound_effect` 工具：

```
正在生成音效...

[1/4] eat_normal.wav
  描述: 清脆短促的叮声，吃食物音效
  时长: 0.3秒
  
[2/4] eat_special.wav
  描述: 魔法闪亮音效，带有星星闪烁感
  时长: 0.5秒
  
[3/4] game_over.wav
  描述: 低沉警告音，游戏失败提示
  时长: 1.0秒
  
[4/4] button_click.wav
  描述: 轻微点击反馈音
  时长: 0.1秒
```

### 输出结果
```
✅ 已生成 4 个音效文件
📍 保存位置: assets/audio/generated/
  - sfx_eat_normal.wav
  - sfx_eat_special.wav
  - sfx_game_over.wav
  - sfx_button_click.wav
```

### 集成代码

```gdscript
# 音效管理器
extends Node

var sounds = {
    "eat_normal": preload("res://assets/audio/generated/sfx_eat_normal.wav"),
    "eat_special": preload("res://assets/audio/generated/sfx_eat_special.wav"),
    "game_over": preload("res://assets/audio/generated/sfx_game_over.wav"),
    "button_click": preload("res://assets/audio/generated/sfx_button_click.wav")
}

func play_sound(name: String):
    if sounds.has(name):
        var player = AudioStreamPlayer.new()
        player.stream = sounds[name]
        add_child(player)
        player.play()
        await player.finished
        player.queue_free()
```

---

## 示例 3: 自动化场景创建 (Godot MCP)

### 场景
需要创建一个敌人生成器场景。

### 用户输入
```
用 Godot MCP 创建一个敌人生成器场景：
- 场景名称: EnemySpawner
- 根节点: Node2D
- 子节点:
  - Timer (名称: SpawnTimer, wait_time: 2.0)
  - Marker2D (名称: SpawnPoint, position: 100, 100)
- 保存到: src/gameplay/enemy_spawner.tscn
```

### AI 执行流程

```
[1/3] 创建场景...
  场景路径: res://src/gameplay/enemy_spawner.tscn
  根节点类型: Node2D
  
[2/3] 添加节点...
  ✓ Timer: SpawnTimer (wait_time=2.0)
  ✓ Marker2D: SpawnPoint (position=100,100)
  
[3/3] 保存场景...
  ✓ 已保存
```

### 输出结果
```
✅ 场景创建完成
📍 路径: src/gameplay/enemy_spawner.tscn
📦 结构:
  EnemySpawner (Node2D)
  ├── SpawnTimer (Timer)
  └── SpawnPoint (Marker2D)
```

---

## 示例 4: 完整工作流 - 贪吃蛇项目

### 场景
从零开始，使用 MCP 为贪吃蛇游戏生成所有资源。

### Step 1: 生成视觉资源

```
你: 我要开发一个贪吃蛇游戏，帮我生成所有像素资源

AI: 好的！请告诉我需要哪些资源？

你: 需要：
    - 蛇头：绿色，8x8像素，卡通风格
    - 蛇身：绿色渐变，8x8像素
    - 食物：红色苹果，8x8像素
    - 特殊食物：金色星星，8x8像素
    - 游戏边框：深灰色砖块风格

AI: 正在批量生成...

[PixelLab] 生成 snake_head_8x8.png ✓
[PixelLab] 生成 snake_body_8x8.png ✓
[PixelLab] 生成 food_apple_8x8.png ✓
[PixelLab] 生成 food_star_8x8.png ✓
[PixelLab] 生成 border_brick_8x8.png ✓

✅ 5 个像素资源已生成
📍 保存到: assets/sprites/generated/
```

### Step 2: 生成音效

```
你: 现在生成游戏音效

AI: 请描述需要的音效...

你: 需要：
    - 吃普通食物：清脆叮声
    - 吃特殊食物：魔法音效
    - 游戏结束：失败音
    - 游戏开始：欢快音效
    - 移动：轻微滑动声（可选）

AI: 正在生成音效...

[ElevenLabs] 生成 sfx_eat_normal.wav ✓
[ElevenLabs] 生成 sfx_eat_special.wav ✓
[ElevenLabs] 生成 sfx_game_over.wav ✓
[ElevenLabs] 生成 sfx_game_start.wav ✓

✅ 4 个音效已生成
📍 保存到: assets/audio/generated/
```

### Step 3: 创建场景结构

```
你: 创建游戏的主场景结构

AI: [使用 Godot MCP]

创建场景: Main.tscn
  ├── Game (Node2D)
  │   ├── Grid (Node2D)
  │   │   ├── SnakeContainer (Node2D)
  │   │   └── Food (Sprite2D)
  │   ├── UI (CanvasLayer)
  │   │   ├── ScoreLabel (Label)
  │   │   └── HighScoreLabel (Label)
  │   ├── GameOverUI (CanvasLayer)
  │   └── GameTimer (Timer)

✅ 场景结构已创建
```

### Step 4: 集成资源

```
你: 把生成的资源集成到项目中

AI: 好的！我来更新代码以使用生成的资源。

[更新] game.gd - 使用 Sprite2D 替代 ColorRect
[添加] AudioManager.gd - 音效播放管理
[更新] 资源引用路径

✅ 集成完成！

代码示例:

# 更新后的蛇身创建函数
func create_snake_segment(pos: Vector2, is_head: bool):
    var sprite = Sprite2D.new()
    if is_head:
        sprite.texture = load("res://assets/sprites/generated/snake_head_8x8.png")
    else:
        sprite.texture = load("res://assets/sprites/generated/snake_body_8x8.png")
    sprite.position = pos * CELL_SIZE + Vector2(CELL_SIZE/2, CELL_SIZE/2)
    snake_container.add_child(sprite)
```

### 完整输出

```
📋 资源清单

像素资源 (5):
├── assets/sprites/generated/snake_head_8x8.png
├── assets/sprites/generated/snake_body_8x8.png
├── assets/sprites/generated/food_apple_8x8.png
├── assets/sprites/generated/food_star_8x8.png
└── assets/sprites/generated/border_brick_8x8.png

音效资源 (4):
├── assets/audio/generated/sfx_eat_normal.wav
├── assets/audio/generated/sfx_eat_special.wav
├── assets/audio/generated/sfx_game_over.wav
└── assets/audio/generated/sfx_game_start.wav

场景文件 (1):
└── src/scenes/main.tscn

脚本文件 (2):
├── src/scripts/game.gd
└── src/scripts/audio_manager.gd
```

---

## 示例 5: 批量生成瓦片集

### 用户输入
```
用 PixelLab 生成一套地牢瓦片集：
- 地面：石砖，带裂缝细节
- 墙壁：深色石墙，有苔藓
- 门：木门，带铁钉
- 装饰：骷髅头、蜡烛、宝箱
- 统一尺寸：32x32像素
```

### AI 执行流程

```
正在批量生成地牢瓦片集...

[1/5] 地面石砖
[2/5] 墙壁石墙
[3/5] 木门
[4/5] 装饰物
[5/5] 组合瓦片集
```

### 输出结果
```
✅ 地牢瓦片集已生成
📍 assets/sprites/generated/tileset_dungeon_32x32.png

包含瓦片:
- ground_stone_32x32.png (地面)
- wall_stone_32x32.png (墙壁)
- door_wood_32x32.png (门)
- decor_skull_32x32.png (骷髅)
- decor_candle_32x32.png (蜡烛)
- decor_chest_32x32.png (宝箱)
```

---

## 示例 6: 生成角色动画

### 用户输入
```
为刚才生成的勇士角色添加动画：
- idle: 待机动画，轻微呼吸效果
- walk: 行走动画，4帧
- attack: 攻击动画，挥剑动作
- hurt: 受伤动画，闪烁效果
```

### AI 执行流程

```
[PixelLab] animate_character

角色 ID: hero_warrior_16x16

生成动画:
[1/4] idle - 2帧循环 ✓
[2/4] walk - 4帧循环 ✓
[3/4] attack - 3帧单向 ✓
[4/4] hurt - 2帧闪烁 ✓
```

### 输出结果
```
✅ 动画已添加
📍 更新文件: assets/sprites/generated/hero_warrior_16x16.png

动画帧分布:
- idle: 帧 0-1 (循环)
- walk: 帧 2-5 (循环)
- attack: 帧 6-8 (单次)
- hurt: 帧 9-10 (单次)
```

---

## 示例 7: 创建敌人 AI 场景

### 用户输入
```
用 Godot MCP 创建一个敌人场景：
- 场景名: BasicEnemy
- 根节点: CharacterBody2D
- 子节点:
  - Sprite2D (使用生成的敌人精灵)
  - CollisionShape2D (矩形碰撞)
  - AnimationPlayer
  - Timer (巡逻计时器)
- 脚本: 基础巡逻 AI
```

### AI 执行流程

```
[Godot MCP] 创建场景...

创建: src/enemies/basic_enemy.tscn
  BasicEnemy (CharacterBody2D)
  ├── Sprite2D
  ├── CollisionShape2D
  ├── AnimationPlayer
  └── PatrolTimer (Timer)

创建: src/enemies/basic_enemy.gd
  - 巡逻逻辑
  - 碰撞检测
  - 动画控制

✅ 敌人场景已创建
```

---

## 示例 8: 生成游戏 UI 元素

### 用户输入
```
用 PixelLab 生成游戏 UI 元素：
- 按钮：普通、悬停、按下三种状态
- 生命值条：心形图标
- 分数显示：数字 0-9
- 对话框边框
- 统一风格：像素复古风
```

### AI 执行流程

```
[PixelLab] 批量生成 UI 元素...

按钮状态:
- btn_normal.png ✓
- btn_hover.png ✓
- btn_pressed.png ✓

生命值:
- heart_full.png ✓
- heart_half.png ✓
- heart_empty.png ✓

数字:
- num_0.png ~ num_9.png ✓

对话框:
- dialog_border.png ✓
```

### 输出结果
```
✅ UI 元素已生成
📍 assets/sprites/generated/ui/

按钮 (3):
├── ui/btn_normal.png
├── ui/btn_hover.png
└── ui/btn_pressed.png

生命值 (3):
├── ui/heart_full.png
├── ui/heart_half.png
└── ui/heart_empty.png

数字 (10):
├── ui/num_0.png
├── ...
└── ui/num_9.png

对话框 (1):
└── ui/dialog_border.png
```

---

## 使用技巧总结

### 高效使用 MCP 的建议

1. **批量请求**: 一次请求多个资源，减少交互次数
2. **统一风格**: 提供一致的风格描述词
3. **明确尺寸**: 指定精确的像素尺寸
4. **命名规范**: 使用有意义的文件名前缀
5. **验证资源**: 生成后检查质量，必要时重新生成

### 常用提示词模板

```
# 像素角色
"用 PixelLab 生成一个 [风格] 的 [角色类型]：
- 尺寸: [NxN]像素
- 颜色: [主色调]
- 特征: [描述特征]
- 方向: [N]个方向"

# 音效
"用 ElevenLabs 生成 [音效名称]：
- 类型: [音效类型]
- 情绪: [情绪描述]
- 时长: [约N秒]
- 参考: [类似什么声音]"

# 场景
"用 Godot MCP 创建 [场景名称]：
- 根节点: [节点类型]
- 子节点: [列表]
- 脚本: [功能描述]
- 保存到: [路径]"
```

---

> 💡 **提示**: 更多示例和技巧，查看 [MCP_GUIDE_CN.md](./MCP_GUIDE_CN.md)