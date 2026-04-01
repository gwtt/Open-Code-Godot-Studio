---
name: sprint-plan
description: Plan development sprints with task breakdown, estimation, and scope management. Creates sprint documents for tracking progress.
license: MIT
---

# Sprint Planning Skill

创建和管理开发sprint计划。

---

## ⚠️ EXECUTION RULES

1. **ONE PHASE PER TURN** — 一次只执行一个阶段
2. **ASK BEFORE WRITING** — 写文件前必须获得批准
3. **USER PRIORITIZES** — 用户决定优先级，不是AI
4. **BE REALISTIC** — 不要过度承诺

---

## Quick Actions

| 命令 | 行动 |
|------|------|
| `/sprint-plan` | 创建新sprint |
| `/sprint-plan review` | 查看当前sprint |
| `/sprint-plan complete` | 完成当前sprint |

---

## Phase 1: Parse Command & Detect State

**CHECK**:
- 游戏概念存在? → `design/gdd/game-concept.md`
- 当前sprint? → `production/sprints/` 最新文件
- 里程碑? → `production/milestones/`

**REPORT**:
```
Sprint 状态检查
━━━━━━━━━━━━━━━━━━━━━━
游戏概念: [有/无]
当前Sprint: [Sprint N / 无]
里程碑: [名称 / 无]
━━━━━━━━━━━━━━━━━━━━━━
```

**IF no game concept**: 
- **SAY**: "还没有游戏概念，建议先运行 `/brainstorm`"
- **STOP**: Ask if user wants to continue anyway

**IF `/sprint-plan review`**: Jump to Phase 7
**IF `/sprint-plan complete`**: Jump to Phase 8
**IF `/sprint-plan` (new)**: Continue to Phase 2

**STOP**: Confirm user wants to create new sprint.

---

## Phase 2: Sprint Duration

**ASK**:
```
Sprint 持续时间:
A) 1周 (推荐给单人)
B) 2周 (推荐给团队)

开始日期: [默认下周一]
```

**STOP**: Wait for user's choice.

---

## Phase 3: Capacity Planning

**ASK**:
```
团队结构:
A) 单人 (只有我)
B) 2人 (程序 + 美术)
C) 3人 (程序 + 美术 + 其他)

可用时间: [小时/天]
已知的假期/休息: [日期]
```

**FOR团队有美术**:
```
美术容量规划:
- 美术可用时间: [小时/周]
- 主要工作: Sprite / UI / 动画 / 音效
```

**计算容量**:
```
程序容量: [X] story points
美术容量: [Y] 小时 (或美术points)
总容量: [程序] points + [美术] 小时
```

**STOP**: Wait for user confirmation or adjustment.

---

## Phase 4: Backlog Review

**READ**: 任何backlog或待办事项

**IF no backlog**:
- **ASK**: "你在这个sprint想完成什么？" (列出3-5个目标)

**IF has backlog**:
- **PRESENT**: 待办事项列表
- **ASK**: "选择这个sprint要做的任务"

**STOP**: Wait for user's selection.

---

## Phase 5: Task Breakdown & Estimation

### 程序任务

**FOR EACH selected task**:

```markdown
## [Task Name]
**类型**: 程序
**估计**: [1/2/3/5/8] points
**依赖**: [无/列出]
**验收标准**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
```

### 美术任务 (如适用)

**FOR EACH art task**:

```markdown
## [Asset Name]
**类型**: Sprite / UI / Animation / Audio
**规格**: [尺寸/时长]
**估计**: [X] 小时
**负责人**: [Artist Name]
**依赖**: [程序任务/无]
**截止**: [Date]
```

**美术估算参考**:

| 资产类型 | 简单 | 中等 | 复杂 |
|----------|------|------|------|
| Sprite (角色) | 2h | 4h | 8h+ |
| Sprite (道具) | 1h | 2h | 4h |
| UI元素 | 0.5h | 1h | 2h |
| 背景图 | 2h | 4h | 8h+ |
| 动画帧 | 1h/帧 | 2h/帧 | 4h/帧 |
| 音效 | 0.5h | 1h | 2h |
| 音乐 | 2h | 4h | 8h+ |

### 总量检查

**SHOW**: 估计总和 vs 容量

| 指标 | 程序 | 美术 |
|------|------|------|
| 容量 | [X] points | [Y] 小时 |
| 计划工作 | [A] points | [B] 小时 |
| Buffer (20%) | [Z] points | [C] 小时 |
| **剩余** | [W] points | [D] 小时 |

**IF over capacity**:
- **ASK**: "超过容量。要削减哪些任务？"

**STOP**: Wait for user's final selection.

---

## Phase 6: Create Sprint Document

**PRESENT** the document for approval:

```markdown
# Sprint [N]: [Sprint Goal]

## 日期
- **开始**: [Date]
- **结束**: [Date]

## Sprint 目标
[一句话描述这个sprint要达成什么]

## 容量
- **团队**: [Names]
- **容量**: [points]

## 承诺工作

### Must Have
| 任务 | 估计 | 负责人 | 状态 |
|------|------|--------|------|
| [Task] | [pts] | [Name] | [ ] |

### Should Have
| 任务 | 估计 | 负责人 | 状态 |
|------|------|--------|------|
| [Task] | [pts] | [Name] | [ ] |

## 风险
| 风险 | 缓解措施 |
|------|----------|
| [Risk] | [Action] |

## 依赖
- [Dependency 1]

---
## 每日更新
### [Date]
- 完成: [...]
- 进行中: [...]
- 阻塞: [...]
```

**ASK**: "我可以保存到 `production/sprints/sprint-[N]-[date].md` 吗？"

**STOP**: Wait for explicit approval.

**IF approved**: Write file, confirm creation.
**IF changes needed**: Modify, re-present.

---

## Phase 7: Sprint Review (for `/sprint-plan review`)

**READ**: 当前sprint文件

**REPORT**:
```markdown
# Sprint [N] 进度

## 完成率: [X]%

## 已完成 ✅
- [Task 1]
- [Task 2]

## 进行中 🔄
- [Task] - [状态]

## 阻塞 🚫
- [Task] - [原因]

## 建议
- [建议]
```

**ASK**: "需要详细分析某个任务吗？"

**STOP**: Wait for user follow-up.

---

## Phase 8: Sprint Complete (for `/sprint-plan complete`)

**GENERATE** retrospective:

```markdown
# Sprint [N] 回顾

## 指标
- 计划: [X] points
- 完成: [Y] points
- 完成率: [Z]%

## 做得好的
- [What went well]

## 需要改进
- [What to improve]

## 下个Sprint行动
- [ ] [Action 1]
- [ ] [Action 2]

## 未完成工作
- [Carry over to next sprint]
```

**ASK**: "要归档这个sprint吗？"

**STOP**: Wait for user approval.

---

## Estimation Guide

| Points | 复杂度 | 示例 |
|--------|--------|------|
| 1 | 简单 | 改文案、改配置 |
| 2 | 小 | 加UI元素、小修复 |
| 3 | 中等 | 新小功能 |
| 5 | 复杂 | 新系统(中等) |
| 8 | 大 | 大功能、重构 |
| 13 | Epic | 需要拆分 |

---

## Error Handling

| Error | Fallback |
|-------|----------|
| No game concept | Warn user, ask to continue or run /brainstorm |
| No directory | Create `production/sprints/` automatically |
| User cancels | Abort gracefully, no files written |
| Estimation unclear | Use default 3 points, flag for review |

---

## Quick Reference

| Phase | Action | Approval? |
|-------|--------|-----------|
| 1 | Detect state | No |
| 2 | Duration | Yes |
| 3 | Capacity | Yes |
| 4 | Backlog review | Yes |
| 5 | Task breakdown | Yes |
| 6 | Create document | Yes (critical) |
| 7 | Review | No |
| 8 | Complete | Yes |