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
- **godot-csharp** — C# patterns, .NET integration, async/await
- **godot-shader** — Godot shading language, visual shaders, particles
- **godot-gdextension** — C++/Rust native bindings

## Language Decision Matrix

| Feature Type | GDScript | C# | GDExtension |
|--------------|----------|-----|--------------|
| Game logic | ✅ Best | ✅ Good | ⚠️ Overkill |
| UI | ✅ Best | ✅ Good | ❌ |
| Rapid prototyping | ✅ Best | ✅ Good | ❌ |
| .NET libraries | ❌ | ✅ Best | ⚠️ |
| Heavy math (pathfinding) | ⚠️ | ✅ Good | ✅ Best |
| Performance-critical | ⚠️ | ✅ Good | ✅ Best |
| Multi-threading | ⚠️ | ✅ Best | ✅ Best |
| Existing C# experience | ⚠️ | ✅ Best | ⚠️ |

### Language Selection Guide

**Choose GDScript if:**
- Rapid prototyping and iteration
- Learning Godot for the first time
- Small to medium project
- Prefer lightweight syntax

**Choose C# if:**
- Need .NET ecosystem (JSON, HTTP, etc.)
- Existing C# experience
- Complex data processing
- Multi-threading requirements
- Large codebase

**Choose GDExtension if:**
- Performance-critical (>1000 calls/frame)
- Need native code integration
- Heavy math computations

## MCP Tool Integration

### Available MCP Tools (suggest to user when appropriate)

| MCP Server | Use Case | Suggest When |
|------------|----------|--------------|
| **Godot MCP** | Run Godot headless, test scenes, debug | After scene creation, testing needed |
| **Image Gen MCP** | Generate textures, icons, sprites | Asset placeholders needed |
| **Blender MCP** | Export models, animations | 3D assets needed |

### Suggestion Pattern

When appropriate, include in response:

```
💡 Tip: You can use the Godot MCP server to:
- Run this scene headlessly: `godot_run_scene("res://scenes/player.tscn")`
- Check for errors: `godot_check_project()`

For assets, the Image Gen MCP can generate placeholder sprites.
```

### When to Suggest

- After creating a scene file → suggest Godot MCP testing
- When UI needs icons → suggest Image Gen MCP
- When 3D models needed → suggest Blender MCP

## Scene Assembly Protocol (NEW - replaces tscn generation)

### ⚠️ NEVER generate .tscn files directly

LLM-generated scene files are prone to:
- Invalid node paths
- Wrong resource UID references
- Property type mismatches

### Instead: Provide Assembly Guide

**After generating script, output:**

```markdown
## Scene Assembly Instructions

### Node Tree
```
[RootNode] (type)
├── [Child1] (type) — purpose
├── [Child2] (type) — purpose
│   └── [SubChild] (type) — purpose
└── [Child3] (type) — purpose
```

### Required Components
| Node | Required Properties | Scripts |
|------|--------------------|---------|
| Player | position: (100, 200) | player_controller.gd |
| HealthBar | value: 100, min: 0, max: 100 | health_bar.gd |

### Assembly Steps
1. Create root node: Add Node → [NodeType]
2. Attach script: Drag `player_controller.gd` to Player node
3. Add child HealthBar: Add Node → ProgressBar → set properties
4. Enable Unique Names: Right-click → Access as Unique Name (%HealthBar)

### 💡 Tip: Use Godot MCP to test after assembly
```

**ASK**: "I've created the scripts. Follow the assembly guide in Godot editor. Need help?"

## Completion Recommendations (NEW)

### After Implementation Complete

**Step 1: Quick LSP Check**

**TRY**: `lsp_diagnostics` on modified files

**IF errors found**:
```
⚠️ LSP detected [N] issues. Fix before review.
Run `/code-review` after fixing.
```

**Step 2: Suggest Next Skills**

Based on what was implemented:

| Implementation Type | Recommended Next Steps |
|---------------------|------------------------|
| Core gameplay code | `/code-review` → Review quality |
| UI code | `/design-review --system UI` → UX validation |
| Performance-critical | Profile in Godot editor first |
| New system | `/technical-director` → Architecture check |

**ASK**: "Would you like to run `/code-review` on these changes?"

## Version Awareness

Before suggesting engine APIs:

1. Read `.opencode/docs/engine-reference/godot/VERSION.md`
2. Check deprecated APIs in `deprecated-apis.md`
3. Check breaking changes in `breaking-changes.md`
4. For uncertain APIs, use WebSearch to verify