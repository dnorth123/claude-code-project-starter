#!/bin/bash
# Claude Code Pre-Commit Hook (Validated)
# Requires user confirmation before running
# May modify files (linting/formatting)
#
# This hook runs linting and formatting before commits.
# It may automatically fix issues, which modifies files.

set -e

echo ""
echo "Pre-Commit Validation"
echo "---------------------"
echo ""

# Detect project type and available tools
has_lint=false
has_format=false
commands_to_run=""

# Node.js project
if [ -f "package.json" ]; then
    # Check for lint script
    if grep -q '"lint"' package.json 2>/dev/null; then
        has_lint=true
        commands_to_run+="npm run lint\n"
        echo "Found: npm run lint"
    fi

    # Check for format script
    if grep -q '"format"' package.json 2>/dev/null; then
        has_format=true
        commands_to_run+="npm run format\n"
        echo "Found: npm run format"
    fi

    # Check for type checking
    if grep -q '"typecheck"' package.json 2>/dev/null || grep -q '"type-check"' package.json 2>/dev/null; then
        commands_to_run+="npm run typecheck (or type-check)\n"
        echo "Found: TypeScript checking"
    fi
fi

# Python project
if [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "requirements.txt" ]; then
    # Check for ruff
    if command -v ruff &> /dev/null; then
        has_lint=true
        commands_to_run+="ruff check .\n"
        echo "Found: ruff (linter)"
    fi

    # Check for black
    if command -v black &> /dev/null; then
        has_format=true
        commands_to_run+="black .\n"
        echo "Found: black (formatter)"
    fi

    # Check for mypy
    if command -v mypy &> /dev/null; then
        commands_to_run+="mypy .\n"
        echo "Found: mypy (type checker)"
    fi
fi

# Go project
if [ -f "go.mod" ]; then
    if command -v gofmt &> /dev/null; then
        has_format=true
        commands_to_run+="gofmt -w .\n"
        echo "Found: gofmt"
    fi

    if command -v golangci-lint &> /dev/null; then
        has_lint=true
        commands_to_run+="golangci-lint run\n"
        echo "Found: golangci-lint"
    fi
fi

# Rust project
if [ -f "Cargo.toml" ]; then
    has_format=true
    has_lint=true
    commands_to_run+="cargo fmt\n"
    commands_to_run+="cargo clippy\n"
    echo "Found: cargo fmt, cargo clippy"
fi

echo ""
echo "---------------------"

if [ -z "$commands_to_run" ]; then
    echo "No linting/formatting tools detected."
    echo "Consider adding:"
    echo "  - ESLint/Prettier for JavaScript/TypeScript"
    echo "  - Ruff/Black for Python"
    echo "  - gofmt for Go"
    echo "  - rustfmt for Rust"
    exit 0
fi

echo ""
echo "This will run the following commands:"
echo ""
echo -e "$commands_to_run"
echo ""
echo "WARNING: These tools may auto-fix issues and modify your files."
echo ""
echo "Proceed? [y/N] "
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Running pre-commit validation..."
    echo ""

    exit_code=0

    # Node.js
    if [ -f "package.json" ]; then
        if grep -q '"lint"' package.json 2>/dev/null; then
            echo ">>> npm run lint"
            npm run lint || exit_code=$?
        fi
        if grep -q '"format"' package.json 2>/dev/null; then
            echo ">>> npm run format"
            npm run format || exit_code=$?
        fi
    fi

    # Python
    if [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
        if command -v ruff &> /dev/null; then
            echo ">>> ruff check --fix ."
            ruff check --fix . || exit_code=$?
        fi
        if command -v black &> /dev/null; then
            echo ">>> black ."
            black . || exit_code=$?
        fi
    fi

    # Go
    if [ -f "go.mod" ]; then
        if command -v gofmt &> /dev/null; then
            echo ">>> gofmt -w ."
            gofmt -w . || exit_code=$?
        fi
    fi

    # Rust
    if [ -f "Cargo.toml" ]; then
        echo ">>> cargo fmt"
        cargo fmt || exit_code=$?
        echo ">>> cargo clippy"
        cargo clippy || exit_code=$?
    fi

    echo ""
    if [ $exit_code -eq 0 ]; then
        echo "Pre-commit validation passed!"
    else
        echo "Pre-commit validation completed with warnings/errors."
    fi

    exit $exit_code
else
    echo "Cancelled."
    exit 0
fi
