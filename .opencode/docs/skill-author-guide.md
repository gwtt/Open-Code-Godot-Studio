# Skill Author Guide: Adding Phase Automation

This guide explains how to add automation metadata to your skills to reduce unnecessary "continue" prompts.

## Overview

Phase automation allows skills to automatically skip or proceed through phases when certain conditions are met, improving user experience by reducing friction in configured projects.

## Quick Start

### 1. Add Frontmatter Metadata

Edit your skill's `SKILL.md` and add `phase_automation` to the frontmatter:

```yaml
---
name: my-skill
description: My skill description
license: MIT
phase_automation:
  auto_proceed_default: false
  user_override_command: "/manual"
  phases:
    - phase: "Phase 1: Detection"
      auto_conditions:
        - condition_type: "file_exists"
          target: ".opencode/config.md"
          action_if_met: "skip"
          notification: "✅ Config exists, skipping"
---
```

### 2. Verify Phase Names Match

The `phase` field must exactly match the phase heading in your SKILL.md:

```markdown
## Phase 1: Detection  ← Must match "Phase 1: Detection"
```

## Condition Types Reference

### Built-in Conditions

| Condition | Required Parameters | Example |
|-----------|---------------------|---------|
| `file_exists` | `target` | Check if `.opencode/config.md` exists |
| `config_has_key` | `config_file`, `key` | Check if key exists in config |
| `mcp_enabled` | `server_name` | Check if MCP server is enabled |
| `previous_phase_success` | `previous_phase` | Check if previous phase completed |
| `user_approved` | - | Detect Y/yes responses |
| `game_type_detected` | - | Detect game type from keywords |
| `language_preference_set` | - | Check if language is configured |
| `sprint_exists` | - | Check if sprint file exists |
| `milestone_exists` | - | Check if milestone file exists |
| `save_success` | - | Check if save operation succeeded |

### Condition Parameters

```yaml
- condition_type: "file_exists"
  target: ".opencode/project-context.md"  # File path to check
  action_if_met: "skip"                    # Action to take
  notification: "✅ Skipping..."            # Message to show
  fallback_action: "proceed_manual"        # If check fails
```

## Action Types Reference

| Action | Description | Use Case |
|--------|-------------|----------|
| `proceed` | Auto-advance to next phase | After successful operation |
| `skip` | Skip current phase entirely | When config already exists |
| `invoke_skill` | Call another skill | Chain skills automatically |
| `proceed_manual` | Continue with manual input | Fallback behavior |

## Complete Example

```yaml
---
name: setup-engine
description: Configure engine settings
license: MIT
phase_automation:
  auto_proceed_default: false
  user_override_command: "/manual"
  phases:
    - phase: "Phase 1: Parse Arguments"
      auto_conditions:
        - condition_type: "config_has_key"
          config_file: ".opencode/docs/technical-preferences.md"
          key: "Engine & Language"
          action_if_met: "skip"
          notification: "✅ Engine already configured"
          fallback_action: "proceed_manual"

    - phase: "Phase 6: Create Engine Reference"
      auto_conditions:
        - condition_type: "previous_phase_success"
          previous_phase: "Phase 5: Update OPENCODE.md"
          action_if_met: "proceed"
          notification: "🔧 Auto-creating engine reference..."

    - phase: "Phase 7: Create Project Structure"
      auto_conditions:
        - condition_type: "previous_phase_success"
          previous_phase: "Phase 6"
          action_if_met: "proceed"
          notification: "📁 Auto-creating directories..."
---
```

## Best Practices

### 1. Safety First
```yaml
auto_proceed_default: false  # Always start with manual mode
```

### 2. Clear Notifications
```yaml
notification: "✅ 具体说明发生了什么"  # Be specific about the auto-action
```

### 3. Provide Fallbacks
```yaml
fallback_action: "proceed_manual"  # Graceful degradation
```

### 4. Don't Over-Automate
- Only automate **detection** and **informational** phases
- Keep **decision** phases manual (user approval, scope changes)

### 5. Test Your Automation
1. Run skill with config missing → Should proceed manually
2. Run skill with config present → Should auto-skip
3. Type `/manual` → Should force manual mode

## Troubleshooting

### Automation Not Triggering
- Verify `phase` name matches heading exactly
- Check condition parameters are correct
- Ensure `auto_proceed_default` is not blocking

### User Can't Override
- Verify `user_override_command` is set
- User should type the command exactly: `/manual`

### Condition Evaluation Fails
- Check file paths are absolute or relative to project root
- Verify config file exists and is valid
- Check MCP server names match `.opencode/mcp.json`

## Schema Validation

Validate your frontmatter against the schema:

```bash
python .opencode/scripts/validate-skill-schema.py .opencode/skills/my-skill/SKILL.md
```

## More Information

- Schema definition: `.opencode/docs/schemas/phase-automation-schema.yaml`
- Condition types: `.opencode/docs/schemas/condition-types.json`
- Action types: `.opencode/docs/schemas/action-types.json`