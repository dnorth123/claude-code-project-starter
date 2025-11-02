# Example Simple Project

This is an example of a simple project that doesn't need full BUILD-STATUS.md tracking.

## Setup

For simple projects like this, just use a `.status` file:

```bash
echo "Status: Brief description | $(date +%Y-%m-%d)" > .status
```

## Usage

Update your status as you work:
- Manually edit `.status` file
- Or use Claude Code's "update status" command
