#!/bin/bash

# Sync Templates Script
# Purpose: Copy working template from projects/templates/ to .workspace/templates/
# Usage: ./sync-templates.sh

set -e  # Exit on error

echo "🔄 Syncing project templates..."
echo ""

# Source and destination
SOURCE="projects/templates/cc-project-starter-template/"
DEST=".workspace/templates/project-starter/"

# Check if source exists
if [ ! -d "$SOURCE" ]; then
    echo "❌ Error: Source template not found at $SOURCE"
    exit 1
fi

# Check if destination directory exists
if [ ! -d ".workspace/templates" ]; then
    echo "📁 Creating .workspace/templates/ directory..."
    mkdir -p .workspace/templates
fi

# Show what will be synced
echo "📋 Sync Details:"
echo "   From: $SOURCE"
echo "   To:   $DEST"
echo ""

# Ask for confirmation
read -p "Continue with sync? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Sync cancelled"
    exit 0
fi

# Perform the sync
echo "🔄 Syncing files..."
rsync -av --delete \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='.next' \
    --exclude='.DS_Store' \
    "$SOURCE" "$DEST"

echo ""
echo "✅ Sync complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Review changes in $DEST"
echo "   2. Test the template by creating a new project"
echo "   3. If this is a public template improvement:"
echo "      - Update workspace-starter-template repo"
echo "      - Mark item as complete in .workspace/ROADMAP.md"
echo ""
