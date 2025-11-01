# Project Structure

```
your-project/
├── docs/
│   └── project/
│       ├── build-status.md       # Current status tracking
│       ├── project-plan.md       # Project requirements
│       ├── tech-stack.md         # Technical decisions
│       └── phases/               # Detailed phase plans
│           ├── phase-1-foundation.md
│           ├── phase-2-features.md
│           └── phase-3-polish.md
├── .claude/
│   └── claude.md                 # Session context (auto-updated)
├── src/                          # Created during Phase 1
├── .gitignore
├── README.md
└── SETUP.md                      # This file
```

---

## Token Management

This system is designed to use tokens efficiently:

| Activity | Token Cost | % of Budget |
|----------|------------|-------------|
| **Planning** (one-time) | ~26K | 13% |
| **Phase start** | ~5K | 2.5% |
| **Resume session** | ~7K | 3.5% |
| **Status update** | ~3K | 1.5% |
| **Available for coding** | ~160-170K | 80-85% |

**Automatic monitoring** alerts you when context needs clearing (typically after each phase).

---

## Tips for Success

### 1. Update Status Regularly
```bash
# After completing a task or two
"Update status"
```
Keeps docs current and makes resuming easy.

### 2. Trust the Context Alerts
When Claude says to clear context:
- 🟢 Green: Keep going
- 🟡 Yellow: Note for later
- 🟠 Orange: Clear after current task
- 🔴 Red: Clear now

### 3. Use Git Tags
Claude will create git tags at phase completions:
- `phase-1-complete`
- `phase-2-complete`
- etc.

Easy to roll back if needed.

### 4. Session Breaks
Taking a break? Just say:
```bash
"Update status"
```
Then close Claude Code. Resume anytime with:
```bash
"Check the build status and tell me where we are at"
```

### 5. Keep Docs Lean
Don't over-document. The templates have the right balance.

---

## Example Session

```bash
# Day 1: Planning (30 min)
"Check the docs/project/ folder and help me get started"
[Answer Claude's questions]
[Claude creates phase plans]
"Start Phase 1"
[Build foundation]
"Update status"
# End session

# Day 2: Development (2 hours)
"Check the build status and tell me where we are at"
[Continue Phase 1]
"Phase 1 complete"
[Claude checks context: 🟢 Green]
"Start Phase 2"
[Build features]
"Update status"
# End session

# Day 3: More Development (2 hours)
"Check the build status and tell me where we are at"
[Continue Phase 2]
"Phase 2 complete"
[Claude checks context: 🟠 Orange - recommends clear]
"Save everything"
# Run /clear
"Check the build status and tell me where we are at"
"Start Phase 3"
[Polish and deploy]
"Phase 3 complete"
# Project done! 🎉
```

---

## Troubleshooting

### "Claude doesn't remember what we did last session"
- Make sure you ran `"Update status"` before ending
- Check that `docs/project/build-status.md` was updated
- Try: `"Read docs/project/build-status.md and .claude/claude.md"`

### "Context seems full but no alert"
- Manually check: `"Check context"`
- Claude will analyze and recommend

### "Lost my place in development"
- `"Check the build status and tell me where we are at"`
- Claude reads current status and suggests next steps

### "Want to change the plan mid-project"
- `"I want to change the plan - [describe change]"`
- Claude updates docs and adjusts phase plans

---

## Support

This is a template for personal use. Customize as needed!

**Common customizations:**
- Add more sections to build-status.md
- Create custom phase templates
- Adjust context thresholds in claude.md
- Add project-specific checklists

---

**Happy building!** 🚀