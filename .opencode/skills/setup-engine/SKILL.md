---
name: setup-engine
description: Configure the project's game engine and version. Pins the engine in OPENCODE.md, creates reference docs, and sets up technical preferences for Godot.
license: MIT
---

# Setup Engine Skill

Configure Godot engine settings, project structure, and technical preferences.

---

## ⚠️ EXECUTION RULES

1. **ONE PHASE PER TURN** — Execute only one phase, then STOP
2. **ASK BEFORE WRITING** — Never create files without approval
3. **IF TOOL FAILS** — Use fallback values, don't abort
4. **SHOW CHANGES** — Always show what will be created before writing

---

## Phase 1: Parse Arguments & Detect State

**CHECK**:
- Argument provided? (`/setup-engine godot 4.6.1`)
- Existing config? Try read `.opencode/docs/technical-preferences.md`
- Game concept? Try read `design/gdd/game-concept.md`

**IF version specified**: Jump to Phase 3
**IF no version**: Proceed to Phase 2

**STOP**: Show detected state, ask "你想配置哪个Godot版本？" if not specified.

---

## Phase 2: Engine & Version Selection

### Engine Recommendation (if needed)

| Project Type | Recommended |
|--------------|-------------|
| 2D game | Godot 4 |
| 2D/3D mix | Godot 4 |
| Solo/small team | Godot 4 |

### Version Selection

**TRY** WebSearch for latest Godot 4 stable version.
**IF WebSearch FAILS**: Use default "4.6.1" (safe fallback)

**ASK**: "最新稳定版是 Godot [version]。使用这个版本？(Y/n)"

**STOP**: Wait for user confirmation.

---

## Phase 3: Show Changes Preview

Present EXACTLY what will be created/modified:

```
将要创建/修改的文件：
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. OPENCODE.md
   - 更新 Technology Stack 部分
   
2. .opencode/docs/technical-preferences.md
   - 创建编码规范和性能预算
   
3. .opencode/docs/engine-reference/godot/VERSION.md
   - 创建版本引用文档
   
4. 项目目录结构：
   src/    assets/    design/    tests/    prototypes/    production/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**ASK**: "确认创建这些文件？(Y/n)"

**STOP**: Wait for user approval.

---

## Phase 4: Update OPENCODE.md

**READ** current OPENCODE.md first.

**UPDATE** the Technology Stack section:

```markdown
## Technology Stack

- **Engine**: Godot [version]
- **Language**: GDScript (primary), C++ via GDExtension (performance-critical)
- **Version Control**: Git with trunk-based development
- **Build System**: SCons (engine), Godot Export Templates
- **Asset Pipeline**: Godot Import System + custom resource pipeline
```

**SHOW**: The exact diff/change before writing.

**ASK**: "这个修改可以吗？"

**STOP**: Wait for approval, then write.

---

## Phase 5: Create Technical Preferences

**CREATE** `.opencode/docs/technical-preferences.md`:

```markdown
# Technical Preferences

## Engine & Language

- **Engine**: Godot [version]
- **Primary Language**: GDScript
- **Performance**: GDExtension (C++/Rust) when needed

## Naming Conventions

### GDScript
- Classes: PascalCase (`PlayerController`)
- Variables/functions: snake_case (`move_speed`)
- Signals: snake_case past tense (`health_changed`)
- Files: snake_case (`player_controller.gd`)
- Scenes: PascalCase (`PlayerController.tscn`)
- Constants: UPPER_SNAKE_CASE (`MAX_HEALTH`)

## Performance Budgets

- **Frame time**: <16.6ms (60fps target)
- **Memory**: Platform-specific
- **Load time**: <3s initial

## Testing

- **Framework**: GUT (Godot Unit Test)
- **Coverage**: Critical paths required

## Forbidden Patterns

- [ ] Untyped variables
- [ ] `$NodePath` in `_process()`
- [ ] Deep inheritance (>3 levels)
- [ ] God-class autoloads
- [ ] Connecting signals in `_process()`
```

**SHOW**: Full content, ask for approval.

**STOP**: Wait for approval, then write.

---

## Phase 6: Create Engine Reference

**CREATE** `.opencode/docs/engine-reference/godot/VERSION.md`:

```markdown
# Godot Version Reference

| Field | Value |
|-------|-------|
| **Engine** | Godot |
| **Version** | [version] |
| **Configured** | [date] |

## Key Features

- GDScript 2.0
- Improved 3D rendering
- Vulkan support
- Native 2D engine
```

**WRITE** without asking (this is informational only).

---

## Phase 7: Create Project Structure

**CREATE** directories (if not exist):

```
src/
├── core/           # Core utilities
├── systems/        # Game systems
├── gameplay/       # Game logic
├── ui/             # UI components
└── utils/          # Helpers

assets/
├── sprites/
├── audio/
├── fonts/
└── resources/

design/
├── gdd/
└── levels/

tests/
prototypes/
production/
```

**SHOW**: "创建目录结构..."

---

## Phase 8: Output Summary

**PRINT**:

```
✅ 引擎配置完成
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Engine:          Godot [version]
OPENCODE.md:     ✅ 已更新
Tech Prefs:      ✅ 已创建
Reference Docs:  ✅ 已创建
Project Structure: ✅ 已创建

下一步建议：
1. 查看 .opencode/docs/technical-preferences.md
2. 运行 /brainstorm 如果还没有游戏概念
3. 设计核心系统
4. 运行 /sprint-plan 来组织工作
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**STOP**: Skill complete. Offer next steps.

---

## Error Handling

| Error | Fallback |
|-------|----------|
| WebSearch fails | Use "4.3" as safe default |
| Cannot read OPENCODE.md | Create new one from template |
| Directory creation fails | Ask user to create manually |
| User declines changes | Abort gracefully, ask what to do instead |

---

## Quick Reference

| Phase | Action | Approval Needed? |
|-------|--------|------------------|
| 1 | Detect state | No |
| 2 | Select version | Yes |
| 3 | Preview changes | Yes |
| 4 | Update OPENCODE.md | Yes |
| 5 | Create tech prefs | Yes |
| 6 | Create engine ref | No |
| 7 | Create directories | No |
| 8 | Summary | No |