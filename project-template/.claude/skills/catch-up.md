---
name: catch-up
description: Summarize recent project progress after being away
triggers: [catch up, catch me up, what happened, summarize progress, what's been done, recent changes, since last time]
---

# Catch-Up Skill

## Purpose

Quickly rebuild your context after stepping away from a project. This skill filters files by creation/modification date in your project directory to summarize what changed.

> "Use Claude to summarize progress by asking it to 'catch me up on the last few days of research.' It can filter files by creation date in your project directory to rebuild your context after a break."

## Prerequisites

- Project with modification history (git preferred)
- Clear file organization
- Regular commits with descriptive messages (ideal)

## Workflow

### Step 1: Identify Time Range

Determine the lookback period:
- "last few days" → 3 days
- "this week" → 7 days
- "since Monday" → Calculate days
- Specific date → From that date

### Step 2: Gather Changes

Using Explore agent and git:

```bash
# Recent file changes
find . -type f -mtime -[DAYS] -not -path './.git/*' | head -50

# Git commits in range
git log --oneline --since="[DAYS] days ago"

# Changed files
git diff --stat HEAD~[COMMITS]
```

### Step 3: Categorize Changes

Group findings by:
- **Features Added**: New functionality
- **Bugs Fixed**: Issues resolved
- **Refactoring**: Code improvements
- **Documentation**: Doc updates
- **Configuration**: Settings/env changes

### Step 4: Summarize Progress

Create a structured summary with:
- Key accomplishments
- Current state
- In-progress work
- Blockers or issues
- Suggested next steps

## Output Format

```markdown
# Catch-Up Summary: [Project Name]

**Period**: [Start Date] → [End Date]
**Commits**: [N] commits
**Files Changed**: [N] files

## Key Accomplishments

### Features
- ✅ [Feature 1]: [Brief description]
- ✅ [Feature 2]: [Brief description]

### Fixes
- 🐛 [Bug fix description]

### Other
- 📝 [Documentation/config changes]

## Current State

**Phase**: [Current phase]
**Status**: [Overall status]
**Last Activity**: [Most recent change]

## In Progress

- 🔄 [Work item in progress]
- 🔄 [Another in-progress item]

## Blockers / Issues

- ⚠️ [Any blockers or concerns]

## Suggested Next Steps

1. [Immediate next action]
2. [Following action]
3. [Future consideration]

## Recent Commits

| Date | Message |
|------|---------|
| [date] | [commit message] |
| [date] | [commit message] |

## Files Changed

[List of significantly modified files]
```

## Example

**Input**: "Catch me up on the last 3 days"

**Process**:
1. Query git for commits since 3 days ago
2. Find modified files in that range
3. Read commit messages for context
4. Check build-status.md for tracked progress
5. Compile summary

**Output**:
```markdown
# Catch-Up Summary: E-commerce App

**Period**: Jan 9 → Jan 12, 2026
**Commits**: 8 commits
**Files Changed**: 23 files

## Key Accomplishments

### Features
- ✅ User authentication: Implemented login/register with JWT
- ✅ Product catalog: Added product listing page with filters

### Fixes
- 🐛 Fixed cart total calculation rounding error
- 🐛 Resolved mobile menu z-index issue

## Current State

**Phase**: Phase 2 - Core Features
**Status**: 65% complete
**Last Activity**: Added product search endpoint (2 hours ago)

## In Progress

- 🔄 Shopping cart persistence (started, ~40% done)

## Suggested Next Steps

1. Complete cart persistence implementation
2. Add checkout flow (next major feature)
3. Consider adding product reviews (deferred to Phase 3)
```

## Integration with Project Docs

When `docs/project/build-status.md` exists:
- Cross-reference with tracked tasks
- Update status if changes detected
- Note discrepancies between git and docs

## Tips

- More descriptive commit messages = better summaries
- Regular "Update status" commands keep docs accurate
- Use with build-status.md for complete picture

---

*This skill helps maintain continuity across work sessions.*
