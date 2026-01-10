# Claude Code Hooks

> **Version**: 3.0
> **Purpose**: Automated session management and validation

## Overview

Hooks are shell scripts that Claude Code can execute at specific points during a session. They're organized into two categories:

| Category | Behavior | Purpose |
|----------|----------|---------|
| **Auto** | Runs automatically, no confirmation | Safe, informational operations |
| **Validated** | Requires user confirmation | Operations that modify files or take time |

---

## Directory Structure

```
.claude/hooks/
├── auto/                    # Auto-run hooks
│   └── session-start.sh     # Environment check on session start
├── validated/               # User-confirmed hooks
│   ├── pre-commit.sh        # Lint/format before commits
│   └── test-runner.sh       # Run test suite
└── README.md                # This file
```

---

## Auto Hooks

### session-start.sh

**Purpose**: Provides environment context at session start

**What It Checks**:
- Git branch and status
- Node.js/Python/Go/Rust detection
- Dependency installation status
- Virtual environment status
- Project build status (if using template)

**Output**: Informational only, makes no changes

**Trigger**: Automatically on session start (via SessionStart hook in settings)

---

## Validated Hooks

### pre-commit.sh

**Purpose**: Run linting and formatting before commits

**What It Does**:
- Detects project type and available tools
- Runs linters (ESLint, Ruff, golangci-lint, Clippy)
- Runs formatters (Prettier, Black, gofmt, rustfmt)
- May auto-fix issues (modifies files)

**Why Validated**: Can modify your files

**Invoke**: "Run pre-commit checks" or before committing

---

### test-runner.sh

**Purpose**: Run the project's test suite

**What It Does**:
- Detects test framework (Jest, pytest, go test, cargo test)
- Runs full test suite
- Reports results

**Why Validated**: Can take significant time

**Invoke**: "Run the tests" or "Run test suite"

---

## Configuration

Hooks are configured in `.claude/settings.local.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "command": "bash .claude/hooks/auto/session-start.sh",
        "timeout": 10000
      }
    ]
  }
}
```

### Hook Options

| Option | Description | Default |
|--------|-------------|---------|
| `command` | Shell command to execute | Required |
| `timeout` | Max execution time (ms) | 30000 |
| `silent` | Suppress output | false |

---

## Creating Custom Hooks

### Auto Hook Template

Place in `.claude/hooks/auto/`:

```bash
#!/bin/bash
# Description of what this hook does
# IMPORTANT: Auto hooks should be:
#   - Non-destructive (don't modify files)
#   - Fast (< 10 seconds)
#   - Informational only

set -e

# Your informational checks here
echo "Status: everything looks good"
```

### Validated Hook Template

Place in `.claude/hooks/validated/`:

```bash
#!/bin/bash
# Description of what this hook does
# IMPORTANT: Validated hooks should:
#   - Clearly explain what will happen
#   - Ask for confirmation before destructive actions
#   - Handle cancellation gracefully

set -e

echo "This hook will [describe action]"
echo ""
echo "Proceed? [y/N] "
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    # Perform the action
    echo "Running..."
else
    echo "Cancelled."
    exit 0
fi
```

---

## Best Practices

### For Auto Hooks

1. **Keep them fast** - Under 10 seconds
2. **Never modify files** - Information only
3. **Fail gracefully** - Don't block session start
4. **Be informative** - Provide useful context

### For Validated Hooks

1. **Explain clearly** - What will happen?
2. **Show what will be affected** - Files, time estimate
3. **Always confirm** - Never assume consent
4. **Handle cancellation** - Clean exit on "no"

---

## Adding Hooks to settings.local.json

To enable a hook, add it to the appropriate hook point:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "command": "bash .claude/hooks/auto/session-start.sh",
        "timeout": 10000
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash(git commit:*)",
        "command": "bash .claude/hooks/validated/pre-commit.sh"
      }
    ]
  }
}
```

### Available Hook Points

| Hook Point | When It Runs |
|------------|--------------|
| `SessionStart` | When Claude Code session begins |
| `PreToolUse` | Before a specific tool is used |
| `PostToolUse` | After a specific tool completes |

---

## Troubleshooting

### Hook Not Running

1. Check file permissions: `chmod +x .claude/hooks/auto/session-start.sh`
2. Verify path in settings.local.json
3. Check timeout isn't too short

### Hook Failing

1. Run manually: `bash .claude/hooks/auto/session-start.sh`
2. Check for missing dependencies
3. Review error messages

### Hook Blocking Session

1. Increase timeout in settings
2. Make hook fail gracefully (don't use `set -e` for non-critical checks)
3. Move slow operations to validated hooks

---

*Last Updated: January 2026*
*Template Version: 3.0*
