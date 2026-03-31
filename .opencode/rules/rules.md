# Coding Rules

Path-scoped coding standards that are automatically enforced when editing specific directories.

## Rule Application

Rules are applied based on file location. When editing a file, the relevant rules are loaded to guide the implementation.

## Available Rules

### src/gameplay/** — Gameplay Code

Enforces:
- Data-driven values (export variables, resources)
- Delta time usage for all time-dependent logic
- No UI references in gameplay logic
- Signals for cross-component communication
- State machine pattern for stateful behavior

### src/core/** — Core Engine Systems

Enforces:
- Zero allocations in hot paths
- Thread safety for shared state
- API stability (no breaking changes without version bump)
- No scene-specific dependencies
- Comprehensive error handling

### src/ui/** — User Interface

Enforces:
- No game state ownership (read-only)
- Localization-ready strings
- Accessibility considerations
- Responsive layout patterns
- Signal-based updates

### src/systems/** — Game Systems

Enforces:
- Singleton/autoload pattern (document purpose)
- Clear public interface
- No circular dependencies
- Configuration via resources
- Graceful degradation

### tests/** — Test Code

Enforces:
- Test naming: `test_[function]_[scenario]_[expected]`
- Arrange-Act-Assert pattern
- Isolated test fixtures
- No external dependencies
- Clear failure messages

### prototypes/** — Prototype Code

Enforces:
- README required explaining purpose
- Hypothesis documented
- Relaxed code standards (speed over quality)
- Isolated from main codebase
- Mark for deletion or integration

## Rule Format

Each rule file follows this structure:

```markdown
# [Rule Name]

## Applies To
[Glob pattern for files]

## Enforced Standards

### [Category 1]
- [Rule 1]
- [Rule 2]

### [Category 2]
- [Rule 1]
- [Rule 2]

## Examples

### ✅ Good
[Code example]

### ❌ Bad
[Code example with explanation]

## Rationale
[Why these rules exist]
```