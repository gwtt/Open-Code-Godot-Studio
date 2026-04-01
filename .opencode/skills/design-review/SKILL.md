---
name: design-review
description: Review game design documents, mechanics, systems, and player experience. Validates alignment with pillars and identifies potential issues.
license: MIT
---

# Design Review Skill

审查游戏设计文档、机制和玩家体验，验证是否符合设计支柱。

---

## ⚠️ EXECUTION RULES

1. **SCOPE FIRST** — 先确定审查范围
2. **ONE AREA AT A TIME** — 一次审查一个领域
3. **PRIORITIZE FINDINGS** — 按严重程度分类
4. **BE CONSTRUCTIVE** — 提供解决方案，不只是批评

---

## Quick Actions

| 命令 | 行动 |
|------|------|
| `/design-review` | 审查所有设计文档 |
| `/design-review [file]` | 审查特定文件 |
| `/design-review --system [name]` | 审查特定系统 |

---

## Phase 1: Scope Definition

**ASK**:
```
你想审查什么？

A) 整体设计（游戏概念 + 支柱）
B) 特定文档（指定文件）
C) 特定系统（如：战斗、经济、进度）
D) 玩家体验评估
```

**STOP**: Wait for user's choice.

---

## Phase 2: Load Context

**READ**:
- `design/gdd/game-concept.md` → 游戏概念
- `design/gdd/pillars.md` (if exists) → 设计支柱
- Target file/system

**IF no pillars defined**:
- Extract pillars from game-concept.md
- **ASK**: "没有找到明确的支柱，要我根据游戏概念推断吗？"

**STOP**: Confirm context is correct.

---

## Phase 3: Review (by Area)

### A) 整体设计审查

**核心检查项** (精简版):

| 检查项 | 状态 | 备注 |
|--------|------|------|
| 设计支柱清晰？ | ✅/⚠️/❌ | |
| 核心循环有吸引力？ | ✅/⚠️/❌ | |
| 目标玩家明确？ | ✅/⚠️/❌ | |
| 范围现实可行？ | ✅/⚠️/❌ | |

### B) 文档审查

**检查项**:
| 检查项 | 状态 |
|--------|------|
| 结构完整？ | ✅/⚠️/❌ |
| 规则清晰？ | ✅/⚠️/❌ |
| 边缘情况处理？ | ✅/⚠️/❌ |
| 可测试？ | ✅/⚠️/❌ |

### C) 系统审查

**检查项**:
| 检查项 | 状态 |
|--------|------|
| 符合支柱？ | ✅/⚠️/❌ |
| 机制清晰？ | ✅/⚠️/❌ |
| 平衡合理？ | ✅/⚠️/❌ |
| 依赖识别？ | ✅/⚠️/❌ |

### D) 玩家体验

**检查项**:
| 检查项 | 状态 |
|--------|------|
| 玩家角色清晰？ | ✅/⚠️/❌ |
| 奖励有意义？ | ✅/⚠️/❌ |
| 进度令人满意？ | ✅/⚠️/❌ |
| 有"juice"时刻？ | ✅/⚠️/❌ |

**STOP**: Present findings, ask "要深入分析某个问题吗？"

---

## Phase 4: Categorize Findings

**SEVERITY LEVELS**:

| 级别 | 描述 | 行动 |
|------|------|------|
| 🔴 **关键** | 违反支柱、破坏游戏体验 | 必须修复 |
| 🟡 **重要** | UX问题、平衡问题 | 应该修复 |
| 🟢 **建议** | 改进机会 | 可考虑 |
| 💡 **信息** | 最佳实践提示 | 了解即可 |

---

## Phase 5: Generate Report

```markdown
# 设计审查报告: [Topic]

## 摘要
[2-3句话总结]

## 支柱对齐
| 元素 | 支柱 | 对齐 | 备注 |
|------|------|------|------|
| [功能] | [支柱] | ✅/⚠️/❌ | [备注] |

## 🔴 关键问题
### [问题标题]
- **相关**: [支柱/系统]
- **问题**: [描述]
- **影响**: [玩家体验影响]
- **建议**: [如何修复]

## 🟡 重要问题
### [问题标题]
- **问题**: [描述]
- **建议**: [如何处理]

## 🟢 建议
- [改进建议]

## ✅ 优点
- [做得好的地方]

## 行动项
- [ ] [行动1]
- [ ] [行动2]
```

**ASK**: "需要我帮助修改任何问题吗？"

**STOP**: Wait for user's response.

---

## Phase 6: Follow-Up

**IF user wants help**:
- 针对具体问题提供修改建议
- **ASK**: "要应用到文档吗？"

**IF user wants tasks**:
- 创建行动项列表
- 可关联到sprint

**STOP**: Review complete.

---

## Error Handling

| Error | Fallback |
|-------|----------|
| No design docs found | Say "没有找到设计文档，先运行 /brainstorm" |
| Pillars unclear | Extract from concept, ask for confirmation |
| User confused by frameworks | Skip framework, provide plain-language feedback |
| Too many issues | Prioritize top 3, offer to review rest later |

---

## Quick Reference

| 检查类型 | 关键问题 |
|----------|----------|
| 支柱对齐 | 这支持哪个支柱？ |
| 玩家体验 | 玩家感受如何？ |
| 机制清晰 | 规则易懂吗？ |
| 范围现实 | 能按时完成吗？ |

---

## What This Skill Must NOT Do

- ❌ 自动修改设计文档
- ❌ 做创意决策（那是 creative-director）
- ❌ 改变范围（那是 producer）