---
name: design-review
description: Review game design documents, mechanics, systems, and player experience. Validates alignment with pillars and identifies potential issues.
license: MIT
---

# Design Review Skill

Review game design documents, mechanics, systems, and player experience for quality and alignment with project pillars.

## Workflow

### 1. Scope Definition

Ask what to review:
- `/design-review` — Review all design docs
- `/design-review combat.md` — Review specific document
- `/design-review --system combat` — Review specific system

### 2. Load Context

Before reviewing:
1. Read `design/gdd/game-concept.md` for pillars
2. Identify target player persona
3. Understand project scope constraints
4. Note any existing design decisions

### 3. Review Categories

#### Pillar Alignment

For each design element:
- [ ] Which pillar does this support?
- [ ] Does it conflict with any pillar?
- [ ] Is the pillar connection clear?

#### Player Experience

- [ ] Is the player fantasy clear?
- [ ] Is the core loop engaging?
- [ ] Are rewards meaningful?
- [ ] Is progression satisfying?
- [ ] Are there "juice" moments?

#### Mechanics Review

- [ ] Are rules clear and consistent?
- [ ] Are edge cases handled?
- [ ] Is the learning curve appropriate?
- [ ] Is there depth for mastery?
- [ ] Are there meaningful choices?

#### Balance Assessment

- [ ] Are options internally balanced?
- [ ] Are there dominant strategies?
- [ ] Is the difficulty curve appropriate?
- [ ] Are risk/reward ratios fair?

#### Player Psychology

- [ ] **Autonomy**: Do players have agency?
- [ ] **Competence**: Is there mastery?
- [ ] **Relatedness**: Connection opportunities?

#### Scope Reality

- [ ] Is this achievable within constraints?
- [ ] Are dependencies identified?
- [ ] Is there appropriate MVP scope?

### 4. Document Quality

For each design document:

```markdown
## [Document Name] Review

### Structure
- [ ] Clear overview/introduction
- [ ] Goals and pillars referenced
- [ ] Mechanics clearly defined
- [ ] Data/values specified
- [ ] Edge cases addressed
- [ ] Open questions tracked

### Clarity
- [ ] Can implementers understand it?
- [ ] Are ambiguous terms defined?
- [ ] Are examples provided?
- [ ] Is it testable?

### Completeness
- [ ] All sections filled?
- [ ] All referenced systems exist?
- [ ] All dependencies noted?
```

### 5. Categorize Findings

| Severity | Description | Action |
|----------|-------------|--------|
| 🔴 **Critical** | Pillar violation, game-breaking | Must address |
| 🟡 **Important** | UX issues, balance problems | Should address |
| 🟢 **Suggestion** | Enhancement opportunities | Consider |
| 💡 **Info** | Best practice notes | For awareness |

### 6. Generate Report

```markdown
# Design Review: [Topic/Document]

## Summary
[Overall assessment in 2-3 sentences]

## Pillar Alignment
| Element | Pillar | Alignment | Notes |
|---------|--------|-----------|-------|
| [Feature] | [Pillar] | ✅/⚠️/❌ | [Notes] |

## Critical Issues 🔴
### [Issue Title]
**Related To**: [Pillar/System]
**Problem**: [What's wrong]
**Impact**: [Player experience impact]
**Recommendation**: [How to fix]

## Important Issues 🟡
### [Issue Title]
**Related To**: [System]
**Problem**: [What's wrong]
**Recommendation**: [How to address]

## Suggestions 🟢
### [Suggestion Title]
**Area**: [System/Document]
**Idea**: [Improvement suggestion]

## Strengths ✅
- [What's working well]

## Questions
- [Clarifying question 1]
- [Clarifying question 2]

## Action Items
- [ ] [Item 1]
- [ ] [Item 2]
```

### 7. Follow-Up

Ask:
- "Want me to help revise any problematic areas?"
- "Should I create tasks for the action items?"
- "Need deeper analysis on any specific issue?"

## Review Frameworks

### MDA Analysis

For each system:

| Layer | Question | Finding |
|-------|----------|---------|
| **Mechanics** | What are the rules? | |
| **Dynamics** | What emerges? | |
| **Aesthetics** | What do players feel? | |

### Core Loop Evaluation

```
┌─────────────────┐
│  Action         │  ← Is it fun?
└────────┬────────┘
         ↓
┌─────────────────┐
│  Reward         │  ← Is it meaningful?
└────────┬────────┘
         ↓
┌─────────────────┐
│  Progression    │  ← Does it advance goals?
└────────┬────────┘
         ↓
    [Loop repeats]  ← Is it sustainable?
```

### Player Type Coverage

| Type | Served By | Assessment |
|------|-----------|------------|
| Achiever | | ✅/⚠️/❌ |
| Explorer | | ✅/⚠️/❌ |
| Socializer | | ✅/⚠️/❌ |
| Killer | | ✅/⚠️/❌ |

## Common Design Issues

| Issue | Signs | Fix |
|-------|-------|-----|
| Scope creep | Features not in pillars | Cut or defer |
| Dominant strategy | One best choice | Add trade-offs |
| Power creep | New > old content | Rebalance |
| Unclear feedback | Players confused | Add juice/UI |
| Empty choices | All options same | Differentiate |
| Punishing design | Players feel bad | Add mercy |

## Collaborative Protocol

1. **Reference pillars** — All feedback tied to vision
2. **Focus on player** — What do they experience?
3. **Be specific** — Concrete issues and solutions
4. **Acknowledge strengths** — Not just problems
5. **User decides** — Recommendations, not mandates