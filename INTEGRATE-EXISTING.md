# Integrating Existing Claude Code Projects

This guide helps you bring your existing Claude Code project into this template system, adopting advanced features like automatic status tracking, context management, and structured documentation.

## Table of Contents

- [Should You Integrate?](#should-you-integrate)
- [What You'll Gain](#what-youll-gain)
- [Integration Levels](#integration-levels)
- [Pre-Integration Assessment](#pre-integration-assessment)
- [Integration Process](#integration-process)
- [Post-Integration Checklist](#post-integration-checklist)
- [Troubleshooting](#troubleshooting)

---

## Should You Integrate?

✅ **Integrate if:**
- You have an active Claude Code project you want to continue developing
- You want automatic status tracking and context management
- You're experiencing context overflow issues
- You want better session resume capabilities
- You want structured documentation that stays current

⚠️ **Consider carefully if:**
- Your project is nearly complete (integration overhead might not be worth it)
- You have a highly customized `.claude/` setup you don't want to change
- Your project is very small (< 1 week of work remaining)

---

## What You'll Gain

By integrating your existing project, you get:

### 1. **Automatic Status Tracking**
- `build-status.md` auto-updates with session progress
- Git checkpoints at major milestones
- Session logging with date tracking
- Resume sessions with only ~4K tokens (2% of budget)

### 2. **Intelligent Context Management**
- 4-tier alert system (🟢 Green → 🟡 Yellow → 🟠 Orange → 🔴 Red)
- Proactive monitoring before context overflow
- Automatic suggestions for session clearing
- Real-time token usage tracking in `.claude/claude.md`

### 3. **Structured Documentation**
- `project-plan.md` - Requirements and scope
- `tech-stack.md` - Technology decisions
- `roadmap.md` - Future enhancements (auto-populated)
- Phase-based planning with detailed task breakdown

### 4. **Enhanced Workflows**
- `/setup-permissions` - Interactive permission presets
- `/capture-roadmap-item` - Defer ideas without losing them
- "Update status" command - Auto-updates all tracking docs
- "Check context" command - On-demand health reporting

### 5. **Permission System**
- 4 presets: Aggressive, Moderate, Conservative, Maximum Security
- Easy switching between presets
- Documented in `SETTINGS-GUIDE.md`

---

## Integration Levels

Choose the level that fits your needs:

### Level 1: Minimal (15-30 minutes)
**What you get:** Status tracking and context management only

- Add `build-status.md`
- Update `.claude/claude.md` with context tracking
- Add "Update status" workflow
- Keep your existing project structure

**Best for:** Projects with established documentation structure

### Level 2: Standard (1-2 hours)
**What you get:** Full documentation structure + status tracking

- All of Level 1
- Add `docs/project/` structure with planning docs
- Add `/capture-roadmap-item` command
- Optionally adopt permission presets

**Best for:** Most existing projects

### Level 3: Full (2-4 hours)
**What you get:** Complete template adoption + migration

- All of Level 2
- Migrate existing docs into template structure
- Set up phase-based workflow
- Full permission preset configuration
- Clean up old documentation

**Best for:** Long-term projects where you want maximum benefits

---

## Pre-Integration Assessment

Before starting, answer these questions:

### 1. **What `.claude/` files do you currently have?**

Run in your project:
```bash
ls -la .claude/
```

Common files:
- `claude.md` - Session context (probably exists)
- `settings.json` or `settings.local.json` - Permissions (may exist)
- `commands/` - Custom slash commands (may exist)

### 2. **What documentation do you have?**

Check for:
- README.md
- Architecture docs
- Planning docs
- API documentation
- Any `/docs` directory

### 3. **What phase is your project in?**

- **Planning** (< 10% code written) → Easy integration
- **Early Development** (10-40% complete) → Good time to integrate
- **Mid Development** (40-70% complete) → Still valuable
- **Late Development** (70-90% complete) → Consider minimal integration only
- **Maintenance** (feature-complete) → Probably not worth it

### 4. **How many tokens is your current `.claude/claude.md`?**

```bash
wc -w .claude/claude.md
# Multiply by ~1.3 to estimate tokens
```

If > 10K tokens, you'll benefit significantly from this template's lighter approach.

---

## Integration Process

### Step 1: Backup Your Current Project

```bash
# Create a backup branch
git checkout -b backup-pre-integration
git add -A
git commit -m "Backup before template integration"
git checkout -  # Return to your working branch

# Or create a full copy
cd ..
cp -r your-project your-project-backup
cd your-project
```

### Step 2: Clone This Template (If Needed)

```bash
# In a separate directory
cd ~/projects
git clone https://github.com/dnorth123/claude-code-project-starter.git
cd claude-code-project-starter
```

### Step 3: Choose Your Integration Level

#### **For Level 1 (Minimal Integration)**

Copy just the essential tracking files:

```bash
# From your project root
TEMPLATE_DIR=~/projects/claude-code-project-starter/project-template

# Copy status tracking
cp $TEMPLATE_DIR/docs/project/build-status.md docs/project/build-status.md
mkdir -p docs/project  # If needed

# Update your .claude/claude.md with context tracking
# (Manual merge - see template example below)
```

**Template for `.claude/claude.md` context tracking section:**

```markdown
## Context & Token Status

**Current Usage:** [X]K / 200K tokens (~X%)
**Status:** 🟢 Green - Smooth sailing

**Thresholds:**
- 🟢 Green (<140K / <70%): Normal operation
- 🟡 Yellow (140-170K / 70-85%): Note for later
- 🟠 Orange (170-190K / 85-95%): Clear after current task
- 🔴 Red (>190K / >95%): Clear immediately

**Last Checked:** YYYY-MM-DD
```

#### **For Level 2 (Standard Integration)**

Copy the full documentation structure:

```bash
# From your project root
TEMPLATE_DIR=~/projects/claude-code-project-starter/project-template

# Copy documentation structure
cp -r $TEMPLATE_DIR/docs/project docs/

# Copy slash commands
mkdir -p .claude/commands
cp $TEMPLATE_DIR/.claude/commands/capture-roadmap-item.md .claude/commands/

# Copy updated .claude/claude.md (merge manually)
# See template in project-template/.claude/claude.md

# Optional: Add permission presets
cp -r $TEMPLATE_DIR/.claude/presets .claude/
cp $TEMPLATE_DIR/.claude/commands/setup-permissions.md .claude/commands/
```

Then **manually populate** the docs:

1. **`docs/project/project-plan.md`** - Copy your existing requirements/scope
2. **`docs/project/tech-stack.md`** - Document your technology choices
3. **`docs/project/build-status.md`** - Update with current project phase
4. **`docs/project/roadmap.md`** - List future enhancements

#### **For Level 3 (Full Integration)**

```bash
# From your project root
TEMPLATE_DIR=~/projects/claude-code-project-starter/project-template

# Copy entire .claude directory (careful - merges with existing)
cp -r $TEMPLATE_DIR/.claude/ .claude/

# Copy all documentation
cp -r $TEMPLATE_DIR/docs/project docs/

# Copy supporting files
cp $TEMPLATE_DIR/README-STRUCTURE.md ./
cp $TEMPLATE_DIR/Setup.md ./

# Update .gitignore (merge if you have one)
cat $TEMPLATE_DIR/.gitignore >> .gitignore
```

Then **migrate your existing docs** into the new structure:

1. Move planning docs → `docs/project/project-plan.md`
2. Move architecture docs → `docs/project/tech-stack.md`
3. Update status docs → `docs/project/build-status.md`
4. Future ideas → `docs/project/roadmap.md`

### Step 4: Initialize Your Status

Tell Claude to set up your project status:

```
I've integrated the Claude Code Project Starter template. Please:

1. Read my existing codebase to understand the current state
2. Update docs/project/build-status.md with:
   - Current phase and % complete
   - What's been accomplished so far
   - What's remaining to be done
3. Update .claude/claude.md with current context status
4. Create an initial git checkpoint

My project is approximately [X]% complete and currently in [Phase Name] phase.
```

### Step 5: Configure Permissions (Optional)

If you want to use permission presets:

```bash
# In your Claude session
/setup-permissions
```

Or manually copy a preset:

```bash
cp .claude/presets/aggressive.json .claude/settings.local.json
```

**Preset choices:**
- **Aggressive** (default) - Personal projects, maximum speed
- **Moderate** - Work projects, balanced speed/safety
- **Conservative** - Open source, client work
- **Maximum Security** - Production systems, high-risk environments

---

## Post-Integration Checklist

After integrating, verify:

- [ ] `.claude/claude.md` has context tracking section
- [ ] `docs/project/build-status.md` reflects current status
- [ ] Git checkpoint created: `git log --oneline -1`
- [ ] Can use "Update status" command successfully
- [ ] Can use "Check context" command
- [ ] Permission settings work as expected
- [ ] Test session resume: Start new session, run "Check the build status"

**Test the integration:**

1. **Make a small change** (add a comment somewhere)
2. **Run:** `"Update status"`
3. **Verify:** `build-status.md` and `.claude/claude.md` updated
4. **Start new session** and run: `"Check the build status and tell me where we are at"`
5. **Verify:** Claude understands project state from docs (~4K tokens)

---

## Troubleshooting

### Issue: "I already have a `.claude/claude.md` file with lots of context"

**Solution:**

Don't replace it completely. Instead:

1. **Backup your current file:**
   ```bash
   cp .claude/claude.md .claude/claude.md.backup
   ```

2. **Extract the valuable parts:**
   - Project-specific context you want to keep
   - Custom workflows or commands
   - Important notes about the codebase

3. **Merge template sections:**
   - Add the "Context & Token Status" section from template
   - Add "Session Checklist" if useful
   - Keep your existing context but condense if > 10K tokens

4. **Move historical info to docs:**
   - Session history → `docs/project/build-status.md`
   - Future plans → `docs/project/roadmap.md`
   - Tech decisions → `docs/project/tech-stack.md`

### Issue: "My docs directory has a different structure"

**Options:**

1. **Keep your structure** - Just add `build-status.md` somewhere and update paths in `.claude/claude.md`
2. **Hybrid approach** - Use `docs/project/` for template docs, keep your existing docs elsewhere
3. **Full migration** - Reorganize into template structure (more work, more benefit)

### Issue: "Template settings conflict with my custom commands"

**Solution:**

The template shouldn't conflict, but if it does:

1. **Merge `.claude/commands/` manually:**
   ```bash
   # Keep your commands, add template commands alongside
   ls .claude/commands/  # Check what you have
   # Rename if there are conflicts
   ```

2. **Permission settings:**
   - Template uses `settings.local.json` (gitignored)
   - Your `settings.json` (if committed) takes precedence
   - You can keep both

### Issue: "I don't want to lose my git history"

**You won't!** This integration:
- ✅ Adds new files to your existing repo
- ✅ Preserves all existing commits
- ✅ Doesn't modify existing files (unless you choose to)
- ✅ Creates new commits on top of your history

The backup branch (`backup-pre-integration`) gives you an easy rollback point.

### Issue: "Context tracking shows wrong percentage"

**Solution:**

Update the numbers in `.claude/claude.md`:

```markdown
**Current Usage:** 45K / 200K tokens (~22%)  <!-- Update this -->
**Status:** 🟢 Green - Smooth sailing
```

Claude will auto-update this when you run "Update status" or "Check context" commands.

### Issue: "Build status doesn't reflect my actual progress"

**Solution:**

Manually update `docs/project/build-status.md`:

1. Update the phase and percentage
2. Add session log entries for past work
3. Update remaining tasks list
4. Set Git checkpoint to your current commit

Then tell Claude: `"I've manually updated build-status.md to reflect our actual progress. Please review and adjust if needed."`

---

## Migration Example

Here's a real example of migrating an existing project:

### Before Integration

```
my-project/
├── .claude/
│   └── claude.md              # 15K tokens, growing every session
├── README.md
├── docs/
│   ├── api.md
│   └── architecture.md
└── src/
```

### After Level 2 Integration

```
my-project/
├── .claude/
│   ├── claude.md              # Reduced to ~4K tokens, now has context tracking
│   ├── settings.local.json    # Added (Aggressive preset)
│   ├── commands/
│   │   └── capture-roadmap-item.md
│   └── presets/               # Added
├── README.md
├── docs/
│   ├── api.md                 # Kept (existing docs)
│   ├── architecture.md        # Kept (existing docs)
│   └── project/               # Added (template structure)
│       ├── build-status.md    # Auto-updating status
│       ├── project-plan.md    # Migrated from README
│       ├── tech-stack.md      # Migrated from architecture.md
│       └── roadmap.md         # New, auto-populating
└── src/
```

**Result:**
- Session resume cost: 15K → 4K tokens (73% reduction)
- Status tracking: Manual → Automatic
- Context management: None → 4-tier alert system
- Git checkpoints: Ad-hoc → Systematic

---

## Next Steps After Integration

Once integrated, try these workflows:

1. **End of session:**
   ```
   "Update status and create a checkpoint"
   ```

2. **Start of session:**
   ```
   "Check the build status and tell me where we are at"
   ```

3. **When you think of future features:**
   ```
   /capture-roadmap-item
   "Add a dark mode toggle"
   ```

4. **Mid-session context check:**
   ```
   "Check context"
   ```

5. **Before major milestone:**
   ```
   "We just completed user authentication. Update status and create a phase checkpoint."
   ```

---

## Getting Help

If you run into issues:

1. **Check your backup:** `git checkout backup-pre-integration`
2. **Review template docs:** `README.md`, `SETTINGS-GUIDE.md`
3. **Start with minimal integration** and expand later
4. **Ask Claude:** "I'm having trouble integrating the template. Here's what's happening..."

---

## Summary

**Quick Integration Path:**

1. ✅ Backup your project
2. ✅ Choose integration level (recommend Level 2)
3. ✅ Copy template files
4. ✅ Tell Claude to initialize status
5. ✅ Test with "Update status" and session resume
6. ✅ Start using enhanced workflows

**Expected time investment:**
- Level 1: 15-30 minutes
- Level 2: 1-2 hours
- Level 3: 2-4 hours

**Payoff:** Significant improvement in session management, context efficiency, and project organization for the lifetime of your project.

---

**Version:** 2.0.0
**Last Updated:** 2025-11-12
**Related Docs:** `README.md`, `WORKSPACE-GUIDE.md`, `SETTINGS-GUIDE.md`
