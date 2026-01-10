# Quick Start Guide

> **Time**: 5 minutes to get started
> **Version**: 3.0

## Overview

Claude Code Project Starter is a template system that enhances Claude Code with:

- **Dynamic model recommendations** - Always get the optimal model for your task
- **Real sub-agents** - Autonomous agents for exploration, planning, and execution
- **Hooks** - Automated environment validation on session start
- **Role personas** - 8 specialized perspectives for different work types
- **Status tracking** - Automatic progress updates and context management

---

## Quick Start (Single Project)

### 1. Clone or Copy the Template

```bash
# Option A: Use the setup script
./setup-project.sh /path/to/your-new-project

# Option B: Manual copy
cp -r project-template /path/to/your-new-project
cd /path/to/your-new-project
git init
```

### 2. Start Claude Code

```bash
cd /path/to/your-new-project
claude
```

### 3. Begin Planning

Say to Claude:
```
Check the docs/project/ folder and help me get started
```

Claude will:
1. Run the session-start hook (environment check)
2. Read your project documentation
3. Ask clarifying questions
4. Help you plan your project
5. Recommend the optimal model for each task

---

## What You Get

### On Session Start

The auto-hook provides environment context:
```
Session Environment Check
------------------------
Git Branch: main
Working tree: clean
Node.js Project Detected
Node: v20.10.0
Dependencies: installed
------------------------
Ready. Model recommendation will appear based on your task.
```

### Model Recommendations

Every task gets a recommendation:
```
Model Recommendation: Sonnet 4.5

Task: Implement user authentication

Pros:
- Optimal balance for feature implementation
- Handles multi-file changes efficiently

Cons:
- May need Opus for security architecture decisions

Alternative: Use Opus 4.5 if security-critical
```

### Sub-Agent Support

Real autonomous agents for complex work:
- **Explore Agent**: Fast codebase understanding
- **Plan Agent**: Implementation strategy
- **Bash Agent**: Command execution
- **General-Purpose Agent**: Complex multi-step tasks

---

## Key Commands

| Command | What It Does |
|---------|--------------|
| "Check the build status" | Resume work, see current progress |
| "Update status" | Auto-update all documentation |
| "Plan the implementation of X" | Invoke Plan agent |
| "Run tests in background" | Background task execution |
| "Security review" | Invoke Security Reviewer persona with Opus |

---

## Directory Structure

```
your-project/
├── .claude/
│   ├── claude.md              # Session context (auto-updated)
│   ├── settings.local.json    # Permissions & hooks config
│   ├── MODEL-STRATEGY.md      # Model recommendation guide
│   ├── SUBAGENTS.md           # Sub-agent documentation
│   ├── PERSONAS.md            # 8 role personas
│   └── hooks/
│       ├── auto/              # Auto-run hooks
│       └── validated/         # User-confirmed hooks
├── docs/project/
│   ├── build-status.md        # Progress tracking
│   ├── project-plan.md        # Requirements
│   ├── tech-stack.md          # Technology decisions
│   └── roadmap.md             # Future enhancements
└── README.md                  # Project documentation
```

---

## Next Steps

1. **Read** `MODEL-STRATEGY.md` to understand model recommendations
2. **Explore** `SUBAGENTS.md` to learn about autonomous agents
3. **Review** `PERSONAS.md` for specialized perspectives
4. **Configure** `settings.local.json` if you need different permissions

---

## Integration for Existing Projects

Have an existing project? See `INTEGRATE-EXISTING.md` for integration options:

```bash
# Essential tier (recommended for all)
./integrate-project.sh /path/to/existing-project

# Extended tier (complex/team projects)
./integrate-project.sh /path/to/existing-project --extended
```

---

## Need Help?

- **Model selection**: See `MODEL-STRATEGY.md`
- **Sub-agents**: See `SUBAGENTS.md`
- **Personas**: See `PERSONAS.md`
- **Hooks**: See `.claude/hooks/README.md`
- **Full documentation**: See main `README.md`

---

*Template Version: 3.0*
*Last Updated: January 2026*
