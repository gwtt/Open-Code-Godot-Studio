# Hooks Configuration

OpenCode supports hooks that run at specific lifecycle events. This document describes the hook system for OpenCode Game Studios.

## Supported Hook Events

| Event | Trigger | Purpose |
|-------|---------|---------|
| `SessionStart` | Session begins | Load context, check project state |
| `PreToolUse` | Before tool execution | Validate operations |
| `PostToolUse` | After tool execution | Validate outputs |
| `Stop` | Session ends | Log accomplishments |

## Hook Scripts

### Session Start Hook

Location: `.opencode/hooks/session-start.sh`

Runs when a session begins:
- Loads sprint context
- Shows recent git activity
- Checks for project gaps

### Validate Commit Hook

Location: `.opencode/hooks/validate-commit.sh`

Runs before commit operations:
- Checks for hardcoded values
- Validates TODO format
- Ensures proper commit messages

### Validate Assets Hook

Location: `.opencode/hooks/validate-assets.sh`

Runs after file writes in `assets/`:
- Validates naming conventions
- Checks JSON structure
- Verifies resource references

### Session Stop Hook

Location: `.opencode/hooks/session-stop.sh`

Runs when session ends:
- Logs session accomplishments
- Updates session history

## Configuration

Hooks are configured in `.opencode/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash .opencode/hooks/session-start.sh",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

## Hook Safety

Hooks should:
- **Fail gracefully** — Don't block if tools are missing
- **Be fast** — Keep under timeout limits
- **Be read-only** — Don't modify files unexpectedly
- **Log errors** — Report issues without crashing