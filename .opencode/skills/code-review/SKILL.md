---
name: code-review
description: Review code quality, patterns, performance, and best practices. Provides structured feedback with actionable recommendations.
license: MIT
---

# Code Review Skill

Structured code review for quality, patterns, performance, and best practices.

## Workflow

### 1. Scope Definition

Ask what to review:
- `/code-review` — Review recent changes
- `/code-review src/player/` — Review specific directory
- `/code-review player.gd` — Review specific file

### 2. Automated Checks

Run checks before manual review:

- Static analysis / linting
- Type checking (GDScript warnings)
- Syntax errors
- Import/dependency issues

Report any automated issues found.

### 3. Manual Review

#### Correctness

- [ ] Does it do what it's supposed to?
- [ ] Are edge cases handled?
- [ ] Are there off-by-one errors?
- [ ] Is null/reference safety handled?

#### Code Quality

- [ ] Follows naming conventions?
- [ ] Functions are focused (single responsibility)?
- [ ] Code is readable and self-documenting?
- [ ] No duplicated code?
- [ ] Appropriate comments (why, not what)?

#### Architecture

- [ ] Fits existing patterns?
- [ ] No circular dependencies?
- [ ] Appropriate layer (core/system/gameplay/ui)?
- [ ] Interfaces well-defined?
- [ ] Coupling appropriate?

#### Performance

- [ ] No unnecessary allocations?
- [ ] Caches expensive operations?
- [ ] Uses appropriate data structures?
- [ ] Not doing heavy work in `_process()`?

#### Godot-Specific

- [ ] Static typing used throughout?
- [ ] `@onready` for node references?
- [ ] Signals used appropriately?
- [ ] No `$` in hot paths?
- [ ] Resources used for data?
- [ ] Scene structure clean?

#### Safety

- [ ] No null reference risks?
- [ ] Proper error handling?
- [ ] No memory leaks (`queue_free()` called)?
- [ ] Thread-safe if needed?

### 4. Categorize Findings

| Severity | Description | Action |
|----------|-------------|--------|
| 🔴 **Blocking** | Bugs, crashes, security issues | Must fix |
| 🟡 **Important** | Performance, maintainability | Should fix |
| 🟢 **Suggestion** | Style, minor improvements | Nice to have |
| 💡 **Info** | Educational notes | Consider |

### 5. Generate Report

```markdown
# Code Review: [File/Directory]

## Summary
[Overall assessment in 1-2 sentences]

## Blocking Issues 🔴
### [Issue Title]
**File**: [file:line]
**Problem**: [What's wrong]
**Fix**: [How to fix]

## Important Issues 🟡
### [Issue Title]
**File**: [file:line]
**Problem**: [What's wrong]
**Fix**: [How to fix]

## Suggestions 🟢
### [Issue Title]
**File**: [file:line]
**Suggestion**: [Improvement idea]

## Positive Notes ✅
- [What's done well]

## Metrics
| Metric | Value |
|--------|-------|
| Files Reviewed | [N] |
| Lines Reviewed | [N] |
| Blocking Issues | [N] |
| Important Issues | [N] |
| Suggestions | [N] |
```

### 6. Follow-Up

Ask:
- "Would you like me to help fix any of these issues?"
- "Should I create issues/tasks for tracking?"
- "Want a deeper dive on any specific area?"

## GDScript-Specific Checks

### Static Typing

```gdscript
# ❌ Bad
var health = 100
func take_damage(amount):
    pass

# ✅ Good
var health: int = 100
func take_damage(amount: int) -> void:
    pass
```

### Node References

```gdscript
# ❌ Bad
func _process(delta):
    $HealthBar.value = health

# ✅ Good
@onready var health_bar: ProgressBar = %HealthBar

func _process(delta):
    health_bar.value = health
```

### Signals

```gdscript
# ❌ Bad
signal health_changed  # No types

# ✅ Good
signal health_changed(new_health: int, max_health: int)
```

### Process Optimization

```gdscript
# ❌ Bad
func _process(delta):
    if some_rare_condition:
        do_expensive_thing()

# ✅ Good
func _ready():
    set_process(false)

func enable_processing():
    set_process(true)

func _process(delta):
    do_expensive_thing()
```

## Common Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| God classes | Too much in one file | Split responsibilities |
| Deep inheritance | Hard to understand/modify | Use composition |
| `$` in loops | Performance hit | Cache with `@onready` |
| Untyped code | No compiler help | Add types |
| Magic numbers | Unclear meaning | Named constants |
| Long functions | Hard to understand | Break into smaller |

## Collaborative Protocol

1. **Be constructive** — Focus on improvement, not criticism
2. **Explain why** — Help understand the reasoning
3. **Prioritize** — Not all issues are equal
4. **Offer solutions** — Don't just identify problems
5. **Acknowledge good work** — Positive reinforcement matters