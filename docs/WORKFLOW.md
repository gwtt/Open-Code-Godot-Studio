# 工作流指南

> 典型开发工作流程和最佳实践

---

## Team Lead 周循环

推荐 2-3 人小队的每周工作节奏：

```
周一: /sprint-plan review → 进度检查
周三: /art-coordinator → 美术同步  
周五: /producer → 周总结
```

### 周一：进度检查

```
你: /sprint-plan review

OpenCode: 
Sprint 1 进度报告
━━━━━━━━━━━━━━━━━━━━━━
完成率: 60%
已完成: 蛇移动系统、食物生成
进行中: 碰撞检测
阻塞: 无
━━━━━━━━━━━━━━━━━━━━━━
```

### 周三：美术同步

```
你: /art-coordinator

OpenCode:
你想做什么？
A) 创建资产请求
B) 检查命名规范
C) 同步进度
```

### 周五：周总结

```
你: /producer 周总结

OpenCode:
本周完成: X, Y, Z
下周计划: A, B, C
风险: [风险评估]
```

---

## 新功能开发流程

完整的新功能开发链：

```
/design-review → 验证设计
    ↓
/art-coordinator → 请求美术资产 (如有)
    ↓
/prototype-mode → 快速验证 (可选)
    ↓
/technical-director → 架构检查
    ↓
/godot-specialist → 实现指导
    ↓
/code-review → 质量检查
```

### 示例：开发新敌人类型

**Step 1: 设计验证**
```
你: /design-review enemies.md

OpenCode: 
审查敌人系统设计...
支柱对齐: ✅ 支持"挑战性"支柱
建议: 考虑敌人类型平衡
```

**Step 2: 美术请求**
```
你: /art-coordinator 创建资产请求

OpenCode:
资产类型? Sprite
规格: 32x32 pixels
数量: 3种敌人变体
```

**Step 3: 原型验证 (可选)**
```
你: /prototype-mode 验证敌人AI是否有趣

OpenCode:
最小范围:
- 敌人跟踪玩家
- 简单碰撞
时间: 1小时
```

**Step 4: 架构检查**
```
你: /technical-director 敌人系统架构

OpenCode:
建议:
- 使用状态机管理敌人状态
- 信号解耦敌人与玩家
```

**Step 5: 实现指导**
```
你: /godot-specialist 敌人跟踪AI

OpenCode:
推荐方案:
- 使用 NavigationAgent2D
- 信号: enemy_detected, enemy_attacked
```

**Step 6: 代码审查**
```
你: /code-review enemy.gd

OpenCode:
🟡 重要问题: 缺少类型标注
🟢 建议: 添加状态注释
```

---

## 新项目启动流程

从零开始的项目初始化：

```
/start → 检测团队状态
    ↓
/brainstorm → 游戏概念
    ↓
/setup-engine → 引擎配置
    ↓
/sprint-plan → Sprint 1 规划
    ↓
[开发工作...]
```

### Step 1: 入口

```
你: /start

OpenCode:
团队结构?
A) 单人
B) 2人
C) 3人
```

### Step 2: 概念

```
你: /brainstorm "太空射击游戏"

OpenCode:
最让你兴奋的是什么？
[你的回答]
...
[生成游戏概念文档]
```

### Step 3: 配置

```
你: /setup-engine godot 4.6.1

OpenCode:
✅ 引擎配置完成
✅ 目录结构创建
```

### Step 4: 规划

```
你: /sprint-plan

OpenCode:
任务列表...
容量检查...
[Sprint 文档创建]
```

---

## 美术协调流程

与美术队友协作的工作流：

```
/art-coordinator → 创建资产请求
    ↓
[美术制作]
    ↓
/art-coordinator → 检查命名 + 导入设置
    ↓
[程序使用]
    ↓
/art-coordinator → 同步进度
```

### 创建请求

```
你: /art-coordinator 创建资产请求

OpenCode:
资产类型?
A) Sprite
B) UI
C) Audio
D) Animation
```

### 检查命名

```
你: /art-coordinator 检查命名规范

OpenCode:
命名检查报告
━━━━━━━━━━━━━━━━━━━━━━
✅ char_player.png
⚠️ player idle.png → 应为 char_player_idle.png
━━━━━━━━━━━━━━━━━━━━━━
```

### 同步进度

```
你: /art-coordinator 同步进度

OpenCode:
美术同步报告
━━━━━━━━━━━━━━━━━━━━━━
已完成: 5
进行中: 2
待请求: 3
━━━━━━━━━━━━━━━━━━━━━━
```

---

## 技术决策流程

需要做技术决策时：

```
/technical-director → 创建 ADR
    ↓
[讨论和决策]
    ↓
/technical-director → 记录决策
```

### 创建 ADR

```
你: /technical-director 创建ADR: 使用哪种状态机

OpenCode:
问题: 角色状态管理方案
选项:
A) Enum + Match
B) State Machine Node
C) 第三方插件
权衡分析...
```

---

## 代码质量流程

确保代码质量的流程：

```
[编码前]
/godot-gdscript → 了解模式
    ↓
[编码中]
/godot-specialist → 遇到问题咨询
    ↓
[编码后]
/code-review → 质量检查
```

---

## 常见场景速查

| 场景 | 用什么 Skill |
|------|-------------|
| 不知道从哪开始 | `/start` |
| 想个游戏概念 | `/brainstorm` |
| 配置项目 | `/setup-engine` |
| 规划工作 | `/sprint-plan` |
| 查看进度 | `/producer` |
| 技术问题 | `/godot-specialist` |
| 请求美术 | `/art-coordinator` |
| 快速验证 | `/prototype-mode` |
| 代码审查 | `/code-review` |
| 设计审查 | `/design-review` |
| 技术决策 | `/technical-director` |

---

## 相关文档

- [Skills 完整指南](SKILLS.md)
- [快速入门](QUICK-START.md)
- [教程](tutorials/)