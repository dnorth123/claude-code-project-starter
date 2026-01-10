#!/bin/bash
# Claude Code Test Runner Hook (Validated)
# Requires user confirmation before running
# May take significant time depending on test suite size
#
# This hook runs your project's test suite.

set -e

echo ""
echo "Test Runner"
echo "-----------"
echo ""

# Detect project type and test framework
test_command=""
test_framework=""

# Node.js project
if [ -f "package.json" ]; then
    # Check for test script
    if grep -q '"test"' package.json 2>/dev/null; then
        test_command="npm test"
        test_framework="npm test script"
    fi

    # Check for specific frameworks
    if [ -f "jest.config.js" ] || [ -f "jest.config.ts" ] || grep -q '"jest"' package.json 2>/dev/null; then
        test_framework="Jest"
    elif [ -f "vitest.config.js" ] || [ -f "vitest.config.ts" ]; then
        test_framework="Vitest"
    elif [ -f "playwright.config.js" ] || [ -f "playwright.config.ts" ]; then
        test_framework="Playwright"
        test_command="npx playwright test"
    fi
fi

# Python project
if [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "requirements.txt" ]; then
    if [ -f "pytest.ini" ] || [ -d "tests" ] || grep -q "pytest" pyproject.toml 2>/dev/null; then
        test_command="pytest"
        test_framework="pytest"
    elif [ -d "test" ]; then
        test_command="python -m unittest discover"
        test_framework="unittest"
    fi
fi

# Go project
if [ -f "go.mod" ]; then
    test_command="go test ./..."
    test_framework="go test"
fi

# Rust project
if [ -f "Cargo.toml" ]; then
    test_command="cargo test"
    test_framework="cargo test"
fi

if [ -z "$test_command" ]; then
    echo "No test framework detected."
    echo ""
    echo "Supported frameworks:"
    echo "  - Node.js: Jest, Vitest, Mocha, npm test script"
    echo "  - Python: pytest, unittest"
    echo "  - Go: go test"
    echo "  - Rust: cargo test"
    exit 0
fi

echo "Detected: $test_framework"
echo "Command: $test_command"
echo ""

# Estimate test count if possible
if [ "$test_framework" = "Jest" ] || [ "$test_framework" = "Vitest" ]; then
    test_files=$(find . -name "*.test.js" -o -name "*.test.ts" -o -name "*.spec.js" -o -name "*.spec.ts" 2>/dev/null | wc -l | tr -d ' ')
    echo "Test files found: ~$test_files"
elif [ "$test_framework" = "pytest" ]; then
    test_files=$(find . -name "test_*.py" -o -name "*_test.py" 2>/dev/null | wc -l | tr -d ' ')
    echo "Test files found: ~$test_files"
fi

echo ""
echo "-----------"
echo ""
echo "Run tests now? [y/N] "
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Running tests..."
    echo ""

    start_time=$(date +%s)

    # Run tests
    $test_command
    exit_code=$?

    end_time=$(date +%s)
    duration=$((end_time - start_time))

    echo ""
    echo "-----------"
    echo "Duration: ${duration}s"

    if [ $exit_code -eq 0 ]; then
        echo "Status: PASSED"
    else
        echo "Status: FAILED (exit code: $exit_code)"
    fi

    exit $exit_code
else
    echo "Cancelled."
    exit 0
fi
