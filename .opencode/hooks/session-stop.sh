#!/bin/bash
# Session Stop Hook
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

exit 0