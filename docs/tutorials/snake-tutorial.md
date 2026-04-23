# 新手实战教程：使用 Skills 开发贪吃蛇游戏

> 本教程面向：Godot新手程序员
> 目标：完整使用 OpenCode Skills 开发一个可运行的贪吃蛇游戏
> 预计时间：2-3小时

---

## 目录

1. [准备阶段：项目初始化](#1-准备阶段项目初始化)
2. [概念阶段：定义游戏](#2-概念阶段定义游戏)
3. [评估阶段：玩家视角验证 ⭐ NEW](#3-评估阶段玩家视角验证)
4. [配置阶段：设置引擎](#4-配置阶段设置引擎)
5. [初始化阶段：Skill初始化与项目目录结构](#5-初始化阶段skill初始化与项目目录结构)
6. [设计阶段：规划系统](#6-设计阶段规划系统)
7. [开发阶段：Sprint规划](#7-开发阶段sprint规划)
8. [原型阶段：快速验证](#8-原型阶段快速验证)
9. [实现阶段：编写代码](#9-实现阶段编写代码)
10. [审查阶段：代码质量](#10-审查阶段代码质量)
11. [完成阶段：测试发布](#11-完成阶段测试发布)

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

### OpenCode 自动触发评估

```
OpenCode: 
✅ 已保存到 design/gdd/game-concept.md

游戏概念已保存！是否从玩家视角评估这个概念？

A) 是，启动玩家评估 (推荐)
B) 跳过，稍后再评估
C) 手动选择评估视角

评估将:
- 从多个玩家视角评估游戏概念
- 识别有趣性、参与度、学习曲线等问题
- 提供具体的改进建议
```

---

## 3. 评估阶段：玩家视角验证 ⭐ NEW

> **这是 player-evaluator skill 的实际演示**

### 你要做什么
从真实玩家视角评估游戏概念，发现设计问题。

### 你的回答

```
你: A，启动玩家评估
```

### OpenCode 启动评估

```
OpenCode: 
正在启动 player-evaluator skill...

读取游戏概念: design/gdd/game-concept.md

自动选择了 5 个玩家视角:
- P01: 探索者 (休闲/放松)
- P03: 成就者 (休闲/进度)
- P02: 探索者 (核心/发现)
- P04: 成就者 (硬核/精通)
- P11: 综合型 (核心/多样)

启动并行评估...
```

### 并发评估过程

```
OpenCode: 
⚡ 正在从 5 个视角并发评估...

[后台任务启动]
  P01: 探索者 (休闲) → 评估中...
  P03: 成就者 (休闲) → 评估中...
  P02: 探索者 (核心) → 评估中...
  P04: 成就者 (硬核) → 评估中...
  P11: 综合型 (核心) → 评估中...

等待所有视角完成评估...
```

### 评估结果

```
OpenCode: 
评估完成！

# 玩家评估报告

## 执行摘要

**整体评分**: ⭐⭐⭐⭐☆ (4.0/5.0)

**前 3 个优点**:
1. ✅ 规则简单易懂 — 方向键控制，一秒上手
2. ✅ 核心循环清晰 — 移动→吃→变长→挑战
3. ✅ 渐进难度设计 — 蛇越长越紧张

**前 3 个担忧**:
1. 🟡 缺乏多样性 — 5 个视角中有 4 个担心玩法单一
2. 🟡 特殊食物可能不平衡 — 休闲玩家可能忽略
3. 🔴 缺少新手引导 — 第一次玩可能不清楚规则

---

## 维度评分汇总

| 维度 | 评分 | 趋势 |
|------|------|------|
| 有趣性 | 4.2/5 | ⬆️ 强 |
| 参与度 | 3.6/5 | ⬇️ 需改进 |
| 学习曲线 | 3.8/5 | ➡️ 良好 |
| 动机循环 | 3.9/5 | ➡️ 良好 |
| 目标匹配 | 4.0/5 | ➡️ 匹配 |

---

## 共识问题 (2+ 视角提及)

### 🔴 问题 #1: 缺少明确的新手引导
**提及视角**: P01, P03, P11
**严重程度**: 重要

**为什么重要**:
- 新玩家可能不知道"不能反向转向"
- 可能不理解特殊食物的效果
- 第一次游戏体验可能混乱

**建议**:
1. 添加简短的开始提示："用方向键控制蛇，吃食物变长！"
2. 第一次吃到特殊食物时显示效果说明
3. 可选：添加 3 秒倒计时再开始

**实施难度**: 低 (10分钟)

---

### 🟡 问题 #2: 玩法可能变单调
**提及视角**: P02, P04, P11
**严重程度**: 重要

**为什么重要**:
- 核心玩家追求深度和变化
- 休闲玩家可能玩几次就腻
- 缺乏长期动力

**建议**:
1. 添加成就系统 (如"吃 10 个加速食物")
2. 不同难度模式 (慢/中/快)
3. 可选障碍物增加挑战

**实施难度**: 中 (1-2小时)

---

## 独特洞察

### P04: 成就者 (硬核/精通)
"作为追求精通的玩家，我希望看到：
- 分数排名系统 (不只是最高分)
- 每局结束显示'本局最长蛇身'
- 速度记录"

**为什么这个视角看到不同**:
硬核玩家追求可量化的成就，不只是"玩得开心"。

---

## 优先级行动项

**原型前必须修复**:
1. [ ] 添加基本游戏提示 (新手引导问题)

**应该改进**:
2. [ ] 设计 2-3 个简单成就
3. [ ] 考虑难度选择

**可以考虑**:
4. [ ] 添加排名系统

---

完整报告已保存到: design/gdd/player-evaluation-report.md
```

### 处理评估结果

```
OpenCode: 
评估完成！

**整体评分**: 4.0/5
**首要担忧**: 缺少新手引导

选择:
A) 查看完整报告
B) 讨论如何改进
C) 继续下一步 (setup-engine)
```

### 你的回答

```
你: B，讨论如何改进新手引导
```

### OpenCode 讨论改进

```
OpenCode: 
## 新手引导改进方案

根据评估反馈，我建议采用最简单的方案：

### 方案 A: 启动提示 (推荐)
**实现**:
- 游戏开始时显示 3 秒提示
- 文案: "用方向键控制蛇，吃食物变长，不要撞墙！"
- 任意键或点击关闭

**代码示例**:
```gdscript
func show_tutorial():
    tutorial_label.text = "用方向键控制蛇，吃食物变长！"
    tutorial_timer.start(3.0)
    yield(tutorial_timer, "timeout")
    tutorial_label.hide()
```

**时间**: 10分钟
**影响**: 大幅改善首次体验

---

### 方案 B: 交互式教程 (更完整)
**实现**:
- 第一次启动进入教程模式
- 引导玩家完成: 移动→吃食物→游戏结束
- 然后进入正式游戏

**时间**: 30-45分钟
**影响**: 完整的新手体验

---

**我的建议**: 先用方案 A，快速验证。如果后续玩家反馈仍不清楚，再升级到方案 B。

要更新 game-concept.md 加入这个改进吗？
```

### 你的回答

```
你: 好，更新一下
```

### OpenCode 更新文档

```
OpenCode: 
✅ 已更新 game-concept.md，添加了新手引导设计

## Key Features 更新:
- 经典蛇移动控制
- **新手引导提示** (新增)
- 普通食物（+1长度，+10分）
- 特殊食物（随机出现，不同效果）
- 分数和最高分记录
- 游戏结束和重新开始

你可以继续下一步了！
```

---

### 💡 评估阶段的价值

**为什么这个阶段很重要**:
1. **早期发现问题** — 在写代码前发现设计缺陷
2. **多视角验证** — 不同类型玩家看到不同问题
3. **优先级排序** — 知道什么必须先修，什么可以后加
4. **避免返工** — 减少"做完才发现不好玩"的情况

**评估使用的方法论**:
- **Bartle 类型** — 探索者/成就者/社交者/杀手
- **心流理论** — 挑战与技能平衡
- **自我决定理论** — 自主性/胜任感/关系感
- **MDA 框架** — 机制/动态/美学

---

## 4. 配置阶段：设置引擎

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

## 5. 初始化阶段：Skill 初始化与项目目录结构

### 你要做什么
告诉 OpenCode 你的游戏是什么样的，AI 会自动分析并生成最适合的目录结构。

### 与 OpenCode 对话

```
你: /setup-engine 初始化项目目录
```

或者，如果你已经在第 4 步配置了引擎，可以直接描述你的项目：

```
你: 我要做一个2D像素风贪吃蛇游戏，类似经典街机玩法，规模不大，一周内完成
```

### OpenCode 智能分析

OpenCode 会自动从你的描述中提取关键信息：

```
OpenCode:
正在分析你的项目描述...
━━━━━━━━━━━━━━━━━━━━━━
📝 原始描述: "2D像素风贪吃蛇游戏，类似经典街机玩法，一周内完成"

🔍 AI 分析结果:
- 游戏类型:   2D 街机 (关键词: 贪吃蛇、街机)
- 视觉风格:   像素风 (关键词: 像素)
- 项目规模:   Jam (48小时-1周) (关键词: 一周内完成)
- 代码语言:   GDScript (根据第4步配置)

✅ 置信度: 95%
━━━━━━━━━━━━━━━━━━━━━━
```

### 如果 AI 分析不准确

你可以直接纠正或补充：

```
你: 其实这不是街机游戏，我要做的是一个带剧情的 RPG 贪吃蛇，规模是中型项目
```

OpenCode 会重新分析：

```
OpenCode:
🔄 重新分析...

🔍 更新结果:
- 游戏类型:   RPG (用户纠正)
- 视觉风格:   像素风
- 项目规模:   Medium (6-18月) (用户指定)
- 特殊需求:   剧情系统、任务系统、库存系统

⚠️ 注意: RPG 规模与 "一周内完成" 冲突，建议调整为 Small (1-6月)
━━━━━━━━━━━━━━━━━━━━━━
```

### OpenCode 生成智能目录结构

根据 AI 分析的类型、规模和语言，自动生成最适合的目录：

#### 维度 1: 项目规模 → 目录深度

| 规模 | 目录深度 | 特点 | 适用场景 |
|------|----------|------|----------|
| **Jam** | 扁平 (1-2层) | 快速迭代，减少嵌套 | Game Jam、原型、48小时作品 |
| **Small** | 2-3层 | 适度组织，平衡速度 | 个人项目、1-6个月 |
| **Medium** | 3-4层 | 严格分层，长期维护 | 团队协作、6-18个月 |

#### 维度 2: 游戏类型 → 特殊目录

| 类型 | 自动检测关键词 | 特殊目录 | 说明 |
|------|----------------|----------|------|
| **2D 街机** | 贪吃蛇、打砖块、射击 | `entities/`, `effects/`, `waves/` | 精灵、粒子、波次系统 |
| **平台跳跃** | 平台、跳跃、关卡 | `levels/`, `characters/`, `physics/` | 关卡和角色分离 |
| **RPG** | RPG、剧情、任务 | `inventory/`, `dialogue/`, `quests/`, `combat/` | 复杂系统 |
| **策略** | 策略、战棋、塔防 | `maps/`, `units/`, `ai/`, `economy/` | 地图和单位 |
| **恐怖** | 恐怖、惊悚 | `lighting/`, `audio/ambience/`, `jumpscares/` | 氛围系统 |
| **解谜** | 解谜、逻辑 | `puzzles/`, `mechanisms/`, `hints/` | 谜题机制 |

#### 维度 3: 代码语言 → 命名规范

**GDScript 为主**:
```
src/
├── autoload/          # 全局单例
├── entities/          # 游戏实体
│   └── snake.gd
├── systems/           # 核心系统
│   ├── movement_system.gd
│   ├── collision_system.gd
│   └── score_system.gd
├── ui/                # 界面
│   ├── hud.gd
│   └── menus/
└── utils/             # 工具
```

**C# 为主**:
```
src/
├── Autoload/
├── Entities/
├── Systems/
├── UI/
└── Utils/
```

**双语言 (GDScript + C#)**:
```
src/
├── autoload/
├── entities/
│   ├── snake.gd       # GDScript 实体
│   └── score_manager.cs  # C# 管理器
├── systems/
│   ├── movement/      # GDScript 系统
│   └── data/          # C# 数据处理
├── ui/
└── utils/
```

### OpenCode 展示智能推荐

```
OpenCode:
根据你的描述，我为你智能生成了目录结构：

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 分析依据:
- 类型: 2D 街机 (检测到: "贪吃蛇"、"街机")
- 规模: Jam (检测到: "一周内完成")
- 语言: GDScript (第4步已配置)
- 风格: 像素风 (检测到: "像素风")

📁 推荐目录结构:
src/
├── autoload/              # 全局单例 (GameManager, AudioManager)
├── entities/              # 游戏实体
│   ├── snake.gd           # 蛇的显示和控制
│   └── food.gd            # 食物实体
├── systems/               # 核心系统
│   ├── movement_system.gd # 移动逻辑
│   ├── collision_system.gd# 碰撞检测
│   ├── score_system.gd    # 分数管理
│   └── spawn_system.gd    # 食物生成
├── effects/               # 视觉效果 (像素风特效)
│   └── pixel_effects.gd   # 粒子、闪烁等
├── ui/                    # 界面
│   ├── hud.gd             # 分数显示
│   ├── menus/
│   │   ├── main_menu.gd
│   │   └── game_over.gd
│   └── pixel_fonts/       # 像素字体
└── utils/                 # 工具函数

assets/
├── sprites/               # 像素精灵
│   ├── snake/             # 蛇身、蛇头
│   │   ├── head_8x8.png
│   │   └── body_8x8.png
│   ├── food/              # 食物
│   │   ├── apple_8x8.png
│   │   └── star_8x8.png
│   └── effects/           # 特效贴图
│       └── particles.png
├── audio/
│   ├── sfx/               # 音效 (吃食物、碰撞)
│   └── music/             # 背景音乐
└── fonts/                 # 像素字体

design/
├── gdd/                   # 游戏设计文档
└── levels/                # 关卡配置 (如果有)

tests/                     # 单元测试
prototypes/                # 原型存档
production/                # 发布相关
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 智能优化:
- Jam 规模 → 目录扁平，减少嵌套
- 像素风 → 添加 pixel_fonts/ 和 effects/
- 街机类型 → 添加 spawn_system.gd 和 waves/ (波次)

确认创建？(Y/n)
或输入调整需求，如 "再加一个排行榜系统"
```

### 你可以调整细节

```
你: 再加一个排行榜系统和成就系统
```

OpenCode 会更新目录：

```
OpenCode:
🔄 更新目录结构...

新增:
src/
├── systems/
│   ├── leaderboard_system.gd   # 排行榜
│   └── achievement_system.gd   # 成就系统

assets/
└── sprites/
    └── ui/
        ├── trophy_icons/       # 成就图标
        └── medal_sprites/      # 奖牌

设计已更新！
```

### 你的回答

```
你: Y
```

### OpenCode 完成初始化

```
OpenCode:
✅ 项目目录初始化完成
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
类型:       2D 街机 (AI 自动判别)
规模:       Jam (AI 自动判别)
语言:       GDScript
风格:       像素风 (AI 自动判别)

已创建:
- src/autoload/
- src/entities/
- src/systems/
- src/ui/
- src/effects/
- assets/sprites/snake/
- assets/sprites/food/
- assets/audio/sfx/
- assets/audio/music/

🎯 AI 优化点:
- 检测到 "像素风" → 自动添加 pixel_fonts/ 目录
- 检测到 "街机" → 自动添加 spawn_system.gd
- 检测到 "一周内完成" → 采用扁平 Jam 结构

下一步建议：
1. 运行 /game-designer 设计核心系统
2. 或运行 /art-coordinator 准备美术资源
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 💡 为什么让 AI 自动判别更好

**传统方式**:
- 用户必须手动选择类型、规模
- 容易选错或不匹配
- 配置耗时

**AI 判别方式**:
- 用户自然语言描述项目
- AI 自动提取关键词分析
- 多维度交叉验证 (类型×规模×语言)
- 提供置信度和调整建议
- 允许用户随时纠正

**示例**:
```
用户: "我要做类似蔚蓝(Celeste)的困难平台跳跃，但带一点剧情"

AI 分析:
- 类型: 平台跳跃 ("平台跳跃" 关键词)
- 难度: 高 ("困难", "蔚蓝")
- 剧情: 轻度 ("一点剧情")
- 规模: Small (参考蔚蓝规模)

自动推荐: 平台跳跃目录 + 剧情目录 + 高难度关卡目录
```

---

## 6. 设计阶段：规划系统

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

## 7. 开发阶段：Sprint规划

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

## 8. 原型阶段：快速验证

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

## 9. 实现阶段：编写代码

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

## 10. 审查阶段：代码质量

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

## 11. 完成阶段：测试发布

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
  3. /player-evaluator → 多视角评估游戏概念 ⭐ NEW
     ↓
  4. /setup-engine godot 4.6.1 → 配置引擎
     ↓
  5. /setup-engine 初始化项目目录 → 初始化目录结构 ⭐ NEW
     ↓
  6. /game-designer → 设计系统
     ↓
  7. /sprint-plan → 规划开发任务
     ↓
  8. /prototype-mode → 快速原型验证
     ↓
  9. /godot-specialist → 完整实现
     ↓
 10. /code-review → 代码审查
     ↓
 11. /producer → 检查进度
     ↓
 12. /design-review → 设计验证
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

## 12. MCP 增强阶段：使用 AI 生成资源

### 你要做什么
使用 MCP 服务器让 AI 生成游戏的美术和音效资源，快速打造独特风格。

### 什么是 MCP？

**MCP (Model Context Protocol)** 是一个开放协议，允许 AI Agent 与外部工具服务连接。通过 MCP，你可以：

- 🎨 **生成像素艺术** - PixelLab MCP
- 🔊 **生成游戏音效** - ElevenLabs MCP
- 🎮 **自动化 Godot 操作** - Godot MCP

```
你: 用 PixelLab 生成像素蛇
AI: [调用 MCP] → 生成图片 → 保存到 assets/
```

### 前置准备

```
你: 我想为贪吃蛇添加自定义的美术和音效，怎么做最快？
```

### OpenCode 会推荐

```
OpenCode: 你可以用 MCP 集成来 AI 生成资源！

## 快速配置步骤

### 1. 获取 API Keys

**PixelLab** (像素艺术):
- 访问: https://pixellab.ai/dashboard
- 注册获取 API Token
- 免费额度可用

**ElevenLabs** (音效):
- 访问: https://elevenlabs.io
- 注册获取 API Key
- 免费额度可用

### 2. 运行配置脚本

Windows:
```powershell
.\scripts\setup-mcp.ps1
```

Linux/macOS:
```bash
chmod +x scripts/setup-mcp.sh
./scripts/setup-mcp.sh
```

### 3. 输入 API Keys

按提示输入你的 API Keys，脚本会自动配置。

需要帮助吗？
```

### 配置 MCP

```
你: 帮我配置 MCP
```

### OpenCode 指导配置

```
OpenCode: 
好的！我来帮你配置 MCP 集成。

## 步骤 1: 获取 API Keys

### PixelLab（像素艺术）
1. 访问 https://pixellab.ai
2. 点击 Sign Up 注册账号
3. 进入 Dashboard 获取 API Token

### ElevenLabs（音频）
1. 访问 https://elevenlabs.io
2. 注册账号
3. 在 Settings → API Keys 获取 Key

## 步骤 2: 运行配置脚本

在终端运行：
```powershell
.\scripts\setup-mcp.ps1
```

按提示输入你的 API Keys。

## 步骤 3: 验证配置

配置完成后告诉我，我来帮你生成资源！
```

### 生成像素资源

```
你: MCP 已配置，帮我生成贪吃蛇的像素角色
```

### OpenCode 生成资源

```
OpenCode: 
正在调用 PixelLab MCP...

✅ 已生成以下资源：
- assets/sprites/generated/snake_head_8x8.png
- assets/sprites/generated/snake_body_8x8.png
- assets/sprites/generated/food_apple_8x8.png
- assets/sprites/generated/food_star_8x8.png

这些资源已保存到你的项目目录中。

下一步：在 Godot 中导入这些资源
```

### 生成音效

```
你: 再生成游戏音效
```

### OpenCode 生成音效

```
OpenCode:
正在调用 ElevenLabs MCP...

✅ 已生成以下音效：
- assets/audio/generated/sfx_eat_normal.wav (普通食物)
- assets/audio/generated/sfx_eat_special.wav (特殊食物)
- assets/audio/generated/sfx_game_over.wav (游戏结束)

音效特点：
- eat_normal: 短促清脆 (0.3秒)
- eat_special: 欢快魔法 (0.5秒)
- game_over: 低沉警告 (1秒)
```

### 集成到项目

```
你: 如何使用这些生成的资源？
```

### OpenCode 指导集成

```
OpenCode:
## 1. 导入像素资源

在 Godot 中：
1. 将 `assets/sprites/generated/` 拖入 FileSystem
2. 资源会自动导入

## 2. 更新代码使用 Sprite2D

修改 `game.gd` 中的显示部分：

```gdscript
# 原来使用 ColorRect
func create_snake_segment(pos: Vector2, is_head: bool):
    var rect = ColorRect.new()
    rect.size = Vector2(CELL_SIZE - 2, CELL_SIZE - 2)
    rect.position = pos * CELL_SIZE + Vector2(1, 1)
    rect.color = Color.YELLOW if is_head else Color.GREEN
    snake_container.add_child(rect)

# 改用 Sprite2D 加载生成的图片
func create_snake_segment(pos: Vector2, is_head: bool):
    var sprite = Sprite2D.new()
    if is_head:
        sprite.texture = load("res://assets/sprites/generated/snake_head_8x8.png")
    else:
        sprite.texture = load("res://assets/sprites/generated/snake_body_8x8.png")
    sprite.position = pos * CELL_SIZE + Vector2(CELL_SIZE/2, CELL_SIZE/2)
    snake_container.add_child(sprite)
```

## 3. 添加音效播放

在 `eat_food()` 函数中添加音效：

```gdscript
func eat_food():
    # 播放音效
    var sound_player = AudioStreamPlayer.new()
    if food_type == "special":
        sound_player.stream = load("res://assets/audio/generated/sfx_eat_special.wav")
    else:
        sound_player.stream = load("res://assets/audio/generated/sfx_eat_normal.wav")
    add_child(sound_player)
    sound_player.play()
    
    # 原有逻辑
    score += 10
    update_score_display()
    # ...
```

## 4. 食物显示

更新食物显示：

```gdscript
func update_food_display():
    var texture_path = "res://assets/sprites/generated/food_apple_8x8.png"
    if food_type == "special":
        texture_path = "res://assets/sprites/generated/food_star_8x8.png"
    food_sprite.texture = load(texture_path)
```

需要我帮你应用这些更改吗？
```

### 测试效果

```
你: 应用更改并运行游戏
```

### OpenCode 执行测试

```
OpenCode:
正在更新代码...

✅ 已更新 game.gd
✅ 已添加音效播放
✅ 已更新食物显示

正在启动游戏...

观察结果：
✅ 蛇头显示像素图片
✅ 蛇身显示像素图片
✅ 食物显示苹果/星星图片
✅ 吃食物播放对应音效

效果如何？需要调整吗？
```

### 进一步增强

```
你: 还可以生成什么？
```

### OpenCode 建议

```
OpenCode:
MCP 还可以帮你：

## 视觉增强
- 🎨 生成 UI 按钮（开始、重新开始）
- 🎨 生成背景瓦片
- 🎨 生成粒子效果贴图

## 音频增强  
- 🔊 生成背景音乐
- 🔊 生成按钮点击音效
- 🔊 生成不同风格的吃食物音效

## 自动化
- 🎮 批量创建测试场景
- 🎮 自动生成碰撞形状
- 🎮 导出资源包

需要我帮你生成这些吗？
```

---

## MCP 增强总结

| 功能 | 传统方式 | MCP 方式 | 时间节省 |
|------|----------|----------|----------|
| 美术资源 | 手绘/购买素材 | AI 生成 | 90%+ |
| 音效资源 | 手动录音/购买 | AI 生成 | 90%+ |
| 资源集成 | 手动导入配置 | AI 辅助 | 50%+ |

### 优势

- ⚡ **快速迭代** - 几秒生成新资源
- 💰 **低成本** - 无需购买素材包
- 🎯 **定制化** - 完全符合游戏需求
- 🔄 **易于修改** - 不满意随时重新生成

### 注意事项

1. **审核资源** - AI 生成的内容需要人工检查
2. **统一风格** - 提供一致的风格描述词
3. **备份资源** - 定期备份生成的文件
4. **API 配额** - 注意免费额度限制

### 更多资源

- 📖 [MCP 集成指南](../mcp/MCP_GUIDE_CN.md)
- 📝 [使用示例集](../mcp/EXAMPLES_CN.md)

---

*恭喜你完成了贪吃蛇游戏！继续探索更多 skills 来提升你的游戏吧。*