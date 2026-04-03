---
name: setup-engine
description: Configure the project's game engine and version. Pins the engine in OPENCODE.md, creates reference docs, and sets up technical preferences for Godot.
license: MIT
phase_automation:
  auto_proceed_default: false
  user_override_command: "/manual"
  phases:
    - phase: "Phase 1: Parse Arguments & Detect State"
      auto_conditions:
        - condition_type: "config_has_key"
          config_file: ".opencode/docs/technical-preferences.md"
          key: "Engine & Language"
          action_if_met: "skip"
          notification: "✅ 引擎配置已存在，跳过版本选择"

    - phase: "Phase 2.5: Language Preference Selection"
      auto_conditions:
        - condition_type: "language_preference_set"
          action_if_met: "skip"
          notification: "✅ 语言偏好已配置，跳过此阶段"

    - phase: "Phase 6: Create Engine Reference"
      auto_conditions:
        - condition_type: "previous_phase_success"
          previous_phase: "Phase 5: Update OPENCODE.md"
          action_if_met: "proceed"
          notification: "🔧 自动创建引擎引用文档..."

    - phase: "Phase 7: Create Project Structure"
      auto_conditions:
        - condition_type: "previous_phase_success"
          previous_phase: "Phase 6"
          action_if_met: "proceed"
          notification: "📁 自动创建项目目录结构..."

    - phase: "Phase 8: Output Summary"
      auto_conditions:
        - condition_type: "previous_phase_success"
          previous_phase: "Phase 7"
          action_if_met: "proceed"
          notification: "✅ 引擎配置完成！"
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

**IF version specified**: Jump to Phase 2.5
**IF no version**: Proceed to Phase 2

**STOP**: Show detected state, ask "你想配置哪个 Godot 版本？" if not specified.

---

## Phase 2: Engine & Version Selection

### Version Selection

**TRY** WebSearch for latest Godot 4 stable version.
**IF WebSearch FAILS**: Use default "4.6.1" (safe fallback)

**ASK**: "最新稳定版是 Godot [version]。使用这个版本？(Y/n)"

**STOP**: Wait for user confirmation.

---

## Phase 2.5: Language Preference Selection

**ASK**:
```
选择项目的语言偏好：

A) GDScript 为主 — 主要用 GDScript，快速迭代
B) C# 为主 — 主要用 C#，利用 .NET 生态
C) 双语言 — GDScript + C# 混合开发

推荐：
- 独立开发者/新手 → GDScript 为主
- 有 C# 经验/需要 .NET 库 → C# 为主
- 团队协作/大型项目 → 双语言
```

**STORE** user's choice for later phases.

**STOP**: Wait for user's choice.

---

## Phase 3: Language-Specific Configuration

Based on language preference, set up different configurations:

### A) GDScript 为主

**Tech Stack**:
```
- Primary: GDScript
- Secondary: (not specified)
- Performance: GDExtension when needed
```

**Project Structure**:
```
src/
├── core/
├── systems/
├── gameplay/
│   └── *.gd
├── ui/
└── utils/
```

**Key Skills**: `godot-gdscript`, `godot-specialist`

---

### B) C# 为主

**Tech Stack**:
```
- Primary: C#
- Secondary: (not specified)
- Performance: GDExtension when needed
```

**Project Structure**:
```
src/
├── Core/
├── Systems/
├── Gameplay/
│   └── *.cs
├── UI/
└── Utils/
```

**Key Skills**: `godot-csharp`, `godot-specialist`

---

### C) 双语言

**Tech Stack**:
```
- Languages: GDScript + C#
- Default: GDScript (game logic), C# (data/systems)
- Performance: GDExtension when needed
```

**Project Structure**:
```
src/
├── core/
├── systems/
│   ├── *.gd      # GDScript systems
│   └── *.cs      # C# systems
├── gameplay/
│   ├── *.gd      # GDScript gameplay
│   └── *.cs      # C# gameplay (optional)
├── ui/
└── utils/
```

**Key Skills**: `godot-gdscript`, `godot-csharp`, `godot-specialist`

---

## Phase 4: Show Changes Preview

Present EXACTLY what will be created/modified:

```
将要创建/修改的文件：
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. OPENCODE.md
   - Engine: Godot [version]
   - Languages: [根据选择]
   
2. .opencode/docs/technical-preferences.md
   - 语言偏好: [根据选择]
   - 命名规范: [根据选择]
   
3. .opencode/docs/engine-reference/godot/VERSION.md
   - 版本引用文档
   
4. 项目目录结构：
   [根据语言偏好生成]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**ASK**: "确认创建这些文件？(Y/n)"

**STOP**: Wait for user approval.

---

## Phase 5: Update OPENCODE.md

Generate based on language preference:

### GDScript 为主
```markdown
## Technology Stack
- **Engine**: Godot [version]
- **Language**: GDScript (primary)
- **Performance**: GDExtension (C++/Rust) when needed
```

### C# 为主
```markdown
## Technology Stack
- **Engine**: Godot [version]
- **Language**: C# (primary)
- **Performance**: GDExtension (C++/Rust) when needed
```

### 双语言
```markdown
## Technology Stack
- **Engine**: Godot [version]
- **Languages**: GDScript + C# (dual support)
- **Default**: GDScript (game logic), C# (data/systems)
- **Performance**: GDExtension (C++/Rust) when needed
```

**ASK**: "更新 OPENCODE.md？"

**STOP**: Wait for approval, then write.

---

## Phase 6: Create Technical Preferences

Generate based on language preference:

### GDScript 为主
```markdown
# Technical Preferences

## Engine & Language
- **Engine**: Godot [version]
- **Primary Language**: GDScript
- **Performance**: GDExtension when needed

## Naming Conventions (GDScript)
| Element | Convention | Example |
|---------|------------|---------|
| Classes | PascalCase | PlayerController |
| Functions | snake_case | calculate_damage() |
| Variables | snake_case | current_health |
| Signals | snake_case | health_changed |
| Files | snake_case | player_controller.gd |

## Recommended Skills
- `/godot-gdscript` — GDScript patterns
- `/godot-specialist` — Engine guidance
```

### C# 为主
```markdown
# Technical Preferences

## Engine & Language
- **Engine**: Godot [version]
- **Primary Language**: C#
- **Performance**: GDExtension when needed
- **Target Framework**: .NET 8.0

## Naming Conventions (C#)
| Element | Convention | Example |
|---------|------------|---------|
| Classes | PascalCase | PlayerController |
| Methods | PascalCase | TakeDamage() |
| Properties | PascalCase | CurrentHealth |
| Fields | _camelCase | _currentHealth |
| Files | PascalCase | PlayerController.cs |

## Recommended Skills
- `/godot-csharp` — C# patterns
- `/godot-specialist` — Engine guidance
```

### 双语言
```markdown
# Technical Preferences

## Engine & Language
- **Engine**: Godot [version]
- **Languages**: GDScript + C#
- **Default Usage**:
  - GDScript: Game logic, UI, rapid prototyping
  - C#: Data processing, .NET libraries, systems

## Naming Conventions

### GDScript
| Element | Convention | Example |
|---------|------------|---------|
| Functions | snake_case | calculate_damage() |
| Variables | snake_case | current_health |
| Files | snake_case | player_controller.gd |

### C#
| Element | Convention | Example |
|---------|------------|---------|
| Methods | PascalCase | TakeDamage() |
| Properties | PascalCase | CurrentHealth |
| Files | PascalCase | PlayerController.cs |

## Language Selection Guide
| Task | Recommended |
|------|-------------|
| Game logic | GDScript |
| UI | GDScript or C# |
| .NET libraries | C# |
| Heavy computation | C# or GDExtension |
| Rapid prototyping | GDScript |

## Recommended Skills
- `/godot-gdscript` — GDScript patterns
- `/godot-csharp` — C# patterns
- `/godot-specialist` — Engine guidance
```

**SHOW**: Full content preview.

**ASK**: "创建 technical-preferences.md？"

**STOP**: Wait for approval, then write.

---

## Phase 7: Create Engine Reference

**CREATE** `.opencode/docs/engine-reference/godot/VERSION.md`:

```markdown
# Godot Version Reference

| Field | Value |
|-------|-------|
| **Engine** | Godot |
| **Version** | [version] |
| **Language Preference** | [GDScript/C#/双语言] |
| **Configured** | [date] |

## Key Features

- GDScript 2.0
- Improved C# support
- Vulkan rendering
- Native 2D engine

## Notes

[Language-specific notes based on preference]
```

**WRITE** without asking (informational only).

---

## Phase 8: Create Project Structure

**CREATE** directories based on language preference:

### GDScript 为主
```
src/
├── core/
├── systems/
├── gameplay/
├── ui/
└── utils/

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

### C# 为主
```
src/
├── Core/
├── Systems/
├── Gameplay/
├── UI/
└── Utils/

[Same assets, design, tests, prototypes, production]
```

### 双语言
```
src/
├── core/
├── systems/
├── gameplay/
├── ui/
└── utils/

[Same structure, both .gd and .cs files allowed]
```

**SHOW**: "创建目录结构..."

---

## Phase 9: Output Summary

**PRINT**:
```
✅ 引擎配置完成
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Engine:          Godot [version]
Language:        [GDScript/C#/双语言]
OPENCODE.md:     ✅ 已更新
Tech Prefs:      ✅ 已创建
Project Structure: ✅ 已创建

下一步建议：
1. 查看 .opencode/docs/technical-preferences.md
2. 运行 /brainstorm 如果还没有游戏概念
3. 运行 /sprint-plan 来组织工作

语言相关 Skills：
- /godot-gdscript — GDScript 模式
- /godot-csharp — C# 模式
- /godot-specialist — 引擎指导
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**STOP**: Setup complete.

---

## Error Handling

| Error | Fallback |
|-------|----------|
| WebSearch fails | Use "4.6.1" as default |
| Cannot read OPENCODE.md | Create new one from template |
| Directory creation fails | Ask user to create manually |
| User cancels | Abort gracefully, no files written |

---

## Quick Reference

| Phase | Action | Approval? |
|-------|--------|-----------|
| 1 | Detect state | No |
| 2 | Select version | Yes |
| 2.5 | Select language | Yes |
| 3 | Preview changes | Yes |
| 4 | Preview OPENCODE.md | Yes |
| 5 | Preview tech prefs | Yes |
| 6 | Create engine ref | No |
| 7 | Create directories | No |
| 8 | Summary | No |

---

## Language Preference Impact

| Setting | GDScript 为主 | C# 为主 | 双语言 |
|---------|--------------|---------|--------|
| Primary language | GDScript | C# | Both |
| File naming | snake_case.gd | PascalCase.cs | Both |
| Key skills | godot-gdscript | godot-csharp | Both |
| Default for new code | GDScript | C# | Ask each time |