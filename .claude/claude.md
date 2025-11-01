# Claude Code Session Context

**Project**: [PROJECT_NAME]  
**Session Started**: [Will be auto-updated]  
**Current Phase**: Phase 0 - Planning

---

## Session Objective

Initial setup - Help plan and initialize this project:
1. Review existing docs in docs/project/
2. Ask clarifying questions to fill gaps in project-plan.md and tech-stack.md
3. Create phase breakdown tailored to project scope
4. Generate detailed phase plans in docs/project/phases/
5. Update build-status.md with complete phase structure
6. Prepare to start Phase 1 development

---

## Token/Context Status

**Last Check**: Project initialization  
**Estimated Usage**: ~2K tokens (1% of 200K budget)  
**Status**: 🟢 Green - Excellent  
**Loaded Context**:
- build-status.md: ~2K
- project-plan.md: Will load when planning starts
- tech-stack.md: Will load when planning starts
- **Total**: ~2K (1%)

**Next Check**: After planning phase complete (~26K tokens expected)

**Alert Thresholds**:
- 🟢 Green: < 140K tokens (70%) - Smooth sailing
- 🟡 Yellow: 140-170K tokens (70-85%) - Note for later
- 🟠 Orange: 170-190K tokens (85-95%) - Clear after current task
- 🔴 Red: > 190K tokens (95%+) - Clear immediately

---

## Auto-Status Update System

**Status**: Active  
**Last Auto-Update**: Project initialization  
**Trigger**: [Manual request / Phase complete / Checkpoint / Periodic]

**How it works**:
When you say `"Update status"`, Claude will:
1. Analyze current session context and conversation
2. Identify completed tasks from file changes and discussion
3. Update docs/project/build-status.md:
   - Mark tasks complete
   - Update progress percentages
   - Log decisions made
   - Update phase status
4. Update this file (.claude/claude.md):
   - Log session progress
   - Note files modified
   - Record active decisions
5. Commit changes to git (optional)
6. Provide summary and suggest next steps

**What Claude infers**:
- Completed tasks from "I just finished X" statements
- New files created = feature work in progress
- File modifications = active development
- Technical decisions from discussion
- Blockers from "stuck on X" or error discussions

---

## Automatic Context Monitoring

**Status**: Active  
**Monitoring**: Continuous

**Auto-check triggers**:
1. After phase completion
2. After major milestone/checkpoint
3. Every ~50K token increment
4. When you request: `"Check context"`

**Alert system**:
- 🟢 **Green Zone** (< 140K): No alert, continue normally
- 🟡 **Yellow Zone** (140-170K): Note approaching limit, consider clearing after current phase
- 🟠 **Orange Zone** (170-190K): Recommend clearing context soon, estimate if next phase will fit
- 🔴 **Red Zone** (> 190K): Alert to clear immediately, auto-save status, guide through process

**What Claude analyzes**:
- Current token usage from API
- Loaded file sizes (docs + code)
- Conversation history length
- Estimated tokens for upcoming phase
- Code context accumulation

**Proactive recommendations**:
- Suggests optimal clear points (typically after phase completions)
- Estimates if next phase will fit in remaining budget
- Auto-saves status before recommending clear
- Guides through clear and resume process

---

## Project Documentation

### Core Docs (Persistent)
- **Build Status**: `docs/project/build-status.md` (~2-3K tokens)
  - Current phase and progress
  - Session log
  - Git checkpoints
  - Resume instructions
  
- **Project Plan**: `docs/project/project-plan.md` (~3-4K tokens)
  - Requirements and scope
  - Features and user flows
  - Timeline and phases
  
- **Tech Stack**: `docs/project/tech-stack.md` (~1-2K tokens)
  - Technology decisions
  - Dependencies
  - Architecture notes

### Phase Plans (Created during planning)
- `docs/project/phases/phase-N-name.md` (~2K tokens each)
  - Detailed tasks for each phase
  - Acceptance criteria
  - Time estimates

### Session Context (This file)
- `.claude/claude.md` (~2-3K tokens)
  - Current session state
  - Active decisions
  - Files modified this session
  - Next steps

**Total Context for Resume**: ~4-7K tokens (2-3.5% of budget)

---

## Current Session

**Status**: Project initialized from template

**Progress This Session**:
- ✅ Repository created
- ✅ Template files copied
- ✅ Local environment set up
- ⬜ Planning session not started yet

**Files Modified**:
- None yet (template state)

**Active Decisions**:
- None yet (awaiting planning session)

**Next Task**: Start planning session with:
"Check the docs/project/ folder and help me get started"
Copy
---

## Planning Session Checklist

When planning starts, Claude will work through:

- [ ] Read and understand project-plan.md (what's defined vs TBD)
- [ ] Read and understand tech-stack.md (what's decided vs uncertain)
- [ ] Ask clarifying questions to fill gaps
- [ ] Help make technology decisions for TBD items
- [ ] Propose phase breakdown (typically 3-5 phases)
- [ ] Create detailed phase plan files
- [ ] Update build-status.md with phase structure
- [ ] Mark Phase 0 complete
- [ ] Ask if ready to start Phase 1

**Estimated planning time**: 10-45 minutes (depends on initial completeness)

---

## Development Session Commands

### Core Commands
```bash
# Start/resume work
"Check the build status and tell me where we are at"

# Update progress automatically
"Update status"

# Check token/context health
"Check context"

# Start new phase
"Start Phase [N]"

# Complete phase
"Phase [N] complete"

# Prepare for context clear
"Save everything"
```

Context Management Flow

```bash
# When alerted (🟠 Orange or 🔴 Red):
You: "Save everything"

Claude: [Updates all docs, commits, prepares summary]

# You clear context:
/clear

# Resume fresh:
You: "Check the build status and tell me where we are at"
Claude: [Loads ~4K tokens, provides status, ready to continue]
````

Session Commands History
Will track commands used this session:

"Check the docs/project/ folder and help me get started" - [count]x
"Update status" - [count]x
"Check context" - [count]x
Phase transitions - [count]x


Code Patterns & Standards
Will be populated during development with project-specific patterns:
Coding Standards:

[To be defined during Phase 1]

Component Patterns:

[To be defined as components are built]

Testing Approach:

[To be defined if testing is included]


Notes & Reminders
For User:

First session should start with: "Check the docs/project/ folder and help me get started"
Use "Update status" regularly to keep docs current
Trust context alerts - clear when recommended
Take breaks anytime - easy to resume

For Claude:

This file is auto-updated during sessions
Monitor token usage proactively
Infer task completion from context
Keep status updates concise but informative
Guide through context clears smoothly


Template Version: 1.0
Last Updated: [Will be auto-updated during sessions]