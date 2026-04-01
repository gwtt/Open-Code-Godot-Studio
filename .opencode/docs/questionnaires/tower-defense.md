# Tower Defense Game Questionnaire

Ask these questions after detecting tower defense keywords.

---

## Core Questions (Must Ask)

1. **塔类型**: "塔有哪些类型？"
   - 基础塔（单体伤害）
   - 范围塔（AOE）
   - 特殊塔（减速、buff、陷阱）
   - 混合塔（多用途）

2. **敌人波次**: "敌人如何生成？"
   - 固定波次路线
   - 多入口多路径
   - 无限波次模式
   - Boss波次

3. **经济系统**: "玩家如何获取资源？"
   - 杀敌奖励
   - 时间奖励
   - 资源点占领
   - 初始资金+无额外收入

4. **地图设计**: "地图是什么样的？"
   - 单条路径
   - 多路径
   - 开放式（玩家定义路径）
   - 网格布局

## Technical Questions

5. **游戏分辨率**: "目标分辨率是多少？"
   - 推荐: 1920x1080 (PC), 1280x720 (Mobile)
   - 响应式UI需求？

6. **视角**: "使用什么视角？"
   - Top-down 2D
   - Isometric
   - Side-view
   - 3D

7. **塔升级系统**: "塔如何升级？"
   - 线性升级（伤害提升）
   - 分支升级（选择路径）
   - 无升级（购买新塔）
   - 组合升级（合成）

8. **特殊机制**: "有什么独特机制？"
   - 英雄单位
   - 技能系统
   - 天气/环境影响
   - Mazing（玩家建造路径）

## Output Fields

Save to `design/gdd/game-concept.md`:
- Tower Types: [list with brief description]
- Wave System: [description]
- Economy Model: [description]
- Map Type: [single/multi/open/grid]
- Resolution: [value]
- View: [type]
- Upgrade System: [type]
- Unique Mechanics: [list]