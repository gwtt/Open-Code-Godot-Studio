# Roguelike Game Questionnaire

Ask these questions after detecting roguelike keywords.

---

## Core Questions (Must Ask)

1. **进度类型**: "进度如何保存？"
   - Meta进度（永久解锁）
   - Run进度（单次有效）
   - 混合模式（部分永久）
   - 无进度（纯技巧）

2. **死亡机制**: "死亡后发生什么？"
   - 完全重置（经典roguelike）
   - 保留部分进度（roguelite）
   - 多次尝试机制（生命系统）
   - 检查点系统

3. **关卡生成**: "关卡如何生成？"
   - 完全程序生成
   - 手工设计片段组合
   - 固定关卡+随机元素
   - 叙事驱动布局

4. **核心循环**: "单次run包含什么？"
   - 探索→战斗→收集→升级
   - 关卡递进→Boss战
   - 资源管理→生存
   - 策略选择→风险评估

## Technical Questions

5. **游戏分辨率**: "目标分辨率？"
   - 推荐: 1920x1080 (PC), 1280x720 (Mobile)

6. **视角**: "使用什么视角？"
   - Top-down
   - Side-view
   - Isometric
   - 第一人称

7. **战斗系统**: "战斗如何进行？"
   - 实时动作
   - 回合制
   - 混合模式（暂停策略）
   - 自动战斗+策略

8. **Build多样性**: "如何支持不同玩法？"
   - 职业系统
   - 技能树
   - 物品组合
   - 随机掉落构建

## Output Fields

- Progression Type: [meta/run/hybrid/none]
- Permadeath Scope: [full/partial/checkpoint]
- Generation Type: [procedural/hybrid/fixed]
- Core Loop: [description]
- Resolution: [value]
- View: [type]
- Combat: [real-time/turn-based/hybrid/auto]
- Build System: [class/skill-tree/items/random]