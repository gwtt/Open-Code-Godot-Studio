---
name: start
description: First-time onboarding — asks where you are, then guides you to the right workflow. No assumptions.
license: MIT
---

# Guided Onboarding Skill

Entry point for new users. Detects project state and team structure, routes to the right skill.

---

## ⚠️ EXECUTION RULES

1. **ONE PHASE PER TURN** — Execute only one phase, then STOP and wait
2. **NEVER SKIP AHEAD** — Do not proceed to next phase without user response
3. **IF TOOL FAILS** — Skip that check and continue with available info
4. **ALWAYS END WITH A QUESTION** — Never end a turn without asking user something

---

## Phase 1: Detect State (Silent)

**ACTION**: Try to read these files (skip if not found):
- `.opencode/project-context.md` → **Team & project info already collected?**
- `.opencode/docs/technical-preferences.md` → Engine configured?
- `design/gdd/game-concept.md` → Game concept exists?
- Check `src/` directory → Source code exists?

**IF `project-context.md` EXISTS**:
- Read team structure and project stage from it
- Skip Phase 2 and Phase 3 (already answered)
- Jump directly to Phase 4 with stored values

**STOP**: After detection, proceed to Phase 2 (if config missing) or Phase 4 (if config exists).

---

## Phase 2: Team Structure Detection

**IF config already has team structure**:
- Skip this phase, use stored value

**ELSE, ASK**:
```
你的团队结构是什么？

A) 单人独立开发 — 只有我一个
B) 2人小队 — 我+队友（程序/美术/策划）
C) 3人小队 — 我作为队长，有队友支持
D) 更大团队 — 4人及以上
```

**AFTER user answers**:
1. **WRITE to `.opencode/project-context.md`**:
   ```markdown
   ## Team Structure
   - **Type**: [用户选择的选项]
   - **My Role**: [如果是B/C，询问队长角色]
   ```
2. **STOP**: Wait for user's answer before writing.

---

## Phase 3: Project Stage Check

**IF config already has project stage**:
- Skip this phase, use stored value

**ELSE, ASK**:
```
你目前处于哪个阶段？

A) 还没有想法 — 我想从头探索游戏概念
B) 有模糊想法 — 我有个大致的主题或类型
C) 概念已清晰 — 我知道核心玩法，但还没文档化
D) 已有工作成果 — 我已经有设计文档、原型或代码
```

**AFTER user answers**:
1. **APPEND to `.opencode/project-context.md`**:
   ```markdown
   ## Project Stage
   - **Current Stage**: [用户选择的选项]
   - **Last Updated**: [当前日期]
   ```
2. **STOP**: Wait for user's answer before writing.

---

## Phase 4: Route Based on Team + Stage

### Single Developer (单人)

| Stage | Recommend | Next Steps |
|-------|-----------|------------|
| 没有想法 | `/brainstorm` | 探索概念 |
| 模糊想法 | `/brainstorm "idea"` | 发展想法 |
| 概念清晰 | `/setup-engine` → `/sprint-plan` | 开始开发 |
| 已有成果 | `/code-review` 或 `/design-review` | 检查质量 |

### 2-3 Person Team (小队队长)

| Stage | Recommend | Additional Skills |
|-------|-----------|-------------------|
| 没有想法 | `/brainstorm` | 团队讨论概念 |
| 模糊想法 | `/brainstorm` → `/game-designer` | 定义系统 |
| 概念清晰 | `/setup-engine` → `/art-coordinator` | 美术协调 |
| 已有成果 | `/producer` → `/sprint-plan` | 团队进度 |

### Team Lead Tools

**如果用户选择了B或C（小队）**:
```
作为小队队长，你可以使用：
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
管理:     /producer, /sprint-plan
技术:     /godot-specialist, /code-review
设计:     /design-review, /game-designer
美术协调: /art-coordinator (NEW!)
原型:     /prototype-mode (NEW!)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 5: Hand Off

Once user confirms their next action:

**TELL USER**:
```
✅ 项目信息已保存到 `.opencode/project-context.md`
下次会话将自动读取，无需重复回答。
```

**For single developer**:
- Suggest the primary skill and let them invoke it

**For team lead (2-3 people)**:
- Suggest primary skill + mention team-specific tools
- **IF有美术队友**: 特别推荐 `/art-coordinator`
- **IF需要快速验证**: 推荐 `/prototype-mode`

**DO NOT invoke other skills automatically.** Let the user invoke them.

---

## Team Lead Workflow

### Weekly Cycle (推荐)

```
周一: /sprint-plan review → 检查进度
周三: /art-coordinator → 美术同步  
周五: /producer → 周总结
```

### New Feature Flow

```
/design-review → 验证设计
    ↓
/art-coordinator → 请求美术资产
    ↓
/godot-specialist → 技术实现
    ↓
/code-review → 质量检查
```

---

## Error Handling

| Error | Fallback |
|-------|----------|
| Cannot read files | Assume project is empty, proceed to Phase 2 |
| `project-context.md` incomplete | Ask only missing sections, preserve existing |
| User gives unclear answer | Ask clarifying question, do NOT guess |
| User wants to skip onboarding | Say "好的，你可以随时使用 `/help` 查看可用命令" and stop |

---

## Persistent Config File

**Location**: `.opencode/project-context.md`

**Purpose**: Store team structure, project stage, platform info to avoid re-asking on new sessions.

**Created by**: `/start` skill (Phase 2 & 3)

**Updated by**: `/setup-engine` (engine info), `/brainstorm` (vision), other skills

**Template**: `.opencode/docs/templates/project-context-template.md`

---

## Quick Reference

### 单人开发者

| 状态 | 首选 Skill |
|------|------------|
| 没想法 | `/brainstorm` |
| 有想法 | `/brainstorm "idea"` |
| 概念清晰 | `/setup-engine` |
| 已有代码 | `/code-review` |

### 小队队长 (2-3人)

| 状态 | 首选 Skill | 额外工具 |
|------|------------|----------|
| 没想法 | `/brainstorm` | 团队讨论 |
| 概念清晰 | `/setup-engine` | `/art-coordinator` |
| 已有成果 | `/producer` | `/sprint-plan` |
| 需美术 | `/art-coordinator` | 资产请求模板 |
| 快速验证 | `/prototype-mode` | 一次性代码模式 |