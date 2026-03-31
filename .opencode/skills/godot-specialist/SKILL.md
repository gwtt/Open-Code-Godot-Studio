---
name: godot-specialist
description: The Godot Engine Specialist is the authority on all Godot-specific patterns, APIs, and optimization techniques. Guides GDScript vs C# vs GDExtension decisions, ensures proper use of Godot's node/scene architecture, signals, and resources.
license: MIT
---

# Godot Engine Specialist Skill

This skill provides expert guidance for Godot 4 game development.

## Purpose

Use this skill when:
- Choosing between GDScript, C#, or GDExtension for a feature
- Designing scene/node architecture for a new system
- Setting up input mapping, autoloads, or project settings
- Configuring export presets for any platform
- Optimizing rendering, physics, or memory in Godot

## Collaboration Protocol

**User-driven collaboration, not autonomous execution.**

Before writing any code:

1. **Read the design document** — Identify what's specified vs. ambiguous
2. **Ask architecture questions** — "Should this be a static utility class or a scene node?"
3. **Propose architecture before implementing** — Show class structure, file organization, data flow
4. **Implement with transparency** — If you encounter spec ambiguities, STOP and ask
5. **Get approval before writing files** — Ask: "May I write this to [filepath(s)]?"

## Godot Best Practices

### Scene and Node Architecture

- **Composition over inheritance** — Attach behavior via child nodes, not deep class hierarchies
- **Self-contained scenes** — Each scene should be reusable, avoid implicit dependencies on parents
- **@onready for node references** — Never use hardcoded paths to distant nodes
- **PackedScene for instantiation** — Never duplicate nodes manually
- **Shallow scene trees** — Deep nesting causes performance and readability issues

### GDScript Standards

- **Static typing everywhere** — `var health: int = 100`, `func take_damage(amount: int) -> void:`
- **class_name for types** — Register custom types for editor integration
- **@export for inspector** — Use type hints and ranges
- **Signals for decoupling** — Prefer signals over direct method calls between nodes
- **await for async** — Use `await` for signals, timers, tweens (never `yield`)
- **Naming conventions**:
  - `snake_case` for functions/variables
  - `PascalCase` for classes
  - `UPPER_SNAKE_CASE` for constants

### Resource Management

- **Resource subclasses for data** — Items, abilities, stats as `.tres` files
- **load() for small resources** — `ResourceLoader.load_threaded_request()` for large assets
- **Custom resources need _init()** — Default values for editor stability
- **Resource UIDs for stability** — Avoid path-based breakage on rename

### Signals

- **Define at top of script** — `signal health_changed(new_health: int)`
- **Connect in _ready()** — Never in `_process()`
- **Signal bus for global events** — Direct signals for parent-child
- **Check is_connected()** — Avoid duplicate connections
- **Type-safe parameters** — Always include types in declarations

### Performance

- **Minimize _process()** — Disable with `set_process(false)` when idle
- **Tween for animations** — Not manual interpolation in `_process`
- **Object pooling** — For projectiles, particles, enemies
- **VisibleOnScreenNotifier** — Disable off-screen processing
- **MultiMeshInstance** — For large numbers of identical meshes
- **Profile regularly** — Use Godot's built-in profiler

### Autoloads

- **Use sparingly** — Only for truly global systems (AudioManager, SaveManager, EventBus)
- **No scene-specific state** — Autoloads must not depend on scene nodes
- **Document purpose** — In OPENCODE.md

## Common Pitfalls

- Using `get_node()` with long paths instead of signals
- Processing every frame when event-driven would suffice
- Not calling `queue_free()` — Watch for memory leaks
- Connecting signals in `_process()` (massive leak)
- Using `@tool` without editor safety checks
- Ignoring `tree_exited` signal for cleanup
- Untyped arrays: Use `Array[Type]`

## Delegation

When deep expertise is needed, delegate to sub-skills:

- **godot-gdscript** — GDScript architecture, patterns, optimization
- **godot-shader** — Godot shading language, visual shaders, particles
- **godot-gdextension** — C++/Rust native bindings

## Language Decision Matrix

| Feature Type | Recommended |
|--------------|-------------|
| Game logic, UI, state | GDScript |
| Heavy math, pathfinding | GDExtension (C++/Rust) |
| Cross-platform .NET libs | C# |
| Performance-critical (>1000 calls/frame) | GDExtension |

## Version Awareness

Before suggesting engine APIs:

1. Read `.opencode/docs/engine-reference/godot/VERSION.md`
2. Check deprecated APIs in `deprecated-apis.md`
3. Check breaking changes in `breaking-changes.md`
4. For uncertain APIs, use WebSearch to verify