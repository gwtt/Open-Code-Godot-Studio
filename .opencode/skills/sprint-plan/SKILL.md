---
name: sprint-plan
description: Plan development sprints with task breakdown, estimation, and scope management. Creates sprint documents for tracking progress.
license: MIT
---

# Sprint Planning Skill

Plan and organize development sprints with task breakdown, estimation, and progress tracking.

## Workflow

### 1. Parse Arguments

- `/sprint-plan` — Create new sprint
- `/sprint-plan review` — Review current sprint
- `/sprint-plan complete` — Mark sprint complete

### 2. Create New Sprint

#### Gather Context

1. Read `design/gdd/game-concept.md` for project goals
2. Check `production/milestones/` for current milestone
3. Review any existing `production/backlog.md`
4. Identify current blockers or dependencies

#### Sprint Duration

Ask or default to:
- **Duration**: 1-2 weeks (recommend 1 week for solo, 2 weeks for teams)
- **Start date**: [Default to next Monday]
- **End date**: [Calculated from duration]

#### Capacity Planning

Ask:
- Who's available?
- Any planned time off?
- Any external commitments?

Calculate velocity based on historical data if available, otherwise estimate.

### 3. Backlog Review

Review pending work:

1. **From Milestone** — What milestone goals need work?
2. **From Backlog** — What's prioritized?
3. **From Blockers** — What needs to be unblocked?
4. **Technical Debt** — Any critical debt to address?

Present options to user for prioritization.

### 4. Task Breakdown

For each committed feature:

1. Break into smallest tasks
2. Identify dependencies
3. Estimate each task (story points or hours)
4. Assign owner (if team)

#### Task Template

```markdown
## [Task Name]

**Priority**: High / Medium / Low
**Estimate**: [points or hours]
**Dependencies**: [List or "None"]
**Owner**: [Name or "Unassigned"]

**Acceptance Criteria**:
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Notes**:
[Any additional context]
```

### 5. Sprint Scope

Calculate total estimated work vs capacity:

| Metric | Value |
|--------|-------|
| Team Capacity | [velocity] points |
| Planned Work | [total estimate] points |
| Buffer (20%) | [points] |
| **Remaining** | [points] |

If over capacity:
1. Identify scope reduction options
2. Present options to user
3. User decides what to defer

### 6. Create Sprint Document

Create `production/sprints/sprint-[N]-[date].md`:

```markdown
# Sprint [N]: [Sprint Goal]

## Dates
- **Start**: [Date]
- **End**: [Date]

## Sprint Goal
[One sentence describing what we're trying to achieve]

## Capacity
- **Team**: [Names]
- **Velocity**: [points]
- **Available**: [points after buffer]

## Committed Work

### Must Have
| Task | Estimate | Owner | Status |
|------|----------|-------|--------|
| [Task] | [pts] | [Name] | [ ] |

### Should Have
| Task | Estimate | Owner | Status |
|------|----------|-------|--------|
| [Task] | [pts] | [Name] | [ ] |

### Nice to Have
| Task | Estimate | Owner | Status |
|------|----------|-------|--------|
| [Task] | [pts] | [Name] | [ ] |

## Risks
| Risk | Mitigation |
|------|------------|
| [Risk] | [Action] |

## Dependencies
- [Dependency 1]
- [Dependency 2]

## Notes
[Any relevant context]

---

## Daily Updates
### [Date]
- Completed: [...]
- In Progress: [...]
- Blockers: [...]

### [Date]
- Completed: [...]
- In Progress: [...]
- Blockers: [...]
```

### 7. Sprint Review

At sprint end:

1. **Demo** — Show what was completed
2. **Metrics**:
   - Planned vs Completed points
   - Scope changes
   - Blockers encountered
3. **Retrospective**:
   - What went well?
   - What could improve?
   - Actions for next sprint

### 8. Output

```
Sprint [N] Created
==================
Goal:            [Sprint Goal]
Duration:        [Start] to [End]
Capacity:        [points] available
Committed:       [points] planned

Must Have:       [N] tasks
Should Have:     [N] tasks
Nice to Have:    [N] tasks

Document:        production/sprints/sprint-[N]-[date].md

Next Steps:
1. Start sprint on [date]
2. Daily standups (if team)
3. Review at sprint end
```

## Estimation Guide

| Points | Complexity | Examples |
|--------|------------|----------|
| 1 | Trivial | Fix typo, rename, simple config |
| 2 | Simple | Add UI element, small fix |
| 3 | Moderate | New small feature, refactor |
| 5 | Complex | New medium feature, system |
| 8 | Large | Major feature, significant refactor |
| 13 | Epic | Break into smaller tasks |

## Risk Categories

| Risk | Signs | Mitigation |
|------|-------|------------|
| Scope creep | New features appearing | Strict change process |
| Underestimation | Tasks taking longer | Add buffer, re-estimate |
| Dependencies | Blocked tasks | Identify early, alternatives |
| Technical debt | Slow velocity | Allocate 20% to debt |

## Collaborative Protocol

1. **User prioritizes** — Present options, user chooses
2. **Be realistic** — Don't overcommit
3. **Track accurately** — Update as work progresses
4. **Learn from velocity** — Improve estimation over time