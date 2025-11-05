# Context Management Thresholds

**Single Source of Truth for Context Management**

This document defines the context/token thresholds used across all projects in the workspace.

---

## Token Budget Overview

Claude Code provides a **200,000 token context window** per session.

**Breakdown:**
- Total available: 200,000 tokens
- Workspace overhead: ~2% (4,000 tokens)
- **Available for coding:** ~196,000 tokens (98%)

---

## Health Zones

| Zone | Tokens | Percentage | Status | Action |
|------|--------|------------|--------|--------|
| 🟢 **Green** | < 140,000 | < 70% | Excellent | Continue normally |
| 🟡 **Yellow** | 140,000 - 170,000 | 70% - 85% | Good | Note for later, finish current task |
| 🟠 **Orange** | 170,000 - 190,000 | 85% - 95% | Caution | Clear context after current task |
| 🔴 **Red** | > 190,000 | > 95% | Critical | Clear immediately |

---

## Detailed Guidelines

### 🟢 Green Zone (< 70% / < 140K tokens)

**Status:** Smooth sailing

**What it means:**
- Plenty of context headroom
- Can load large files freely
- Room for experimentation
- Multiple iterations possible

**What to do:**
- Continue work normally
- Focus on productivity, not token usage
- Load files as needed
- Explore and iterate freely

**Next check:**
- After major milestone (phase completion)
- At ~100K tokens
- When loading many new files

**Capacity:**
- Can typically complete 3-4 major features
- 2-3 more phases at current pace
- Full refactoring sessions

---

### 🟡 Yellow Zone (70-85% / 140-170K tokens)

**Status:** Approaching limit

**What it means:**
- Context filling up
- Should start thinking about clearing
- Still safe to work
- Be mindful of token usage

**What to do:**
- Finish your current task
- Avoid loading unnecessary files
- Consider clearing after current milestone
- Note this for later, don't interrupt flow

**Next check:**
- After current task completes
- At 160K tokens
- Before starting major new feature

**Capacity:**
- 1-2 major features remaining
- Enough for current phase completion
- Can complete testing/refinement

**Recommendation:**
```
You're at 75% capacity. Continue with current work,
but plan to clear context after this task completes.

Optimal clear point: After [next milestone]
```

---

### 🟠 Orange Zone (85-95% / 170-190K tokens)

**Status:** Clear soon

**What it means:**
- Context nearly full
- Should clear after current task
- Limited capacity remaining
- Risk of forced clear if you don't act

**What to do:**
1. Finish current task (don't abandon mid-work)
2. Say "Update status" to save everything
3. Run `/clear` to reset context
4. Resume with minimal token load

**Next check:**
- Continuously monitor
- Before starting anything new
- After any file loads

**Capacity:**
- 1 small task or bug fix
- Finish current feature only
- Emergency fixes acceptable
- NO new major features

**Warning:**
```
⚠️ Context at 88%. You should clear soon.

You have ~24,000 tokens remaining (12% capacity).
This is enough to finish [current task] but not much more.

Recommended workflow:
1. Complete [current task]
2. Say "Update status"
3. Run /clear
4. Resume fresh: "Check the build status"

Continue with current task?
```

---

### 🔴 Red Zone (> 95% / > 190K tokens)

**Status:** Critical - Clear now

**What it means:**
- Context overflow imminent
- Forced clear may happen
- No room for new work
- Risk of losing progress

**What to do:**
**IMMEDIATELY:**
1. Stop current work
2. Agent will auto-run "Update status"
3. You run `/clear`
4. Resume: "Check the build status and tell me where we are at"

**DON'T:**
- Start new features
- Load more files
- Continue without clearing
- Ignore this warning

**Automatic action:**
```
🔴 CRITICAL: Context at 96%

I'm saving your progress now...

✓ Session logged to .session-log.md
✓ BUILD-STATUS.md updated
✓ Changes committed to git
✓ All progress saved

You MUST clear context now.

Please run: /clear

After clearing, say:
"Check the build status and tell me where we are at"

This will load only ~4K tokens and you'll be
back to 98% capacity with full context restored.
```

---

## Context Clear Workflow

### When to Clear

**Recommended times:**
- After completing a phase
- After major milestone/feature
- When reaching 70-85% capacity
- Before starting large new feature
- End of work session

**Poor times:**
- Mid-feature implementation
- During debugging session
- While fixing broken code
- In the middle of refactoring

### How to Clear

**3-Step Process:**

**Step 1: Save Everything**
```
You: "Update status"

Claude: [Analyzes session, updates all status files,
        commits to git, provides summary]

✓ All progress saved
```

**Step 2: Clear Context**
```
You: /clear

[Context cleared - conversation history removed]
```

**Step 3: Resume**
```
You: "Check the build status and tell me where we are at"

Claude: [Loads only BUILD-STATUS.md (~3K tokens),
        provides current status, ready to continue]

You're back to 2% usage with full knowledge of project!
```

### Resume Cost

**Token usage after clear:**
- BUILD-STATUS.md: ~3K tokens
- Current conversation: ~1K tokens
- **Total: ~4K tokens (2%)**

You get back **196K tokens** (98%) for work!

---

## Token Consumption Patterns

### Typical Session Evolution

```
Session start:     2K tokens  (1%)   [Load BUILD-STATUS]
After 30 min:     25K tokens  (12%)  [Planning + first feature]
After 1 hour:     55K tokens  (27%)  [Feature implementation]
After 2 hours:    95K tokens  (47%)  [Refinement + testing]
After 3 hours:   145K tokens  (72%)  [Multiple features]
After 4 hours:   185K tokens  (92%)  [Should have cleared!]
```

**Lesson:** Clear around 2-3 hour mark for long sessions.

### What Consumes Tokens

| Activity | Token Cost | Notes |
|----------|------------|-------|
| Reading file (500 lines) | ~2K | Adds to context |
| Editing file | ~2K | Keeps file in memory |
| Conversation turn | ~200-500 | Accumulates quickly |
| Planning discussion | ~3-5K | Per major topic |
| Debugging session | ~5-10K | Lots of back-and-forth |
| Code review | ~3-7K | Depends on code size |
| Loading BUILD-STATUS | ~3K | One-time per session |

### High Token Activities

**These burn tokens fast:**
- Reading multiple large files
- Iterative debugging (many attempts)
- Extensive refactoring
- Code reviews of large modules
- Exploring unfamiliar codebases

**Token-efficient activities:**
- Focused feature implementation
- Writing new code (vs reading old)
- Following clear plan
- Working in small files
- Using custom commands (vs free discussion)

---

## Monitoring Context

### Automatic Monitoring

Claude Code agents automatically monitor context and alert you:

- At 70%: Gentle reminder
- At 85%: Recommendation to clear
- At 95%: Urgent warning + auto-save

### Manual Check

Use the custom command:
```
"Check context"
```

Gets detailed report:
- Current usage
- Token breakdown
- Health status
- Recommendations
- Estimated remaining capacity

### Check Frequency

**Automatic checks:**
- After phase completion
- Every ~50K token increment
- Before major new work

**Manual checks:**
- When you feel lost in conversation
- Before starting large feature
- After loading many files
- If session feels slow

---

## Best Practices

### ✅ Do

- Clear context proactively (don't wait for red zone)
- Clear at natural breakpoints (phases, features)
- Use "Update status" before clearing
- Resume with BUILD-STATUS load
- Monitor context during long sessions
- Plan clears around your schedule

### ❌ Don't

- Ignore yellow/orange warnings
- Wait until red zone
- Clear mid-task
- Skip "Update status" before clearing
- Fear clearing (it's safe!)
- Let context fill up unknowingly

---

## Multi-Project Considerations

### Workspace Token Budget

When working across multiple projects:

**Per project overhead:**
- .status file: ~100 tokens
- Conversation context: ~500 tokens

**Workspace overhead:**
- .session-log.md: ~150 tokens
- Multiple .status files: ~400 tokens
- Current BUILD-STATUS: ~3K tokens
- **Total: ~4K tokens (2%)**

**Recommendation:**
Focus on one project per session to preserve context.

### Switching Projects

**When switching projects mid-session:**

```
Current tokens: 85K (42%)

Switching from: project-a → project-b

Token impact:
- Keep: Conversation context (~40K)
- Unload: project-a BUILD-STATUS (~3K)
- Load: project-b BUILD-STATUS (~3K)
- Net change: ~0K

New total: ~85K (42%)
```

Usually minimal impact, but monitor if switching frequently.

---

## Emergency Situations

### Forced Clear (Context Overflow)

If context hits 100%, Claude may force clear:

**What happens:**
- Conversation resets
- Files unloaded
- Session history lost

**What's preserved:**
- All files on disk (unchanged)
- Git commits (if you committed)
- BUILD-STATUS.md (if recently saved)

**How to recover:**
1. Don't panic
2. Say: "Check the build status and tell me where we are at"
3. Resume from documented state
4. Continue work

**Prevention:**
- Monitor context proactively
- Clear at yellow/orange zones
- Use "Update status" regularly

---

## Version History

- **v1.0** (Nov 2025) - Initial threshold definitions
- Aligned with 200K context window
- Optimized for workspace + project structure

---

## References

- **Context check command:** `.workspace/commands/check-context.md`
- **Status update command:** `.workspace/commands/update-status.md`
- **Workspace guide:** `.workspace/README.md`

---

**Quick Reference:**

🟢 < 70% → Keep working
🟡 70-85% → Finish task, plan to clear
🟠 85-95% → Clear after current task
🔴 > 95% → Clear immediately

**Clear workflow:** "Update status" → /clear → "Check the build status"
