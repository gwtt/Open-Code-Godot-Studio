#!/bin/bash
# Validate Commit Hook
# Runs before git commit operations

# Get commit message from stdin
COMMIT_MSG=$(cat)

# Check for empty message
if [ -z "$COMMIT_MSG" ]; then
    echo "❌ Commit message cannot be empty"
    exit 1
fi

# Check commit message format (conventional commits recommended)
if ! echo "$COMMIT_MSG" | head -n 1 | grep -qE "^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .{1,}"; then
    echo "⚠️  Consider using conventional commit format:"
    echo "   feat: add new feature"
    echo "   fix: resolve bug"
    echo "   docs: update documentation"
fi

# Check for hardcoded secrets (basic check)
if git diff --cached | grep -iE "(password|secret|api_key|token)\s*=\s*['\"]" > /dev/null 2>&1; then
    echo "❌ Possible hardcoded secret detected. Please use environment variables."
    exit 1
fi

exit 0