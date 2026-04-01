# Platformer Game Questionnaire

---

## Core Questions

1. **移动机制**: "角色如何移动？"
   - 基础跳跃
   - 双跳/墙跳
   - 特殊能力（冲刺、滑翔、钩爪）
   - 物理基础移动

2. **关卡设计**: "关卡如何设计？"
   - 线性关卡
   - 分支路径
   - 开放探索（Metroidvania）
   - 程序生成

3. **收集物**: "有什么收集元素？"
   - 无
   - 装饰性（成就/分数）
   - 功能性（解锁能力）
   - 剧情碎片

4. **敌人**: "敌人如何设计？"
   - 障碍型（静止陷阱）
   - 巡逻型（固定路径）
   - 追击型（跟踪玩家）
   - Boss战

## Technical Questions

5. **游戏分辨率**: "目标分辨率？"
   - 推荐: 1920x1080, 像素风格考虑 320x180 + 缩放

6. **物理**: "使用什么物理？"
   - Godot内置物理（CharacterBody2D）
   - 自定义物理（更精确控制）
   - 平台物理预设

7. **相机**: "相机如何跟随？"
   - 固定跟随
   - 平滑跟随（lerp）
   - 动态相机（前瞻、区域限制）
   - 多相机切换

8. **艺术风格**: "视觉风格是什么？"
   - 像素艺术
   - 矢量图
   - 手绘
   - 3D预渲染

## Output Fields

- Movement: [jump types]
- Level Type: [linear/branching/open/procedural]
- Collectibles: [none/cosmetic/functional/story]
- Enemies: [obstacle/patrol/chase/boss]
- Resolution: [value]
- Physics: [engine/custom/preset]
- Camera: [fixed/smooth/dynamic]
- Art Style: [pixel/vector/handdrawn/3d]