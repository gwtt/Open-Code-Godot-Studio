#!/bin/bash
# Session Stop Hook - Enhanced
# Runs when an OpenCode session ends

# Create session log directory
mkdir -p .opencode/logs

# Log session end
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "Session ended at $TIMESTAMP" >> .opencode/logs/sessions.log

# Count files changed this session (if git available)
if [ -d ".git" ]; then
    CHANGED=$(git status --porcelain 2>/dev/null | wc -l)
    if [ "$CHANGED" -gt 0 ]; then
        echo "📝 $CHANGED file(s) have uncommitted changes"
    fi
fi

# NEW: Detect project state and suggest next steps
echo ""
echo "━━━━━━━━ Recommended Next Steps ━━━━━━━━"

# Check for unreviewed code
if [ -d ".git" ]; then
    STAGED=$(git diff --name-only --cached 2>/dev/null | wc -l)
    if [ "$STAGED" -gt 0 ]; then
        echo "📝 $STAGED staged file(s) — Run: /code-review"
    fi
fi

# Check for missing tests
if [ -d "src" ] && [ ! -d "tests" ]; then
    echo "⚠️  No tests directory — Consider: /test-driven-development"
fi

# Check sprint progress
if [ -f "production/sprints/current.md" ]; then
    echo "📋 Check sprint: /sprint-plan review"
fi

# Check for pending art requests
if [ -d "design/art-requests" ] && [ "$(ls -A design/art-requests 2>/dev/null)" ]; then
    echo "🎨 Pending art requests — Run: /art-coordinator"
fi

# Check for uncommitted changes
if [ -d ".git" ]; then
    UNCOMMITTED=$(git diff --name-only 2>/dev/null | wc -l)
    if [ "$UNCOMMITTED" -gt 0 ]; then
        echo "💾 $UNCOMMITTED unstaged file(s) — Consider committing"
    fi
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

exit 0