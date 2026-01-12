# Ralph: Autonomous Agent Loop

> **Version**: 1.0
> **Type**: Autonomous Development Pattern
> **Origin**: Geoffrey Huntley's Ralph Wiggum Technique

## Overview

Ralph is an **autonomous AI agent loop** that runs Claude Code repeatedly until all tasks are complete. Unlike single-shot AI interactions, Ralph implements a "fresh context loop" where each iteration gets clean context while maintaining persistence through files and git history.

**Core Philosophy**: The repository IS the memory. Context windows fill up, but git history and structured files persist forever.

```
┌─────────────────────────────────────────────────────────┐
│                     RALPH LOOP                          │
│                                                         │
│   1. Read prd.json → Find incomplete tasks              │
│   2. Select highest-priority story                      │
│   3. Spawn fresh Claude instance with context files     │
│   4. Claude implements single story                     │
│   5. Run quality checks (tests, typecheck, lint)        │
│   6. If passes → commit, update prd.json, progress.txt  │
│   7. If all done → exit, else → goto step 1             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## When to Use Ralph

### Good Use Cases

| Scenario | Why Ralph Works |
|----------|-----------------|
| Well-defined features with tests | Clear completion criteria |
| Overnight/unattended development | Autonomous execution |
| Batch migrations (React 16→19) | Mechanical, testable changes |
| Large refactors with clear scope | Incremental, verifiable progress |
| Greenfield with specifications | Can iterate toward defined goals |
| Test coverage expansion | Tests are self-verifying |

### When NOT to Use Ralph

| Scenario | Why Ralph Fails |
|----------|-----------------|
| Exploratory work | No clear "done" state |
| Architecture decisions | Needs human judgment |
| Security-critical code | Requires human review |
| Ambiguous requirements | Loop won't converge |
| Performance optimization (vague) | "Faster" isn't measurable |
| UX/design decisions | No objective criteria |
| Small tasks (<30 min) | Ralph is overkill |

**The Litmus Test**: Can you write a function that returns true when complete WITHOUT any LLM involvement in that decision? If no, don't use Ralph.

---

## Core Concepts

### Fresh Context Philosophy

Each Ralph iteration starts with **clean AI context**. This is intentional:

- Prevents context pollution (failed attempts confusing the model)
- Allows tasks exceeding single context windows
- Forces persistence through files, not memory
- Enables overnight/multi-day autonomous work

### Memory Persistence

Ralph maintains memory through THREE files only:

| File | Purpose | Format |
|------|---------|--------|
| `prd.json` | Task list with completion status | JSON with `passes: true/false` |
| `progress.txt` | Accumulated learnings | Markdown log |
| Git history | Code changes and commits | Commit messages |

### Task Granularity

**Critical**: Each story must fit in ONE context window.

```
❌ TOO BIG:
   "Build entire authentication system"
   "Create admin dashboard"
   "Implement payment processing"

✅ RIGHT SIZE:
   "Add login form with email/password fields"
   "Add email format validation"
   "Create /api/auth/login endpoint"
   "Add session cookie handling"
```

### Acceptance Criteria

Must be **explicit and verifiable**:

```
❌ VAGUE:
   - "Users can log in"
   - "Form works correctly"
   - "Handle errors properly"

✅ EXPLICIT:
   - "Email field validates format with regex"
   - "Error message appears below invalid field"
   - "typecheck passes"
   - "npm test passes"
   - "Verify at localhost:3000/login"
```

---

## File Structure

```
.claude/
├── ralph/
│   ├── ralph.sh           # Orchestration loop
│   ├── PROMPT.md          # Per-iteration instructions
│   ├── prd.json           # Task tracking
│   └── progress.txt       # Learnings log
```

### prd.json Format

```json
{
  "projectName": "Feature Name",
  "branchName": "ralph/feature-name",
  "userStories": [
    {
      "id": "US-001",
      "title": "Add user registration form",
      "acceptanceCriteria": [
        "Email and password fields present",
        "Email format validation",
        "Password minimum 8 characters",
        "Submit button disabled until valid",
        "typecheck passes",
        "tests pass"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

### progress.txt Format

```markdown
# Ralph Progress Log
Started: 2026-01-12
Project: Feature Name

## Codebase Patterns
<!-- Reusable patterns discovered during development -->
- Migrations: Use IF NOT EXISTS for idempotency
- Components: Export from index.ts barrel files
- Tests: Use data-testid for element selection

## Key Files
<!-- Important files for this feature -->
- src/auth/login.tsx
- src/api/auth/route.ts
- tests/auth.test.ts

---
<!-- Ralph appends learnings below this line -->

## 2026-01-12 - US-001
- Implemented login form component
- Files changed: src/auth/login.tsx, src/auth/login.test.tsx
- **Learnings:**
  - Form validation uses react-hook-form
  - Error states stored in form context
---
```

---

## Running Ralph

### Basic Usage

```bash
# Run with default 10 iterations
./.claude/ralph/ralph.sh

# Run with custom iteration limit
./.claude/ralph/ralph.sh 25

# Run with extended timeout (for complex tasks)
./.claude/ralph/ralph.sh 50
```

### What Happens

1. Ralph reads `prd.json` and finds first story where `passes: false`
2. Spawns Claude Code with `PROMPT.md` instructions
3. Claude implements the story, runs tests
4. If tests pass, Claude commits and marks `passes: true`
5. Claude appends learnings to `progress.txt`
6. Loop continues until all stories pass or limit reached

### Stop Conditions

Ralph stops when:
- All stories have `passes: true`
- Claude outputs `<promise>COMPLETE</promise>`
- Maximum iterations reached
- Circuit breaker triggers (no changes in 3 iterations)

---

## Safety Mechanisms

### Circuit Breaker

Ralph includes automatic stall detection:

```bash
# Stops if no git changes in 3 consecutive iterations
# Prevents infinite loops on impossible tasks
```

### Iteration Limits

**Always use `--max-iterations`**. This is your safety net.

```bash
# Recommended starting point
./.claude/ralph/ralph.sh 20

# For larger features
./.claude/ralph/ralph.sh 50
```

### Cost Awareness

Ralph iterations consume API tokens. Approximate costs:

| Iterations | Estimated Cost* |
|------------|-----------------|
| 10 | $5-15 |
| 25 | $15-40 |
| 50 | $30-100 |

*Varies based on codebase size and task complexity.

### Sandboxing Recommendation

For autonomous execution, consider:

- Running in disposable cloud VM
- Using Docker container
- Git worktree for isolation
- Separate branch for Ralph work

---

## Common Pitfalls

### 1. Context Pollution

**Problem**: Failed attempts accumulate and confuse the model.

**Solution**: Fresh context per iteration (Ralph's core design). If you see degrading quality, the PRD may be too vague.

### 2. Vague Completion Criteria

**Problem**: Loop runs forever or declares false victory.

**Solution**: Add explicit, testable criteria:
```json
"acceptanceCriteria": [
  "npm run typecheck exits with code 0",
  "npm test exits with code 0",
  "No console errors in browser dev tools"
]
```

### 3. Oversized Stories

**Problem**: Single story exceeds context window.

**Solution**: Break down further:
```
❌ "Implement user authentication"

✅ "US-001: Add login form UI"
✅ "US-002: Add form validation"
✅ "US-003: Create login API endpoint"
✅ "US-004: Add session management"
✅ "US-005: Add logout functionality"
```

### 4. Missing Quality Gates

**Problem**: Broken code compounds across iterations.

**Solution**: Every story must include:
```json
"acceptanceCriteria": [
  "... feature criteria ...",
  "typecheck passes",
  "tests pass",
  "lint passes"
]
```

### 5. Interactive Prompts

**Problem**: Claude gets stuck on interactive CLI prompts.

**Solution**: Pre-answer or skip prompts:
```bash
# Bad: Gets stuck
npm init

# Good: Non-interactive
npm init -y
echo -e "\n\n\n" | npx some-cli
```

---

## Integration with Project Starter

### Using Existing Documentation

Convert your `docs/project/project-plan.md` to Ralph format:

```bash
# Use the /ralph-init command
/ralph-init
```

This generates `prd.json` from your existing project documentation.

### Quality Gates

Ralph integrates with existing validated hooks:

```bash
# These run during each iteration
.claude/hooks/validated/pre-commit.sh   # Linting, formatting
.claude/hooks/validated/test-runner.sh  # Test execution
```

### Progress Sync

Ralph's `progress.txt` complements `docs/project/build-status.md`:
- `progress.txt` = Machine-readable iteration log
- `build-status.md` = Human-readable project status

After Ralph completes, run "Update status" to sync progress.

---

## Model Recommendations

| Ralph Phase | Recommended Model | Why |
|-------------|-------------------|-----|
| PRD generation | Sonnet 4.5 | Good at structuring requirements |
| Implementation iterations | Sonnet 4.5 | Balanced speed/capability |
| Complex debugging | Opus 4.5 | Deeper reasoning needed |
| Simple file changes | Haiku 4.5 | Fast, cost-effective |

**Note**: Opus 4.5's improved context management means some tasks that previously needed Ralph can now complete in a single session. Consider Ralph for tasks requiring 10+ iterations.

---

## Quick Reference

### Commands

| Command | Description |
|---------|-------------|
| `/ralph-init` | Generate prd.json from project-plan.md |
| `./.claude/ralph/ralph.sh 25` | Run Ralph with 25 iteration limit |

### Key Files

| File | Purpose |
|------|---------|
| `.claude/ralph/prd.json` | Task definitions and status |
| `.claude/ralph/progress.txt` | Accumulated learnings |
| `.claude/ralph/PROMPT.md` | Per-iteration instructions |
| `.claude/ralph/ralph.sh` | Orchestration loop |

### Completion Signal

When all tasks are done, Claude outputs:
```
<promise>COMPLETE</promise>
```

---

## Troubleshooting

### "Loop not stopping"

1. Check if all stories have `passes: true` in prd.json
2. Verify completion criteria are achievable
3. Check for failing tests blocking progress
4. Review progress.txt for repeated errors

### "Same error every iteration"

1. The task may be impossible as specified
2. Break the story into smaller pieces
3. Add more explicit acceptance criteria
4. Check for external dependencies

### "Context seems polluted"

1. This shouldn't happen with fresh contexts
2. Check if prd.json has clear, independent stories
3. Review progress.txt for conflicting learnings
4. Consider resetting progress.txt patterns section

### "Costs too high"

1. Reduce iteration limit
2. Break project into smaller Ralph sessions
3. Use Haiku for simple iterations (not yet supported)
4. Review if Ralph is the right tool for this task

---

## Future Enhancements (Layer 3)

The following integrations are documented for potential future implementation:

### External Tools

- **ralph-orchestrator**: Production-ready Python orchestrator with multi-agent support, git checkpointing, and cost limits in USD
- **vercel-labs/ralph-loop-agent**: TypeScript AI SDK integration with custom verification functions
- **Official Claude Code Plugin**: `/ralph-loop` command (note: has known issues, see sources)

### Potential Features

- Cost limits in USD (not just iterations)
- Multi-model committee for code review
- Parallel story execution
- CI/CD pipeline integration
- Dashboard for monitoring progress

---

## Sources & Attribution

- [Original Ralph Pattern](https://ghuntley.com/ralph/) - Geoffrey Huntley
- [snarktank/ralph](https://github.com/snarktank/ralph) - Original implementation
- [frankbria/ralph-claude-code](https://github.com/frankbria/ralph-claude-code) - Claude Code specific
- [ralph-orchestrator](https://github.com/mikeyobrien/ralph-orchestrator) - Production orchestrator
- [vercel-labs/ralph-loop-agent](https://github.com/vercel-labs/ralph-loop-agent) - AI SDK implementation
- [Ryan Carson's Guide](https://x.com/ryancarson) - Practical implementation guide
- [DEV Community](https://dev.to/alexandergekov/2026-the-year-of-the-ralph-loop-agent-1gkj) - Community best practices

---

*Last Updated: January 2026*
*Template Version: 3.0*
