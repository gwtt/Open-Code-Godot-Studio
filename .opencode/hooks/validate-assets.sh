#!/bin/bash
# Validate Assets Hook
# Runs after file writes in assets/

# Get the file path from environment or arguments
FILE_PATH="${1:-}"

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

# Check if file is in assets directory
if [[ ! "$FILE_PATH" =~ ^assets/ ]]; then
    exit 0
fi

# Validate JSON files
if [[ "$FILE_PATH" =~ \.json$ ]]; then
    if command -v python &> /dev/null; then
        if ! python -m json.tool "$FILE_PATH" > /dev/null 2>&1; then
            echo "❌ Invalid JSON in $FILE_PATH"
            exit 1
        fi
    fi
fi

# Check naming conventions (lowercase, no spaces)
FILENAME=$(basename "$FILE_PATH")
if [[ "$FILENAME" =~ [A-Z] ]] || [[ "$FILENAME" =~ " " ]]; then
    echo "⚠️  Asset naming: use lowercase with underscores/hyphens"
    echo "   Current: $FILENAME"
    echo "   Suggested: $(echo "$FILENAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')"
fi

exit 0