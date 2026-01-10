#!/bin/bash

# Claude Code Project Starter - Integration Script
# Version: 3.0.0
# Integrates existing projects with v3.0 features:
# - Dynamic model recommendations
# - Real sub-agents
# - Hooks system
# - 8 consolidated personas

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$SCRIPT_DIR/project-template"

# Parse arguments
TIER="essential"
TARGET_DIR=""
NON_INTERACTIVE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --essential)
            TIER="essential"
            shift
            ;;
        --extended)
            TIER="extended"
            shift
            ;;
        --non-interactive|-y)
            NON_INTERACTIVE=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [path] [options]"
            echo ""
            echo "Options:"
            echo "  --essential    Essential tier (default) - model strategy, auto-hooks, sub-agents, personas"
            echo "  --extended     Extended tier - adds validated hooks, advanced patterns"
            echo "  --non-interactive, -y  Run without prompts (use defaults)"
            echo "  --help, -h     Show this help"
            echo ""
            echo "Examples:"
            echo "  $0 /path/to/project              # Essential tier"
            echo "  $0 /path/to/project --extended   # Extended tier"
            echo "  $0 --extended                    # Current directory, extended tier"
            exit 0
            ;;
        *)
            if [ -z "$TARGET_DIR" ]; then
                TARGET_DIR="$1"
            fi
            shift
            ;;
    esac
done

# Default to current directory
TARGET_DIR="${TARGET_DIR:-.}"

# Utility functions
print_color() {
    echo -e "${1}${2}${NC}"
}

print_header() {
    echo ""
    print_color "$BLUE" "═══════════════════════════════════════════════════════════════"
    print_color "$BLUE" "$1"
    print_color "$BLUE" "═══════════════════════════════════════════════════════════════"
    echo ""
}

print_success() { print_color "$GREEN" "✓ $1"; }
print_warning() { print_color "$YELLOW" "⚠ $1"; }
print_error() { print_color "$RED" "✗ $1"; }
print_info() { print_color "$CYAN" "ℹ $1"; }

ask_yes_no() {
    if [ "$NON_INTERACTIVE" = true ]; then
        return 0
    fi
    local question=$1
    local default=${2:-"y"}
    local prompt="[Y/n]"
    [ "$default" = "n" ] && prompt="[y/N]"

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

# Navigate to target directory
cd "$TARGET_DIR" || {
    print_error "Cannot access directory: $TARGET_DIR"
    exit 1
}

# Pre-flight checks
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_warning "Not a git repository"
        if ask_yes_no "Initialize git repository?"; then
            git init
            print_success "Initialized git repository"
        else
            print_error "Git repository required"
            exit 1
        fi
    fi
}

check_uncommitted_changes() {
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        print_warning "Uncommitted changes detected"
        if ! ask_yes_no "Continue anyway?" "n"; then
            print_error "Commit or stash changes first"
            exit 1
        fi
    fi
}

create_backup() {
    local branch_name="backup-pre-v3-integration-$(date +%Y%m%d-%H%M%S)"
    git stash push -m "Pre-integration backup" 2>/dev/null || true
    git checkout -b "$branch_name" 2>/dev/null
    git stash pop 2>/dev/null || true
    git add -A
    git commit -m "Backup before v3.0 integration" --allow-empty
    git checkout - > /dev/null
    print_success "Backup branch: $branch_name"
}

# Integration functions
integrate_essential() {
    print_header "Essential Tier Integration"

    echo "Installing v3.0 Essential features:"
    echo "  • Dynamic model recommendations"
    echo "  • Sub-agent documentation"
    echo "  • 8 core personas"
    echo "  • Auto-run hooks"
    echo "  • Status tracking"
    echo ""

    # Create directories
    mkdir -p .claude/hooks/auto
    mkdir -p docs/project

    # Copy core v3.0 files
    print_info "Adding MODEL-STRATEGY.md..."
    cp "$TEMPLATE_DIR/.claude/MODEL-STRATEGY.md" .claude/
    print_success "Added MODEL-STRATEGY.md"

    print_info "Adding SUBAGENTS.md..."
    cp "$TEMPLATE_DIR/.claude/SUBAGENTS.md" .claude/
    print_success "Added SUBAGENTS.md"

    print_info "Adding PERSONAS.md..."
    cp "$TEMPLATE_DIR/.claude/PERSONAS.md" .claude/
    print_success "Added PERSONAS.md"

    # Copy auto-run hooks
    print_info "Adding session-start hook..."
    cp "$TEMPLATE_DIR/.claude/hooks/auto/session-start.sh" .claude/hooks/auto/
    chmod +x .claude/hooks/auto/session-start.sh
    print_success "Added session-start.sh (auto-run)"

    # Copy hooks README
    cp "$TEMPLATE_DIR/.claude/hooks/README.md" .claude/hooks/
    print_success "Added hooks documentation"

    # Handle claude.md
    if [ -f ".claude/claude.md" ]; then
        print_warning "Existing .claude/claude.md found"
        if ask_yes_no "Replace with v3.0 version?" "n"; then
            mv .claude/claude.md .claude/claude.md.backup
            cp "$TEMPLATE_DIR/.claude/claude.md" .claude/
            print_success "Updated claude.md (backup: claude.md.backup)"
        else
            print_info "Keeping existing claude.md"
            print_info "Add model recommendations section manually from MODEL-STRATEGY.md"
        fi
    else
        cp "$TEMPLATE_DIR/.claude/claude.md" .claude/
        print_success "Added claude.md"
    fi

    # Handle settings.local.json
    if [ -f ".claude/settings.local.json" ]; then
        print_warning "Existing settings.local.json found"
        print_info "Merge hooks configuration manually:"
        echo '  "hooks": {'
        echo '    "SessionStart": ['
        echo '      {'
        echo '        "hooks": ['
        echo '          {'
        echo '            "type": "command",'
        echo '            "command": "bash .claude/hooks/auto/session-start.sh",'
        echo '            "timeout": 10'
        echo '          }'
        echo '        ]'
        echo '      }'
        echo '    ]'
        echo '  }'
    else
        cp "$TEMPLATE_DIR/.claude/settings.local.json" .claude/
        print_success "Added settings.local.json with hooks"
    fi

    # Add status tracking
    if [ ! -f "docs/project/build-status.md" ]; then
        cp "$TEMPLATE_DIR/docs/project/build-status.md" docs/project/
        print_success "Added build-status.md"
    else
        print_info "build-status.md already exists"
    fi

    # Copy other project docs if missing
    for file in project-plan.md tech-stack.md roadmap.md; do
        if [ ! -f "docs/project/$file" ]; then
            cp "$TEMPLATE_DIR/docs/project/$file" docs/project/
            print_success "Added $file"
        fi
    done

    print_success "Essential tier integration complete!"
}

integrate_extended() {
    # First do essential
    integrate_essential

    print_header "Extended Tier Additions"

    echo "Adding Extended features:"
    echo "  • Validated hooks (pre-commit, test-runner)"
    echo "  • Permission presets"
    echo "  • Advanced commands"
    echo ""

    # Create validated hooks directory
    mkdir -p .claude/hooks/validated

    # Copy validated hooks
    print_info "Adding validated hooks..."
    cp "$TEMPLATE_DIR/.claude/hooks/validated/pre-commit.sh" .claude/hooks/validated/
    cp "$TEMPLATE_DIR/.claude/hooks/validated/test-runner.sh" .claude/hooks/validated/
    chmod +x .claude/hooks/validated/*.sh
    print_success "Added pre-commit.sh (validated)"
    print_success "Added test-runner.sh (validated)"

    # Copy permission presets
    if [ -d "$TEMPLATE_DIR/.claude/presets" ]; then
        print_info "Adding permission presets..."
        cp -r "$TEMPLATE_DIR/.claude/presets" .claude/
        print_success "Added permission presets"
    fi

    # Copy commands
    mkdir -p .claude/commands
    for cmd in "$TEMPLATE_DIR/.claude/commands/"*.md; do
        if [ -f "$cmd" ]; then
            cmdname=$(basename "$cmd")
            if [ ! -f ".claude/commands/$cmdname" ]; then
                cp "$cmd" .claude/commands/
                print_success "Added command: $cmdname"
            fi
        fi
    done

    # Copy SETTINGS-GUIDE if exists
    if [ -f "$TEMPLATE_DIR/.claude/SETTINGS-GUIDE.md" ]; then
        cp "$TEMPLATE_DIR/.claude/SETTINGS-GUIDE.md" .claude/
        print_success "Added SETTINGS-GUIDE.md"
    fi

    print_success "Extended tier integration complete!"
}

# Main
main() {
    print_header "Claude Code Project Starter v3.0 - Integration"

    echo "Target: $(pwd)"
    echo "Tier: $TIER"
    echo ""

    if [ ! -d "$TEMPLATE_DIR" ]; then
        print_error "Template directory not found: $TEMPLATE_DIR"
        exit 1
    fi

    print_info "This will add v3.0 features to your project"
    echo ""

    if ! ask_yes_no "Continue?"; then
        print_error "Aborted"
        exit 0
    fi

    # Pre-flight
    check_git_repo
    check_uncommitted_changes

    # Backup
    if ask_yes_no "Create backup branch?"; then
        create_backup
    fi

    echo ""

    # Run integration
    case $TIER in
        essential)
            integrate_essential
            ;;
        extended)
            integrate_extended
            ;;
    esac

    # Post-integration
    print_header "Next Steps"

    echo "1. Review changes:"
    print_color "$CYAN" "   git status"
    echo ""
    echo "2. Commit integration:"
    print_color "$CYAN" "   git add -A && git commit -m 'Integrate Claude Code Project Starter v3.0'"
    echo ""
    echo "3. Start Claude Code and verify:"
    print_color "$CYAN" "   claude"
    echo "   - Session start hook should run automatically"
    echo "   - Ask Claude to recommend a model for a task"
    echo ""
    echo "4. Read the new documentation:"
    print_color "$CYAN" "   .claude/MODEL-STRATEGY.md  - Model recommendations"
    print_color "$CYAN" "   .claude/SUBAGENTS.md       - Sub-agent patterns"
    print_color "$CYAN" "   .claude/PERSONAS.md        - 8 core personas"
    echo ""

    print_success "Integration complete! Happy coding with Claude v3.0"
}

main
