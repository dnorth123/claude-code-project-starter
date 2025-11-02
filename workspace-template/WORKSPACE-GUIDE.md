# Claude Code Workspace Guide

**Version**: 2.0.0
**For**: Multi-project workspace management with Claude Code

This guide covers advanced workspace usage, multi-project workflows, and best practices for managing 3-10+ projects efficiently.

---

## Table of Contents

- [Understanding Workspaces](#understanding-workspaces)
- [Daily Workflow](#daily-workflow)
- [Multi-Project Management](#multi-project-management)
- [Context Management](#context-management)
- [Template Development](#template-development)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

---

## Understanding Workspaces

### What is a Workspace?

A **workspace** is a structured environment for managing multiple projects with Claude Code. Think of it as:

- **Container**: Holds all your projects in one place
- **Command Center**: Single status view across all projects
- **Context Manager**: Tracks token usage across sessions
- **Template System**: Reusable project starters

### Workspace vs Single Project

| Aspect | Single Project | Workspace |
|--------|----------------|-----------|
| **Focus** | One project at a time | Multiple concurrent projects |
| **Status Tracking** | Per-project only | Cross-project + per-project |
| **Session Logs** | Project-specific | Workspace-wide |
| **Templates** | Start from scratch each time | Reusable templates library |
| **Context** | Project context | Workspace + active project |
| **Best For** | Focused development | Portfolio, client work, multi-tasking |

---

## Daily Workflow

### Starting Your Day

1. **Navigate to workspace:**
   ```bash
   cd ~/Projects  # Or your workspace location
   claude
   ```

2. **Check overall status:**
   ```
   What's the status of my projects
   ```

3. **Claude shows:**
   - Most recently active project
   - Status and next task
   - 2-3 other recent projects
   - Context health indicator

**Example Output:**
```
Most Recent: my-web-app
- Status: Phase 3 - Implementation
- Next: Complete authentication module
- Last worked: Nov 1, 2025

Recent Projects:
- portfolio-site: Phase 4 Complete - Production Ready
- experiment-react-hooks: Phase 1 - Planning

Context: 45K tokens (22%) 🟢

Which would you like to work on?
```

### Switching Projects

```
Work on my-web-app
```

Claude will:
- Load project's BUILD-STATUS.md (if exists)
- Show current phase and next tasks
- Ready to continue immediately

### Ending Your Day

```
Update status
```

Claude will:
- Analyze your session
- Update .session-log.md
- Update project .status file
- Update BUILD-STATUS.md (if exists)
- Log context usage

Then you can safely close Claude Code.

---

## Multi-Project Management

### Project Categories

Organize projects by type:

```
projects/
├── personal/      # Side projects, learning, portfolio
├── work/          # Employment projects
├── client/        # Client/freelance work
├── templates/     # Template development
└── experiments/   # Quick prototypes, spikes
```

**Add categories as needed:**
```bash
mkdir projects/open-source
mkdir projects/archived
```

### Project Status Files

Two approaches based on complexity:

#### Simple Projects (.status only)

For quick projects, experiments, or stable projects:

```bash
# Create
echo "Status: Brief description | $(date +%Y-%m-%d)" > .status

# Example
echo "Status: Stable template, ready for use | 2025-11-02" > .status
```

**Token cost**: ~50 tokens

#### Complex Projects (BUILD-STATUS.md)

For active development projects:

```bash
# Create from template
cp -r ../../.workspace/templates/project-starter my-complex-project
cd my-complex-project
# Follow planning phase
```

**Token cost**: ~3K tokens

### Cross-Project Session Logging

`.workspace/.session-log.md` tracks all activity:

```markdown
## Recent Sessions

2025-11-02 14:30 | my-web-app | Completed auth module | 85K (42%) 🟢
2025-11-02 10:15 | portfolio | Updated design system | 60K (30%) 🟢
2025-11-01 16:45 | experiment-hooks | Explored patterns | 45K (22%) 🟢
```

**Token cost**: ~150 tokens (auto-trims to 30 entries)

---

## Context Management

### Workspace-Level Context

When you say `"Check context"`, Claude reports:

```
Context Status: 85K tokens (42%) 🟢

Breakdown:
- .session-log.md: ~150 tokens
- Current project .status: ~100 tokens
- my-web-app BUILD-STATUS.md: ~3K tokens
- Code and conversation: ~82K tokens

Recommendation: Healthy - continue working
```

### Multi-Project Context Strategy

**Goal**: Track multiple projects without overwhelming context

**Approach**:
1. **Lightweight tracking** - Use .status files for most projects
2. **Full tracking** - Only active projects get BUILD-STATUS.md
3. **Session logging** - One log tracks all projects
4. **Smart loading** - Claude loads only what's needed

**Example Breakdown**:
```
Total: 4K tokens (2%)
├── .session-log.md: 150 tokens
├── 5 .status files: 500 tokens
└── 1 BUILD-STATUS.md: 3K tokens

Remaining: 196K tokens (98%) for coding
```

### Context Clear Workflow

When context reaches 70%+:

1. **Finish current task**

2. **Save everything:**
   ```
   Update status
   ```

3. **Clear context:**
   ```
   /clear
   ```

4. **Resume:**
   ```
   What's the status of my projects
   ```

**Resume cost**: ~500 tokens (0.25%)

---

## Template Development

### Dual Template System

The workspace uses two copies of each template:

**Working Copy**: `projects/templates/cc-project-starter-template/`
- Active development
- Connected to git
- Test changes here

**Stable Copy**: `.workspace/templates/project-starter/`
- Used for creating new projects
- Clean copy (no .git)
- Synced from working copy

### Template Development Workflow

1. **Make changes** in working copy:
   ```bash
   cd projects/templates/cc-project-starter-template
   # Edit files, test changes
   git add . && git commit -m "Improve template"
   ```

2. **Test** by creating a project:
   ```bash
   cd ../../personal
   cp -r ../templates/cc-project-starter-template test-project
   cd test-project
   # Verify template works
   ```

3. **Sync to stable** when ready:
   ```bash
   cd ~/Projects
   ./sync-templates.sh
   ```

4. **Use stable** for real projects:
   ```bash
   cd projects/personal
   cp -r ../../.workspace/templates/project-starter my-real-project
   ```

### Creating Custom Templates

```bash
cd projects/templates
mkdir my-custom-template
cd my-custom-template

# Add your template files
# ...

# Sync to workspace
cd ~/Projects
# Update sync-templates.sh to include your template
./sync-templates.sh
```

---

## Best Practices

### Project Organization

**DO:**
- ✅ Use descriptive project names (`portfolio-redesign-2025`)
- ✅ Keep .status files updated
- ✅ Archive completed projects (`projects/archived/`)
- ✅ Use categories that match your work style

**DON'T:**
- ❌ Mix unrelated projects in same directory
- ❌ Let .session-log.md exceed 30 entries
- ❌ Forget to update status before long breaks
- ❌ Create BUILD-STATUS.md for every tiny project

### Session Management

**Start of session:**
```
What's the status of my projects
```

**During session:**
```
Work on [project]
```
```
Check context
```

**End of session:**
```
Update status
```

**Before breaks (>1 day):**
```
Update status
```
Then add manual notes if needed.

### Context Hygiene

1. **Monitor usage** - Check context regularly
2. **Clear proactively** - Don't wait for 95%
3. **Archive BUILD-STATUS** - Move completed projects to .status only
4. **Trim session log** - Remove old entries when >30

### Multi-Project Switching

**Efficient switching:**
```
Work on project-a
# Work for a while
Update status

Work on project-b
# Work for a while
Update status

Work on project-a
# Resume where you left off
```

**Inefficient switching:**
```
Work on project-a
# Work for 5 minutes

Work on project-b
# Work for 5 minutes

Work on project-c
# Too much context thrashing
```

**Rule of thumb**: Spend at least 30-60 minutes per project before switching.

---

## Troubleshooting

### "Can't find my project"

**Check:**
1. Is it in `projects/` subdirectory?
2. Does it have a `.status` file?
3. Is it logged in `.session-log.md`?

**Fix:**
```bash
cd projects/personal/my-project
echo "Status: Current state | $(date +%Y-%m-%d)" > .status
```

### "Status command shows wrong project"

`.session-log.md` entries are sorted by date. Most recent shows first.

**Fix:**
Update session log manually or say:
```
Update status for [project-name]
```

### "Context filling up too fast"

**Causes:**
- Too many BUILD-STATUS.md files loaded
- .session-log.md too long
- Complex project with large docs

**Fixes:**
1. Convert stable projects to .status only
2. Trim .session-log.md to 10-20 entries
3. Archive old planning docs
4. Clear context more frequently

### "Sync script not working"

**Check:**
```bash
chmod +x sync-templates.sh
ls -la projects/templates/
ls -la .workspace/templates/
```

**Common issue**: Paths in script need updating if workspace moved.

**Fix**: Edit `sync-templates.sh` and update paths.

---

## Advanced Tips

### Custom Workspace Commands

Add to `.workspace/CLAUDE.md`:

```markdown
## Custom Commands

**"Weekly review"**
- Review all active projects
- Update priorities
- Archive completed work

**"Start sprint"**
- Plan week's work across projects
- Set goals for each active project
- Allocate time blocks
```

Then use naturally with Claude!

### Project Health Dashboard

Create `projects-health.sh`:

```bash
#!/bin/bash
echo "Project Health Dashboard"
echo "========================"
echo ""
for dir in projects/personal/*; do
    if [ -d "$dir" ]; then
        name=$(basename "$dir")
        if [ -f "$dir/.status" ]; then
            status=$(cat "$dir/.status")
            echo "✓ $name"
            echo "  $status"
        else
            echo "⚠ $name (no status)"
        fi
        echo ""
    fi
done
```

Run before Claude sessions to see all projects.

### Git Integration

**Workspace-level commits:**
```bash
# Only commits workspace metadata
git add .workspace/.session-log.md
git commit -m "Update session log"
```

**Individual project commits:**
```bash
cd projects/personal/my-app
git add .
git commit -m "Implement feature X"
```

**Note**: Projects can have separate git repos!

---

## Appendix

### File Structure Reference

```
workspace/
├── .workspace/                 # Workspace config (tracked in git)
│   ├── CLAUDE.md              # Commands, preferences
│   ├── README.md              # Workspace setup guide
│   ├── ROADMAP.md             # Workspace improvements
│   ├── .session-log.md        # Session tracking (local only)
│   └── templates/             # Stable project templates
│       └── project-starter/   # Full template (no .git)
│
├── projects/                   # All projects
│   ├── personal/              # Personal projects
│   │   ├── project-a/
│   │   │   ├── .status       # Quick status (local only)
│   │   │   └── BUILD-STATUS.md  # Full tracking (local only)
│   │   └── project-b/
│   │       └── .status
│   ├── work/
│   ├── client/
│   └── templates/             # Template development
│       └── cc-project-starter-template/  # Working copy
│
├── sync-templates.sh          # Template sync utility
├── .gitignore                 # Excludes .status, .session-log
└── README.md                  # Main workspace README
```

### Token Budget Examples

**Minimal workspace (3 simple projects):**
```
.session-log.md: 150 tokens
3× .status files: 150 tokens
Total: 300 tokens (0.15%)
```

**Medium workspace (1 active + 4 stable):**
```
.session-log.md: 150 tokens
1× BUILD-STATUS.md: 3K tokens
4× .status files: 200 tokens
Total: 3.5K tokens (1.75%)
```

**Large workspace (3 active + 7 stable):**
```
.session-log.md: 150 tokens
3× BUILD-STATUS.md: 9K tokens
7× .status files: 350 tokens
Total: 9.5K tokens (4.75%)
```

**Recommendation**: Keep active BUILD-STATUS files to 1-2 at most.

---

## Getting Help

- **GitHub Issues**: [Report bugs or request features](https://github.com/dnorth123/claude-code-project-starter/issues)
- **Discussions**: Share workflows and tips
- **README**: Check main README for setup help

---

**Happy multi-project development! 🚀**
