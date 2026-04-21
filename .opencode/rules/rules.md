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

### ALL src/** — Scene-Defined Structural Nodes (场景定义结构性节点)

Enforces:
1. Structural child nodes MUST be in .tscn, NOT created in `_ready()` via code
2. Structural nodes definition: CollisionShape2D/3D, Sprite2D/3D, Camera2D/3D, AnimationPlayer, AudioStreamPlayer, Timer, MeshInstance3D, Light2D/3D, Area2D/3D — any permanent scene architecture node
3. NO `add_child()` for structural/permanent nodes in `_ready()` or `_init()`
4. NO `.new()` for node types that belong in the scene tree permanently
5. YES `@onready` / `[Export]` for referencing scene-defined nodes
6. YES `PackedScene.Instantiate()` for dynamic runtime entities (enemies, bullets, pickups)
7. Use MCP tools (godot_create_scene, godot_add_node, godot_save_scene) when MCP is available to build scenes
8. When MCP unavailable, provide .tscn file content for manual creation

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