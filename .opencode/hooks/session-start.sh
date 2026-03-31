#!/bin/bash
# Session Start Hook
# Runs when an OpenCode session begins

# Load sprint context if exists
if [ -f "production/sprints/current.md" ]; then
    echo "📋 Current Sprint: $(head -n 1 production/sprints/current.md)"
fi

# Show recent git activity
if [ -d ".git" ]; then
    echo ""
    echo "📝 Recent Activity:"
    git log --oneline -5 2>/dev/null || echo "  No commits yet"
fi

# Check for missing documentation
if [ -d "src" ] && [ ! -f "design/gdd/game-concept.md" ]; then
    echo ""
    echo "⚠️  Project has code but no game concept document."
    echo "   Consider running /start to set up documentation."
fi

exit 0