#!/bin/bash
# Claude Code Session Start Hook
# Auto-runs on every session start
# Safe, non-destructive, informational only
#
# This hook provides environment context without making changes.

set -e

echo ""
echo "Session Environment Check"
echo "------------------------"

# Git status (informational)
if [ -d ".git" ]; then
    branch=$(git branch --show-current 2>/dev/null || echo "detached")
    changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

    echo "Git Branch: $branch"

    if [ "$changes" -gt "0" ]; then
        echo "Uncommitted: $changes files"
    else
        echo "Working tree: clean"
    fi

    # Check if ahead/behind remote
    upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "")
    if [ -n "$upstream" ]; then
        ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
        behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
        if [ "$ahead" -gt "0" ] || [ "$behind" -gt "0" ]; then
            echo "Remote: $ahead ahead, $behind behind"
        fi
    fi
fi

# Node.js project check
if [ -f "package.json" ]; then
    echo ""
    echo "Node.js Project Detected"

    # Check Node version
    if command -v node &> /dev/null; then
        node_version=$(node -v 2>/dev/null)
        echo "Node: $node_version"
    else
        echo "Node: not installed"
    fi

    # Check dependencies
    if [ -d "node_modules" ]; then
        echo "Dependencies: installed"
    else
        echo "Dependencies: NOT INSTALLED (run npm install)"
    fi

    # Check for lockfile
    if [ -f "package-lock.json" ]; then
        echo "Lockfile: npm"
    elif [ -f "yarn.lock" ]; then
        echo "Lockfile: yarn"
    elif [ -f "pnpm-lock.yaml" ]; then
        echo "Lockfile: pnpm"
    fi
fi

# Python project check
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
    echo ""
    echo "Python Project Detected"

    # Check Python version
    if command -v python3 &> /dev/null; then
        py_version=$(python3 --version 2>/dev/null)
        echo "Python: $py_version"
    elif command -v python &> /dev/null; then
        py_version=$(python --version 2>/dev/null)
        echo "Python: $py_version"
    fi

    # Check virtual environment
    if [ -d ".venv" ]; then
        echo "Virtual env: .venv found"
    elif [ -d "venv" ]; then
        echo "Virtual env: venv found"
    elif [ -n "$VIRTUAL_ENV" ]; then
        echo "Virtual env: active ($VIRTUAL_ENV)"
    else
        echo "Virtual env: not found"
    fi
fi

# Go project check
if [ -f "go.mod" ]; then
    echo ""
    echo "Go Project Detected"
    if command -v go &> /dev/null; then
        go_version=$(go version 2>/dev/null | awk '{print $3}')
        echo "Go: $go_version"
    fi
fi

# Rust project check
if [ -f "Cargo.toml" ]; then
    echo ""
    echo "Rust Project Detected"
    if command -v rustc &> /dev/null; then
        rust_version=$(rustc --version 2>/dev/null | awk '{print $2}')
        echo "Rust: $rust_version"
    fi
fi

# Build status (if using project template)
if [ -f "docs/project/build-status.md" ]; then
    echo ""
    echo "Project Status"

    # Extract current phase
    phase=$(grep -m1 "Current Phase" docs/project/build-status.md 2>/dev/null | sed 's/.*: //' || echo "")
    if [ -n "$phase" ]; then
        echo "Phase: $phase"
    fi

    # Extract progress if available
    progress=$(grep -m1 "Progress" docs/project/build-status.md 2>/dev/null | sed 's/.*: //' || echo "")
    if [ -n "$progress" ]; then
        echo "Progress: $progress"
    fi
fi

echo ""
echo "------------------------"
echo "Ready. Model recommendation will appear based on your task."
echo ""
