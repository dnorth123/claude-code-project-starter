#!/bin/bash

# Setup Workspace Wizard
# This script sets up the multi-project workspace structure

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║        Claude Code Workspace Setup Wizard                 ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Get workspace location
echo -e "${YELLOW}Where would you like to set up your workspace?${NC}"
echo -e "Press Enter for default: ${GREEN}~/Projects${NC}"
read -p "Workspace location: " workspace_location

# Use default if empty
if [ -z "$workspace_location" ]; then
    workspace_location="$HOME/Projects"
fi

# Expand ~ to home directory
workspace_location="${workspace_location/#\~/$HOME}"

echo ""
echo -e "${BLUE}Setting up workspace at:${NC} $workspace_location"
echo ""

# Create directory if it doesn't exist
if [ ! -d "$workspace_location" ]; then
    echo -e "${YELLOW}Creating directory...${NC}"
    mkdir -p "$workspace_location"
fi

# Copy workspace-template contents to workspace location
echo -e "${YELLOW}Copying workspace structure...${NC}"
rsync -av --exclude='setup-workspace.sh' --exclude='setup-project.sh' --exclude='.git' --exclude='README.md' ./ "$workspace_location/"

# Personalize paths in CLAUDE.md and README.md
echo -e "${YELLOW}Personalizing configuration files...${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s|~/Projects|$workspace_location|g" "$workspace_location/.workspace/CLAUDE.md"
    sed -i '' "s|~/Projects|$workspace_location|g" "$workspace_location/.workspace/README.md"
    sed -i '' "s|~/Projects|$workspace_location|g" "$workspace_location/sync-templates.sh"
else
    # Linux
    sed -i "s|~/Projects|$workspace_location|g" "$workspace_location/.workspace/CLAUDE.md"
    sed -i "s|~/Projects|$workspace_location|g" "$workspace_location/.workspace/README.md"
    sed -i "s|~/Projects|$workspace_location|g" "$workspace_location/sync-templates.sh"
fi

# Initialize git repository
cd "$workspace_location"
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}Initializing git repository...${NC}"
    git init
    echo -e "${GREEN}✓${NC} Git repository initialized"
else
    echo -e "${BLUE}Git repository already exists${NC}"
fi

# Create initial session log entry
echo -e "${YELLOW}Creating initial session log entry...${NC}"
current_date=$(date +"%Y-%m-%d %H:%M")
cat > "$workspace_location/.workspace/.session-log.md" << EOF
# Workspace Session Log

**Purpose**: Lightweight tracking of work sessions across projects
**Format**: \`YYYY-MM-DD HH:MM | project | action | context\`
**Auto-trim**: Keeps last 30 entries

---

## Recent Sessions

$current_date | workspace | Initial workspace setup | 0K (0%) 🟢

---

## Context Clear Events

*Track when context is cleared to maintain continuity*

---

## Usage Notes

- Update this log after each significant work session
- Use "update status" to automatically append session entry
- Context percentages: 🟢 <70% | 🟡 70-85% | 🟠 85-95% | 🔴 >95%
- Clear old entries when log exceeds ~30 entries
EOF

# Make sync script executable
chmod +x "$workspace_location/sync-templates.sh"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                            ║${NC}"
echo -e "${GREEN}║                   Setup Complete! ✓                        ║${NC}"
echo -e "${GREEN}║                                                            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Your workspace is ready at:${NC} $workspace_location"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo ""
echo "1. Navigate to your workspace:"
echo -e "   ${GREEN}cd $workspace_location${NC}"
echo ""
echo "2. Start Claude Code:"
echo -e "   ${GREEN}claude${NC}"
echo ""
echo "3. Check your workspace status:"
echo -e "   ${GREEN}What's the status of my projects${NC}"
echo ""
echo "4. Create your first project:"
echo -e "   ${GREEN}cd projects/personal${NC}"
echo -e "   ${GREEN}cp -r ../../.workspace/templates/project-starter my-first-project${NC}"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo -e "  • Workspace Guide: ${workspace_location}/.workspace/README.md"
echo -e "  • Commands Reference: ${workspace_location}/.workspace/CLAUDE.md"
echo -e "  • Roadmap: ${workspace_location}/.workspace/ROADMAP.md"
echo ""
echo -e "${YELLOW}Happy coding! 🚀${NC}"
echo ""

# Self-destruct (remove setup files from workspace)
if [ -f "$workspace_location/setup-workspace.sh" ]; then
    rm "$workspace_location/setup-workspace.sh"
fi
if [ -f "$workspace_location/setup-project.sh" ]; then
    rm "$workspace_location/setup-project.sh"
fi
