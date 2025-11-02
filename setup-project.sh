#!/bin/bash

# Setup Project Wizard
# This script sets up a single project using the cc-project-starter-template

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║       Claude Code Project Setup Wizard                    ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Get project name
echo -e "${YELLOW}What would you like to name your project?${NC}"
read -p "Project name: " project_name

if [ -z "$project_name" ]; then
    echo -e "${YELLOW}Project name cannot be empty. Using 'my-project'${NC}"
    project_name="my-project"
fi

echo ""
echo -e "${BLUE}Setting up project:${NC} $project_name"
echo ""

# Get current directory name
current_dir=$(basename "$PWD")

# Copy project template files to current directory
echo -e "${YELLOW}Copying project template...${NC}"
cp -r project-template/.claude .
cp -r project-template/docs .
cp project-template/.gitignore .
cp project-template/ENHANCEMENT-SETUP.md .
cp project-template/LICENSE .
cp project-template/README-STRUCTURE.md .
cp project-template/Setup.md .

# Initialize project BUILD-STATUS with project name
echo -e "${YELLOW}Initializing project documentation...${NC}"
current_date=$(date +"%Y-%m-%d")
repo_path=$(pwd)

# Update build-status.md with project info
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s|\[PROJECT_NAME\]|$project_name|g" "docs/project/build-status.md"
    sed -i '' "s|\[UPDATE_ME\]|$repo_path|g" "docs/project/build-status.md"
    sed -i '' "s|\[TODAY\]|$current_date|g" "docs/project/build-status.md"
else
    # Linux
    sed -i "s|\[PROJECT_NAME\]|$project_name|g" "docs/project/build-status.md"
    sed -i "s|\[UPDATE_ME\]|$repo_path|g" "docs/project/build-status.md"
    sed -i "s|\[TODAY\]|$current_date|g" "docs/project/build-status.md"
fi

# Create .status file
echo "Status: Phase 0 - Planning | Next: Complete project planning | $current_date" > .status

# Create initial README
cat > README.md << EOF
# $project_name

**Status**: Phase 0 - Planning
**Last Updated**: $current_date

## Overview

[Add your project description here]

## Quick Start

This project uses the claude-code-project-starter template for structured development with Claude Code.

### Getting Started

1. Open Claude Code in this directory
2. Say: "Check the docs/project/ folder and help me get started"
3. Follow the planning phase to define your project

### Commands

- **Check status**: "Check the build status and tell me where we are at"
- **Update progress**: "Update status"
- **Check context**: "Check context"

## Documentation

- BUILD STATUS: \`docs/project/build-status.md\`
- PROJECT PLAN: \`docs/project/project-plan.md\`
- TECH STACK: \`docs/project/tech-stack.md\`
- ROADMAP: \`docs/project/roadmap.md\`

## Next Steps

1. Complete project planning (docs/project/)
2. Define technical stack
3. Break down into phases
4. Start Phase 1 development

---

Built with [claude-code-project-starter](https://github.com/YOUR-USERNAME/claude-code-project-starter)
EOF

# Initialize git repository
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}Initializing git repository...${NC}"
    git init
    echo -e "${GREEN}✓${NC} Git repository initialized"
else
    echo -e "${BLUE}Git repository already exists${NC}"
fi

# Clean up template files
echo -e "${YELLOW}Cleaning up template files...${NC}"
rm -rf project-template
rm -rf workspace-template
rm -f WORKSPACE-GUIDE.md
rm -f setup-workspace.sh
rm -f setup-project.sh

# Create initial git commit
echo -e "${YELLOW}Creating initial commit...${NC}"
git add .
git commit -m "Initial commit - Project setup from claude-code-project-starter

Project: $project_name
Template: claude-code-project-starter
Date: $current_date

🤖 Generated with Claude Code (https://claude.com/claude-code)"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                            ║${NC}"
echo -e "${GREEN}║                   Setup Complete! ✓                        ║${NC}"
echo -e "${GREEN}║                                                            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Your project '${project_name}' is ready!${NC}"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo ""
echo "1. Start Claude Code:"
echo -e "   ${GREEN}claude${NC}"
echo ""
echo "2. Begin planning your project:"
echo -e "   ${GREEN}Check the docs/project/ folder and help me get started${NC}"
echo ""
echo "3. Or jump straight to status:"
echo -e "   ${GREEN}Check the build status and tell me where we are at${NC}"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo -e "  • BUILD STATUS: docs/project/build-status.md"
echo -e "  • Setup Guide: Setup.md"
echo -e "  • Enhancements: ENHANCEMENT-SETUP.md"
echo ""
echo -e "${YELLOW}Happy building! 🚀${NC}"
echo ""
