# Workspace Setup Guide

**Version**: 1.0
**Last Updated**: November 2, 2025

This workspace provides lightweight multi-project tracking and context management for Claude Code sessions.

---

## Quick Start

### First Time Setup

1. **Start Claude Code in your workspace directory**
   ```bash
   cd ~/Projects
   claude
   ```

2. **Check your project status**
   ```
   What's the status of my projects
   ```

3. **Start working on a project**
   ```
   Work on my-web-app
   ```

---

## Workspace Structure

```
Projects/
├── .workspace/                  # Workspace configuration
│   ├── CLAUDE.md               # Claude Code commands & preferences
│   ├── .session-log.md         # Session tracking (~150 tokens)
│   ├── README.md               # This file
│   ├── ROADMAP.md              # Workspace improvement tracking
│   └── templates/              # Stable templates for new projects
│       └── project-starter/    # Stable copy of cc-project-starter-template
│
├── projects/                    # All coding projects
│   ├── personal/               # Personal projects
│   │   ├── project-name/
│   │   │   ├── .status        # Quick status (~50-150 tokens)
│   │   │   └── BUILD-STATUS.md # Optional: Full tracking
│   │   └── ...
│   │
│   ├── templates/              # Template development (working copies)
│   │   └── cc-project-starter-template/  # Working copy
│   │
│   └── [work/, client/, experiments/]  # Future categories
│
├── sync-templates.sh            # Sync working template to stable
└── .gitignore                   # Excludes tracking files
```

---

## How It Works

### Session Tracking

**.workspace/.session-log.md**
- Logs recent work sessions across all projects
- Tracks context usage and clear events
- Auto-trims to last 30 entries
- **Token cost**: ~150 tokens

### Project Status

**projects/**/.status**
- Per-project quick status file
- Context-aware: simple projects = 1 line, complex = detailed
- Shows current phase, next actions
- **Token cost**: 15-150 tokens each

**BUILD-STATUS.md** (optional)
- Full project tracking for complex projects
- Use cc-project-starter-template for this
- **Token cost**: 1-3K tokens

---

## Claude Code Commands

### Status Check
```
What's the status of my projects
```

**Returns:**
- Most recently active project with next action
- High-level status of 2-3 other recent projects
- Current context usage (🟢 🟡 🟠 🔴)

### Project Selection
```
Work on [project-name]
```
or just say the project name

**Claude will:**
- Auto-load BUILD-STATUS.md if it exists
- Report current status and next task
- Ready to continue immediately

### Update Progress
```
Update status
```

**Claude will:**
- Analyze session and file changes
- Update .session-log.md
- Update project .status file
- Update BUILD-STATUS.md if exists
- Show summary and next steps

### Context Check
```
Check context
```

**Returns:**
- Current token usage and percentage
- Recommendations based on thresholds

---

## Context Management

### Automatic Alerts

- 🟢 **Green** (< 70% / < 140K tokens): Continue normally
- 🟡 **Yellow** (70-85% / 140-170K): "Recommend clearing after current task"
- 🟠 **Orange** (85-95% / 170-190K): "Should clear soon"
- 🔴 **Red** (> 95% / > 190K): "Please clear now"

### Clearing Context

When alerted to clear:
1. Say: `Update status` (saves everything)
2. Run: `/clear` in Claude Code
3. Resume: `What's the status of my projects`

**Resume cost**: ~300-500 tokens (0.15-0.25%)

---

## Project Organization

### Personal Projects (`projects/personal/`)
Your individual coding projects:
- Personal websites, portfolios
- Side projects, learning projects
- Tools and utilities

### Templates (`projects/templates/`)
Reusable project starters:
- cc-project-starter-template
- Custom templates you create

### Future Categories
Add as needed:
- `projects/work/` - Work-related projects
- `projects/client/` - Client projects
- `projects/experiments/` - Quick experiments, prototypes

---

## Token Budget

| Action | Tokens | Percentage |
|--------|--------|------------|
| Status check | 200-500 | 0.1-0.25% |
| Project resume (with BUILD-STATUS) | 1,500-4,000 | 0.75-2% |
| **Total overhead** | **< 2%** | **< 4K tokens** |

This leaves 196K+ tokens (98%) for actual coding work.

---

## Best Practices

### During Work Sessions

1. **Start sessions** with status check
2. **Update status** after completing major tasks
3. **Monitor context** - respond to alerts
4. **Clear context** when recommended (70%+)

### Project Setup

**Simple projects**:
- Just add a `.status` file (one-liner)
- Update it manually or with "update status"

**Complex projects**:
- Use cc-project-starter-template
- Includes BUILD-STATUS.md with full tracking
- Phase-based development approach

### File Maintenance

- `.session-log.md`: Auto-trims to 30 entries (or manual cleanup)
- `.status` files: Update after work sessions
- BUILD-STATUS.md: Updates via "update status" command

---

## Creating New Projects

### From Workspace Template (Recommended)
```bash
cd projects/personal
cp -r ../../.workspace/templates/project-starter my-new-project
cd my-new-project
# Follow the template's planning phase
```

### From GitHub Template
```bash
cd projects/personal
gh repo create my-project --template YOUR-USERNAME/cc-project-starter-template --private --clone
cd my-project
# Follow template's planning phase
```

### Simple Project (No Template)
```bash
cd projects/personal
mkdir my-new-project
cd my-new-project
echo "Status: Just started | $(date +%Y-%m-%d)" > .status
git init
```

## Managing Templates

### Update Working Template
```bash
cd projects/templates/cc-project-starter-template
# Make improvements, test changes
git add . && git commit -m "Improve template"
```

### Sync to Stable Version
```bash
cd ~/Projects
./sync-templates.sh
# This copies from projects/templates/cc-project-starter-template/
# to .workspace/templates/project-starter/
```

### Decide if Change is Shareable
1. Check `.workspace/ROADMAP.md`
2. If it's a "Template Improvement" (not personal):
   - Push to cc-project-starter-template GitHub repo
   - Update workspace-starter-template repo (when created)
   - Mark as complete in ROADMAP.md

## Workspace Improvements

### Track Ideas
Add to `.workspace/ROADMAP.md`:
- **Personal Workspace Improvements** - Just for you
- **Template Improvements** - Share with others

### Review Roadmap
```
Check .workspace/ROADMAP.md for planned improvements
```

This helps you:
- Track workspace evolution
- Decide what's personal vs shareable
- Plan future enhancements
- Document decisions

---

## Sharing This Workspace Setup

This `.workspace/` folder can be packaged as a template for others:

1. **Copy structure** to new repo:
   ```bash
   cp -r .workspace/ ~/workspace-starter-template/
   cp .gitignore ~/workspace-starter-template/
   mkdir -p ~/workspace-starter-template/projects/{personal,templates,work}
   ```

2. **Add setup guide** and template files

3. **Share** via GitHub template repo

---

## Files Reference

### Configuration
- `.workspace/CLAUDE.md` - Commands, preferences, agents, MCP servers
- `.workspace/.session-log.md` - Session tracking
- `.gitignore` - Excludes .status and .session-log.md from git

### Per-Project
- `.status` - Quick status (context-aware)
- `BUILD-STATUS.md` - Optional full tracking
- `CLAUDE.md` - Optional project-specific instructions

---

## Troubleshooting

**"Status check not working"**
- Ensure you're in your workspace directory (e.g., `~/Projects/`)
- Check `.workspace/.session-log.md` exists
- Check project `.status` files exist

**"Context filling up too fast"**
- Use "update status" and clear more frequently
- Remove old entries from .session-log.md
- Consider if you need all BUILD-STATUS.md loaded

**"Can't find project"**
- Projects should be in `projects/personal/`, `projects/templates/`, etc.
- Update .session-log.md with correct paths

---

## Version History

- **1.0** (Nov 2, 2025) - Initial workspace setup with .workspace/ and projects/ structure

---

For more details, see `.workspace/CLAUDE.md`
