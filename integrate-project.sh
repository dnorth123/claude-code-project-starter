#!/bin/bash

# Claude Code Project Starter - Existing Project Integration Script
# Version: 2.0.0
# This script helps integrate existing Claude Code projects into this template system

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located (template directory)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$SCRIPT_DIR/project-template"

# Function to print colored output
print_color() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

print_header() {
    echo ""
    print_color "$BLUE" "═══════════════════════════════════════════════════════════════"
    print_color "$BLUE" "$1"
    print_color "$BLUE" "═══════════════════════════════════════════════════════════════"
    echo ""
}

print_success() {
    print_color "$GREEN" "✓ $1"
}

print_warning() {
    print_color "$YELLOW" "⚠ $1"
}

print_error() {
    print_color "$RED" "✗ $1"
}

# Function to ask yes/no questions
ask_yes_no() {
    local question=$1
    local default=${2:-"n"}
    local prompt="[y/N]"

    if [ "$default" = "y" ]; then
        prompt="[Y/n]"
    fi

    while true; do
        read -p "$question $prompt: " response
        response=${response:-$default}
        case $response in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to check if we're in a git repo
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository!"
        echo "This script requires your project to be a git repository."
        echo "Initialize git with: git init"
        exit 1
    fi
}

# Function to check for uncommitted changes
check_uncommitted_changes() {
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        print_warning "You have uncommitted changes!"
        echo "It's recommended to commit or stash changes before integration."
        echo ""
        if ask_yes_no "Do you want to see the changes?"; then
            git status
            echo ""
        fi
        if ! ask_yes_no "Continue anyway?"; then
            print_error "Aborted by user"
            exit 1
        fi
    fi
}

# Function to create backup branch
create_backup() {
    local branch_name="backup-pre-integration-$(date +%Y%m%d-%H%M%S)"
    print_color "$YELLOW" "Creating backup branch: $branch_name"

    git checkout -b "$branch_name" 2>/dev/null || {
        print_error "Failed to create backup branch"
        exit 1
    }

    git add -A
    git commit -m "Backup before template integration" --allow-empty

    git checkout - > /dev/null

    print_success "Backup created: $branch_name"
    echo "  You can restore with: git checkout $branch_name"
}

# Function to assess current project
assess_project() {
    print_header "Project Assessment"

    echo "Analyzing your current project..."
    echo ""

    # Check for .claude directory
    if [ -d ".claude" ]; then
        print_success "Found .claude/ directory"

        if [ -f ".claude/claude.md" ]; then
            local word_count=$(wc -w < .claude/claude.md)
            local estimated_tokens=$((word_count * 13 / 10))
            echo "  • claude.md: $word_count words (~$estimated_tokens tokens)"

            if [ $estimated_tokens -gt 10000 ]; then
                print_warning "  Your claude.md is large (>10K tokens)"
                echo "  Integration will help reduce this significantly"
            fi
        fi

        if [ -f ".claude/settings.json" ] || [ -f ".claude/settings.local.json" ]; then
            echo "  • Has permission settings"
        fi

        if [ -d ".claude/commands" ]; then
            local cmd_count=$(ls -1 .claude/commands/*.md 2>/dev/null | wc -l)
            echo "  • Custom commands: $cmd_count"
        fi
    else
        print_warning "No .claude/ directory found"
        echo "  Will create new .claude/ directory"
    fi

    # Check for documentation
    echo ""
    if [ -d "docs" ]; then
        print_success "Found docs/ directory"
        ls -1 docs/ | sed 's/^/  • /'
    else
        echo "  No docs/ directory found"
    fi

    # Check for README
    if [ -f "README.md" ]; then
        echo "  • README.md exists"
    fi

    echo ""
}

# Function to display integration level options
show_integration_levels() {
    print_header "Integration Levels"

    echo "Choose how deeply to integrate the template:"
    echo ""
    print_color "$GREEN" "1. Minimal Integration (15-30 minutes)"
    echo "   • Adds status tracking (build-status.md)"
    echo "   • Updates .claude/claude.md with context management"
    echo "   • Keeps all your existing structure"
    echo "   • Best for: Projects with established docs"
    echo ""
    print_color "$YELLOW" "2. Standard Integration (1-2 hours) [RECOMMENDED]"
    echo "   • Everything from Minimal"
    echo "   • Adds full docs/project/ structure"
    echo "   • Adds /capture-roadmap-item command"
    echo "   • Optional permission presets"
    echo "   • Best for: Most existing projects"
    echo ""
    print_color "$BLUE" "3. Full Integration (2-4 hours)"
    echo "   • Everything from Standard"
    echo "   • Complete .claude/ directory setup"
    echo "   • Permission preset system"
    echo "   • Supporting files (Setup.md, etc.)"
    echo "   • Best for: Long-term projects wanting maximum benefits"
    echo ""
}

# Function to perform minimal integration
integrate_minimal() {
    print_header "Minimal Integration"

    # Create docs/project if needed
    mkdir -p docs/project
    print_success "Created docs/project/"

    # Copy build-status.md
    if [ -f "docs/project/build-status.md" ]; then
        if ask_yes_no "docs/project/build-status.md exists. Overwrite?"; then
            cp "$TEMPLATE_DIR/docs/project/build-status.md" docs/project/build-status.md
            print_success "Updated build-status.md"
        else
            print_warning "Skipped build-status.md"
        fi
    else
        cp "$TEMPLATE_DIR/docs/project/build-status.md" docs/project/build-status.md
        print_success "Added build-status.md"
    fi

    # Handle .claude/claude.md
    echo ""
    if [ -f ".claude/claude.md" ]; then
        print_warning "You already have .claude/claude.md"
        echo "You'll need to manually add the context tracking section."
        echo "See INTEGRATE-EXISTING.md for the template."

        if ask_yes_no "Do you want to see the section to add?"; then
            echo ""
            print_color "$BLUE" "Add this section to your .claude/claude.md:"
            echo ""
            cat << 'EOF'
## Context & Token Status

**Current Usage:** [X]K / 200K tokens (~X%)
**Status:** 🟢 Green - Smooth sailing

**Thresholds:**
- 🟢 Green (<140K / <70%): Normal operation
- 🟡 Yellow (140-170K / 70-85%): Note for later
- 🟠 Orange (170-190K / 85-95%): Clear after current task
- 🔴 Red (>190K / >95%): Clear immediately

**Last Checked:** YYYY-MM-DD
EOF
            echo ""
        fi
    else
        mkdir -p .claude
        cp "$TEMPLATE_DIR/.claude/claude.md" .claude/claude.md
        print_success "Created .claude/claude.md with context tracking"
    fi

    print_success "Minimal integration complete!"
}

# Function to perform standard integration
integrate_standard() {
    print_header "Standard Integration"

    # First do minimal integration
    integrate_minimal

    echo ""
    print_color "$YELLOW" "Adding documentation structure..."

    # Copy all docs/project files
    local docs_files=("project-plan.md" "tech-stack.md" "roadmap.md")

    for file in "${docs_files[@]}"; do
        if [ -f "docs/project/$file" ]; then
            if ask_yes_no "docs/project/$file exists. Overwrite?" "n"; then
                cp "$TEMPLATE_DIR/docs/project/$file" "docs/project/$file"
                print_success "Updated $file"
            else
                print_warning "Skipped $file (kept existing)"
            fi
        else
            cp "$TEMPLATE_DIR/docs/project/$file" "docs/project/$file"
            print_success "Added $file"
        fi
    done

    # Copy capture-roadmap-item command
    echo ""
    mkdir -p .claude/commands
    if [ -f ".claude/commands/capture-roadmap-item.md" ]; then
        print_warning "capture-roadmap-item.md already exists, skipping"
    else
        cp "$TEMPLATE_DIR/.claude/commands/capture-roadmap-item.md" .claude/commands/
        print_success "Added /capture-roadmap-item command"
    fi

    # Ask about permission presets
    echo ""
    if ask_yes_no "Do you want to add permission presets?" "y"; then
        cp -r "$TEMPLATE_DIR/.claude/presets" .claude/ 2>/dev/null || true
        cp "$TEMPLATE_DIR/.claude/commands/setup-permissions.md" .claude/commands/ 2>/dev/null || true
        print_success "Added permission presets and /setup-permissions command"
        echo "  Run /setup-permissions in Claude to configure"
    fi

    print_success "Standard integration complete!"
}

# Function to perform full integration
integrate_full() {
    print_header "Full Integration"

    # First do standard integration
    integrate_standard

    echo ""
    print_color "$YELLOW" "Adding complete template files..."

    # Copy supporting files
    local support_files=("README-STRUCTURE.md" "Setup.md")

    for file in "${support_files[@]}"; do
        if [ -f "$file" ]; then
            if ask_yes_no "$file exists. Overwrite?" "n"; then
                cp "$TEMPLATE_DIR/$file" "$file"
                print_success "Updated $file"
            else
                print_warning "Skipped $file (kept existing)"
            fi
        else
            cp "$TEMPLATE_DIR/$file" "$file"
            print_success "Added $file"
        fi
    done

    # Merge .gitignore
    echo ""
    if [ -f ".gitignore" ]; then
        if ask_yes_no "Merge template .gitignore with yours?" "y"; then
            echo "" >> .gitignore
            echo "# Added from Claude Code Project Starter template" >> .gitignore
            cat "$TEMPLATE_DIR/.gitignore" >> .gitignore
            print_success "Merged .gitignore"
        fi
    else
        cp "$TEMPLATE_DIR/.gitignore" .gitignore
        print_success "Added .gitignore"
    fi

    print_success "Full integration complete!"
}

# Main script
main() {
    print_header "Claude Code Project Starter - Integration Wizard"

    echo "This wizard will help you integrate the template into your existing project."
    echo ""
    print_warning "Important: This will modify your project files"
    echo "A backup branch will be created automatically."
    echo ""

    if ! ask_yes_no "Continue?" "y"; then
        print_error "Aborted by user"
        exit 0
    fi

    # Pre-flight checks
    check_git_repo
    check_uncommitted_changes

    # Create backup
    echo ""
    if ask_yes_no "Create backup branch?" "y"; then
        create_backup
    else
        print_warning "Skipping backup (not recommended!)"
    fi

    # Assess current project
    echo ""
    assess_project

    # Show integration levels
    show_integration_levels

    # Get user choice
    while true; do
        read -p "Choose integration level (1-3): " level
        case $level in
            1 ) integrate_minimal; break;;
            2 ) integrate_standard; break;;
            3 ) integrate_full; break;;
            * ) echo "Please choose 1, 2, or 3";;
        esac
    done

    # Post-integration steps
    print_header "Next Steps"

    echo "Integration complete! Here's what to do next:"
    echo ""
    print_color "$GREEN" "1. Review the changes:"
    echo "   git status"
    echo ""
    print_color "$GREEN" "2. Commit the integration:"
    echo "   git add -A"
    echo "   git commit -m \"Integrate Claude Code Project Starter template\""
    echo ""
    print_color "$GREEN" "3. Initialize your project status in Claude:"
    echo "   Tell Claude:"
    echo "   \"I've integrated the Claude Code Project Starter template."
    echo "    Please read the codebase and update build-status.md with"
    echo "    current progress and remaining tasks.\""
    echo ""
    print_color "$GREEN" "4. Test the integration:"
    echo "   - Run: \"Update status\""
    echo "   - Start new session and run: \"Check the build status\""
    echo ""
    print_color "$BLUE" "5. Read the integration guide:"
    echo "   cat INTEGRATE-EXISTING.md"
    echo ""

    if ask_yes_no "Do you want to open the integration guide now?" "n"; then
        if command -v less &> /dev/null; then
            less "$SCRIPT_DIR/INTEGRATE-EXISTING.md"
        else
            cat "$SCRIPT_DIR/INTEGRATE-EXISTING.md"
        fi
    fi

    echo ""
    print_success "Happy coding with Claude! 🚀"
}

# Run main function
main
