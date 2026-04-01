# 快速入门

> 5 分钟开始使用 OpenCode Game Studios

---

## 第一次使用？

### 方式 1: 交互式引导

```
/start
```

系统会询问你的状态，然后推荐正确的下一步。

### 方式 2: 教程

跟着完整教程一步步完成你的第一个游戏：

👉 **[贪吃蛇实战教程](tutorials/snake-tutorial.md)**

---

## 最快上手路径

### 已经有游戏想法？

```
Step 1: /brainstorm "你的想法"
Step 2: /setup-engine
Step 3: /sprint-plan
```

### 从零开始？

```
Step 1: /start           → 让系统检测你的状态
Step 2: /brainstorm      → 探索游戏概念
Step 3: /setup-engine    → 配置引擎
Step 4: /sprint-plan     → 规划开发
```

### 已有项目？

```
/code-review     → 检查代码质量
/design-review   → 检查设计文档
/sprint-plan     → 开始规划
```

---

## 核心概念

### Skills 是什么？

Skills 是专业技能包，每个专注于特定领域：

| 分类 | Skills | 用途 |
|------|--------|------|
| 领导核心 | `start`, `producer`, `technical-director` | 管理和决策 |
| 执行支持 | `godot-specialist`, `sprint-plan` 等 | 日常开发 |
| 设计支持 | `brainstorm`, `game-designer` 等 | 创意工作 |
| 深度技术 | `godot-gdscript`, `code-review` 等 | 代码质量 |

### 如何调用？

```
/skill-name [参数]
```

例如：
```
/brainstorm "太空射击游戏"
/setup-engine godot 4.6.1
/sprint-plan review
```

---

## 典型工作流

### 周循环 (Team Lead)

```
周一: /sprint-plan review → 进度检查
周三: /art-coordinator → 美术同步  
周五: /producer → 周总结
```

### 新功能开发

```
/design-review → 验证设计
/art-coordinator → 请求美术
/prototype-mode → 快速验证
/technical-director → 架构检查
/godot-specialist → 实现
/code-review → 质量检查
```

---

## 常见问题

### Q: 我不知道问什么？

**A**: 就像和真人对话一样，告诉 OpenCode 你想做什么，它会引导你。

### Q: 如何知道有哪些 Skills？

**A**: 查看 [Skills 完整指南](SKILLS.md)

### Q: 代码有问题怎么办？

**A**: 使用 `/code-review` 或直接把错误信息发给 OpenCode。

### Q: 想添加新功能？

**A**: 
```
/game-designer [功能名] → 设计
/godot-specialist → 实现指导
```

---

## 下一步

- 📖 [Skills 完整指南](SKILLS.md) — 所有技能详解
- 📋 [工作流指南](WORKFLOW.md) — 典型流程
- 🎮 [贪吃蛇教程](tutorials/snake-tutorial.md) — 实战演练