---
name: code-review
description: Review code quality, patterns, performance, and best practices. Provides structured feedback with actionable recommendations.
license: MIT
---

# Code Review Skill

审查代码质量、模式和最佳实践，提供可操作的建议。

---

## ⚠️ EXECUTION RULES

1. **SCOPE FIRST** — 先确定审查范围
2. **AUTOMATED FIRST** — 先运行自动检查
3. **PRIORITIZE** — 按严重程度分类问题
4. **BE CONSTRUCTIVE** — 提供修复方案

---

## Quick Actions

| 命令 | 行动 |
|------|------|
| `/code-review` | 审查最近更改 |
| `/code-review [path]` | 审查特定目录 |
| `/code-review [file]` | 审查特定文件 |

---

## Phase 1: Scope Definition

**ASK**:
```
审查范围：
A) 最近更改（git diff）
B) 特定目录: [path]
C) 特定文件: [file]
D) 整个src/目录
```

**STOP**: Wait for user's choice.

---

## Phase 2: Automated Checks

**TRY** these tools (skip if unavailable):

| 工具 | 命令 | 目的 |
|------|------|------|
| LSP Diagnostics | `lsp_diagnostics` | 类型错误、语法错误 |
| Git Diff | `git diff` | 查看更改 |

**IF tools unavailable**: Say "自动检查工具不可用，将进行手动审查"

**REPORT**:
```
自动检查结果：
━━━━━━━━━━━━━━━━━━━━━━
语法错误: [N]
类型警告: [N]
其他问题: [N]
━━━━━━━━━━━━━━━━━━━━━━
```

**STOP**: Show results, ask "要继续手动审查吗？"

---

## Phase 3: Manual Review

**READ**: Target files

**核心检查项** (精简版):

### 正确性
| 检查项 | 状态 |
|--------|------|
| 功能正确？ | ✅/⚠️/❌ |
| 边缘情况处理？ | ✅/⚠️/❌ |
| 空值安全？ | ✅/⚠️/❌ |

### 代码质量
| 检查项 | 状态 |
|--------|------|
| 命名规范？ | ✅/⚠️/❌ |
| 函数职责单一？ | ✅/⚠️/❌ |
| 无重复代码？ | ✅/⚠️/❌ |

### 性能
| 检查项 | 状态 |
|--------|------|
| 无不必要分配？ | ✅/⚠️/❌ |
| 不在_process做重活？ | ✅/⚠️/❌ |

### Godot特定 (GDScript)
| 检查项 | 状态 |
|--------|------|
| 静态类型使用？ | ✅/⚠️/❌ |
| @onready用于节点引用？ | ✅/⚠️/❌ |
| 信号使用恰当？ | ✅/⚠️/❌ |

**STOP**: Present findings, ask "要深入分析某个问题吗？"

---

## Phase 4: Categorize Findings

**SEVERITY LEVELS**:

| 级别 | 描述 | 示例 |
|------|------|------|
| 🔴 **阻塞** | Bug、崩溃、安全问题 | 空指针、资源泄漏 |
| 🟡 **重要** | 性能、可维护性 | 重复代码、缺少类型 |
| 🟢 **建议** | 风格、小改进 | 命名不一致 |
| 💡 **信息** | 教育性提示 | 最佳实践建议 |

---

## Phase 5: Generate Report

```markdown
# 代码审查: [File/Directory]

## 摘要
[1-2句话总体评价]

## 🔴 阻塞问题
### [问题标题]
- **文件**: [file:line]
- **问题**: [描述]
- **修复**: [如何修复]

## 🟡 重要问题
### [问题标题]
- **文件**: [file:line]
- **问题**: [描述]
- **修复**: [如何修复]

## 🟢 建议
- [文件:line] [改进建议]

## ✅ 亮点
- [做得好的地方]

## 统计
| 指标 | 值 |
|------|-----|
| 审查文件 | [N] |
| 审查行数 | [N] |
| 阻塞问题 | [N] |
| 重要问题 | [N] |
| 建议 | [N] |
```

**ASK**: "需要我帮助修复这些问题吗？"

**STOP**: Wait for user's response.

---

## Phase 6: Follow-Up

**IF user wants help fixing**:
- 针对具体问题提供修复代码
- **ASK**: "要应用这个修复吗？"

**IF user wants tasks**:
- 创建修复任务列表
- 可关联到sprint

**STOP**: Review complete.

---

## GDScript Quick Reference

### ✅ 正确模式

```gdscript
# 静态类型
var health: int = 100
func take_damage(amount: int) -> void:
    pass

# @onready 缓存
@onready var health_bar: ProgressBar = %HealthBar

# 类型化信号
signal health_changed(new_health: int, max_health: int)

# 禁用不需要的_process
func _ready():
    set_process(false)
```

### ❌ 常见反模式

| 反模式 | 问题 | 解决 |
|--------|------|------|
| God类 | 职责过多 | 拆分职责 |
| 深继承 | 难理解 | 使用组合 |
| $在循环中 | 性能差 | @onready缓存 |
| 无类型 | 无编译帮助 | 添加类型 |
| 魔法数字 | 含义不清 | 命名常量 |

---

## Error Handling

| Error | Fallback |
|-------|----------|
| LSP unavailable | Skip automated checks, manual review only |
| File not found | Ask user to provide correct path |
| Too many issues | Focus on blocking/important, offer to review rest later |
| User wants to quit | Summarize what was found so far |

---

## Quick Reference

| 检查类型 | 关键问题 |
|----------|----------|
| 正确性 | 它能工作吗？ |
| 质量 | 可读可维护吗？ |
| 性能 | 会拖慢游戏吗？ |
| Godot | 符合引擎最佳实践？ |

---

## What This Skill Must NOT Do

- ❌ 自动修改代码
- ❌ 删除测试来"通过"
- ❌ 使用 `as any` 抑制类型错误