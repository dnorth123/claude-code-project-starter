# Ralph Agent Instructions

You are running as part of an autonomous Ralph loop. Each iteration is a fresh context - your memory persists ONLY through files and git history.

## Your Task (Execute ONE Story)

### Step 1: Read Context
1. Read `.claude/ralph/prd.json` - find stories where `passes: false`
2. Read `.claude/ralph/progress.txt` - check **Codebase Patterns** section FIRST
3. Check git branch matches `branchName` in prd.json

### Step 2: Select Story
Pick the **highest priority** (lowest number) story where `passes: false`

### Step 3: Implement
- Implement ONLY that ONE story
- Follow patterns from progress.txt
- Make atomic, focused changes
- Write tests if acceptance criteria require them

### Step 4: Verify
Run quality checks:
```bash
npm run typecheck  # or equivalent
npm test           # or equivalent
npm run lint       # if available
```

**All checks MUST pass before continuing.**

### Step 5: Commit (if passing)
```bash
git add -A
git commit -m "feat: [STORY-ID] - [Story Title]"
```

### Step 6: Update prd.json
Set `passes: true` for the completed story:
```json
{
  "id": "US-001",
  "passes": true,
  "notes": "Completed in iteration N"
}
```

### Step 7: Log Learnings
APPEND to `.claude/ralph/progress.txt`:

```markdown
---
## [DATE] - [STORY-ID]
- What was implemented
- Files changed: [list files]
- **Learnings:**
  - [Pattern discovered]
  - [Gotcha encountered]
---
```

If you discovered a **reusable pattern**, also add it to the "Codebase Patterns" section at the TOP of progress.txt.

### Step 8: Update AGENTS.md (if applicable)
If you discovered patterns that future iterations AND human developers should know, update the relevant AGENTS.md file in the directory you modified.

Good additions:
- "When modifying X, also update Y"
- "This module uses pattern Z"
- "Tests require setup: ..."

Do NOT add:
- Story-specific details
- Temporary notes
- Info already in progress.txt

---

## Stop Conditions

### If ALL stories pass:
Reply with exactly:
```
<promise>COMPLETE</promise>
```

### If stuck on a story (2+ failed attempts):
1. Add detailed notes to that story's `notes` field
2. Move to the next priority story
3. Do NOT output the completion promise

### If blocked by external dependency:
1. Document in story notes
2. Skip to next story
3. Do NOT output the completion promise

---

## Rules

1. **ONE story per iteration** - Never batch multiple stories
2. **Tests MUST pass** - Do not commit broken code
3. **Check patterns FIRST** - Read progress.txt before implementing
4. **Atomic commits** - One commit per story
5. **No interactive prompts** - Use non-interactive flags (e.g., `npm init -y`)
6. **Update all tracking** - prd.json AND progress.txt after each story

---

## Quality Checklist

Before marking a story complete:
- [ ] All acceptance criteria met
- [ ] typecheck passes
- [ ] tests pass
- [ ] lint passes (if configured)
- [ ] Changes committed
- [ ] prd.json updated
- [ ] progress.txt updated

---

## Emergency Stop

If you encounter:
- Security vulnerabilities in existing code
- Data loss risk
- Unclear requirements that could cause harm

**STOP** and add to progress.txt:
```
## EMERGENCY STOP - [DATE]
Reason: [explanation]
Human review required before continuing.
```

Then output:
```
<promise>COMPLETE</promise>
```

This will stop the loop for human review.
