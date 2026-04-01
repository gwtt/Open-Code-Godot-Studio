# ARPG (Action RPG) Game Questionnaire

---

## Core Questions

1. **技能系统**: "技能如何设计？"
   - 主动技能数量（限制？）
   - 技能树/技能槽
   - 技能升级机制
   - 组合技能系统

2. **装备系统**: "装备如何工作？"
   - 装备槽位数量
   - 装备稀有度（普通/稀有/传说？）
   - 装备升级/强化
   - 套装效果

3. **战斗深度**: "战斗有什么机制？"
   - 攻击类型（近战/远程/魔法）
   - 闪避/格挡系统
   - 连击系统
   - 状态效果（中毒、燃烧等）

4. **角色成长**: "角色如何成长？"
   - 属性点分配
   - 等级提升解锁
   - 装备驱动
   - 技能熟练度

## Technical Questions

5. **游戏分辨率**: "目标分辨率？"

6. **视角**: "使用什么视角？"
   - Top-down (Diablo style)
   - Side-view (Metroidvania)
   - 3D third-person
   - 等距视角

7. **敌人设计**: "敌人类型有哪些？"
   - 普通怪（ cannon fodder）
   - 精英怪（特殊能力）
   - Boss设计（多阶段？）
   - 敌人AI复杂度

8. **多人模式**: "是否支持多人？"
   - 单人体验
   - 合作模式
   - 竞技PVP
   - 异步多人（排行榜等）

## Output Fields

- Skills: [count, system type]
- Equipment: [slots, rarity levels]
- Combat Mechanics: [list]
- Progression: [attribute/level/equipment/mastery]
- Resolution: [value]
- View: [type]
- Enemy Types: [list]
- Multiplayer: [solo/coop/pvp/async]