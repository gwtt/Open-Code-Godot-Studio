# Hooks Configuration

OpenCode supports hooks that run at specific lifecycle events. This document describes the hook system for OpenCode Game Studios - Godot Edition.

## Supported Hook Events

| Event | Trigger | Purpose |
|-------|---------|---------|
| `SessionStart` | Session begins | Load context, detect documentation gaps |
| `PreToolUse` | Before tool execution | Validate operations (commit, push) |
| `PostToolUse` | After tool execution | Validate outputs (assets, skill files) |
| `PreCompact` | Before context compaction | Dump session state |
| `PostCompact` | After context compaction | Restore session state reminder |
| `Stop` | Session ends | Log accomplishments |
| `SubagentStart` | Agent invoked | Audit trail for skill usage |
| `SubagentStop` | Agent completed | Audit trail completion |

---

## Hook Scripts Overview

| Hook | Event | Location | Key Features |
|------|-------|----------|--------------|
| **detect-gaps.sh** | SessionStart | `.opencode/hooks/` | Documentation gap detection |
| **session-start.sh** | SessionStart | `.opencode/hooks/` | Sprint context, git activity |
| **session-stop.sh** | Stop | `.opencode/hooks/` | Session summary, recommendations |
| **validate-commit.sh** | PreToolUse | `.opencode/hooks/` | Design docs, JSON, hardcoded values |
| **validate-assets.sh** | PostToolUse | `.opencode/hooks/` | Naming conventions, JSON validation |
| **pre-compact.sh** | PreCompact | `.opencode/hooks/` | Session state dump |
| **post-compact.sh** | PostCompact | `.opencode/hooks/` | Context restoration reminder |
| **log-agent.sh** | SubagentStart | `.opencode/hooks/` | Agent invocation audit |
| **log-agent-stop.sh** | SubagentStop | `.opencode/hooks/` | Agent completion audit |

---

## Session Hooks

### Session Start Hook

**Location**: `.opencode/hooks/session-start.sh`

Runs when a session begins:
- Loads sprint context from `production/sprints/current.md`
- Shows recent git activity (last 5 commits)
- Checks for missing game concept document

### Detect Gaps Hook

**Location**: `.opencode/hooks/detect-gaps.sh`

**Key Feature**: Comprehensive documentation gap detection for game dev projects.

Runs on session start, detects:

| Check | Condition | Suggested Action |
|-------|-----------|------------------|
| **Fresh Project** | No engine, no game concept, no source code | Run `/start` |
| **Sparse Design Docs** | >50 source files, <5 design docs | `/reverse-document design` |
| **Undocumented Prototypes** | Prototype directories without README/CONCEPT | `/reverse-document concept` |
| **Missing Architecture Docs** | `src/core` exists but no `docs/architecture/` | `/architecture-decision` |
| **Gameplay Systems Without Design** | `src/gameplay/[system]` with 5+ files, no corresponding GDD | `/reverse-document design` |
| **No Production Planning** | >100 source files, no `production/sprints/` | `/sprint-plan` |

### Session Stop Hook

**Location**: `.opencode/hooks/session-stop.sh`

Runs when session ends:
- Logs session end timestamp to `.opencode/logs/sessions.log`
- Counts uncommitted changes
- Provides recommended next steps:
  - `/code-review` for staged files
  - `/art-coordinator` for pending art requests
  - `/sprint-plan review` for sprint progress

---

## Validation Hooks

### Validate Commit Hook (Enhanced)

**Location**: `.opencode/hooks/validate-commit.sh`

**Input**: JSON stdin with `{ "tool_name": "Bash", "tool_input": { "command": "git commit..." } }`

Runs before git commit operations:

| Validation | Behavior |
|------------|----------|
| **Design Document Sections** | Warning if missing: Overview, Player Fantasy, Detailed, Formulas, Edge Cases, Dependencies, Tuning Knobs, Acceptance Criteria |
| **JSON Data Files** | **BLOCKS** if invalid JSON in `assets/data/*.json` |
| **Hardcoded Gameplay Values** | Warning for `damage|health|speed|rate|chance|cost|duration = [number]` in `src/gameplay/` |
| **TODO/FIXME Format** | Warning for TODO/FIXME without owner tag (use `TODO(name)` format) |
| **Hardcoded Secrets** | **BLOCKS** if `password|secret|api_key|token = "..."` detected |
| **Conventional Commits** | Advisory for non-standard format (feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert) |

### Validate Assets Hook

**Location**: `.opencode/hooks/validate-assets.sh`

Runs after file writes in `assets/`:
- Validates JSON structure with `python -m json.tool`
- Checks naming conventions (lowercase with underscores/hyphens)
- Suggests corrected filenames for uppercase/space violations

---

## Context Preservation Hooks

### Pre-Compact Hook

**Location**: `.opencode/hooks/pre-compact.sh`

**Purpose**: Dump session state before OpenCode compresses conversation context.

Outputs:
- Active session state from `production/session-state/active.md`
- Modified files (unstaged + staged + untracked)
- Work-in-progress design docs (files with TODO/WIP/PLACEHOLDER/TBD markers)
- Compaction event log to `production/session-logs/compaction-log.txt`

**Recovery Instructions**: After compaction, read `production/session-state/active.md` to restore context.

### Post-Compact Hook

**Location**: `.opencode/hooks/post-compact.sh`

**Purpose**: Remind to restore session state after compaction.

If `production/session-state/active.md` exists:
- Shows file location and size
- Reminds to read for context recovery

If missing:
- Suggests checking `production/session-logs/` for last session audit

---

## Audit Hooks

### Log Agent Hook

**Location**: `.opencode/hooks/log-agent.sh`

**Input**: JSON stdin with `{ "agent_id": "...", "agent_name": "godot-specialist", ... }`

Runs when a subagent/skill is invoked:
- Parses agent name (jq or grep fallback)
- Logs to `production/session-logs/agent-audit.log`
- Format: `TIMESTAMP | Agent invoked: [agent_name]`

### Log Agent Stop Hook

**Location**: `.opencode/hooks/log-agent-stop.sh`

Runs when a subagent/skill completes:
- Logs completion to same audit log
- Format: `TIMESTAMP | Agent completed: [agent_name]`

**Use Case**: Track which Godot specialists were used, analyze workflow efficiency.

---

## Configuration

Hooks are configured in `.opencode/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/session-start.sh", "timeout": 10 },
          { "type": "command", "command": "bash .opencode/hooks/detect-gaps.sh", "timeout": 15 }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/validate-commit.sh", "timeout": 15 }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/validate-assets.sh", "timeout": 10 }
        ]
      }
    ],
    "PreCompact": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/pre-compact.sh", "timeout": 10 }
        ]
      }
    ],
    "PostCompact": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/post-compact.sh", "timeout": 10 }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/session-stop.sh", "timeout": 10 }
        ]
      }
    ],
    "SubagentStart": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/log-agent.sh", "timeout": 5 }
        ]
      }
    ],
    "SubagentStop": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bash .opencode/hooks/log-agent-stop.sh", "timeout": 5 }
        ]
      }
    ]
  }
}
```

---

## Required Directory Structure

Hooks require these directories:

```
production/
├── session-state/    # Session state files (active.md)
├── session-logs/     # Audit logs (agent-audit.log, compaction-log.txt)
├── sprints/          # Sprint files (for session-start context)
└── milestones/       # Milestone files (for session-start context)
```

---

## Hook Safety Guidelines

Hooks should:
- **Fail gracefully** — Don't block if tools (jq, python) are missing
- **Be fast** — Keep under timeout limits (default: 5-15 seconds)
- **Be read-only** — Don't modify files unexpectedly (except logging)
- **Log errors** — Report issues to stderr without crashing
- **Cross-platform** — Use grep -E (POSIX) not grep -P (Perl) for Windows Git Bash compatibility

---

## Blocking vs Advisory

| Behavior | Exit Code | Use Case |
|----------|-----------|----------|
| **Allow** | `exit 0` | Normal flow, warnings shown |
| **Block** | `exit 2` | Build-breaking issues (invalid JSON, secrets) |

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Hooks not running | Check `.opencode/settings.json` exists and is valid JSON |
| jq not found | Hooks use grep fallback; install jq for better parsing |
| Python not found | JSON validation skipped; install Python for full validation |
| Permission denied | Ensure hook scripts have execute permission (`chmod +x`) |
| Timeout exceeded | Increase timeout in settings.json or optimize hook logic |

---

## Cross-Platform Notes

All hooks are compatible with **Windows Git Bash**:
- Use `grep -E` (POSIX extended) instead of `grep -P` (Perl regex)
- Path normalization: `sed 's|\\|/|g'` handles Windows backslashes
- `find` command works in Git Bash on Windows
- PowerShell commands use `-NonInteractive -WindowStyle Hidden` for notifications