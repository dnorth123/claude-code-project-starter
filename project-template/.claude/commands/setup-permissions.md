# Setup Permissions Command

You are helping the user configure auto-approval permissions for this project.

## Step 1: Check Current Configuration

First, check if `.claude/settings.local.json` exists and read it to understand the current configuration.

## Step 2: Explain Current Settings (Aggressive by Default)

Present this information to the user:

---

**Current Permission Configuration**

This project uses **AGGRESSIVE** auto-approval settings (the template default).

### What Aggressive Means

**Auto-approved operations:**
- ✅ All file operations (Read, Write, Edit, Glob, Grep)
- ✅ Complete git workflow (status, commit, push, branch, checkout, etc.)
- ✅ Package managers (npm, yarn, pnpm)
- ✅ Python/Node execution and testing
- ✅ File system operations (ls, mkdir, cp, mv, chmod)
- ✅ Docker commands (all operations)
- ✅ GitHub CLI (gh) operations

**Safety measures:**
- 🛡️ Dangerous commands blocked (rm -rf /)
- 🛡️ Git force push requires approval

### Pros of Aggressive Settings
- ⚡ **Speed**: No approval prompts for routine operations
- 🚀 **Flow**: Stay in the zone, uninterrupted development
- 🎯 **Efficiency**: Ideal for rapid prototyping and iteration
- 💪 **Productivity**: Maximum trust = maximum velocity

### Cons of Aggressive Settings
- ⚠️ **Less oversight**: Changes happen without confirmation
- ⚠️ **Trust required**: Only suitable for repos you fully trust
- ⚠️ **Risk**: Mistakes harder to catch before they happen
- ⚠️ **Not for production**: Requires careful review before deploying

### When Aggressive is Perfect
- ✅ Personal side projects and experiments
- ✅ Learning projects and tutorials
- ✅ Prototypes and proof-of-concepts
- ✅ Trusted development environments
- ✅ Solo projects where you review commits before pushing

### When to Use More Conservative Settings
- ❌ Production systems
- ❌ Client projects
- ❌ Open source contributions (public repos)
- ❌ Shared/team repositories
- ❌ Unfamiliar codebases
- ❌ Financial or security-critical applications

---

## Step 3: Offer Choices

Ask the user:

"Would you like to:
1. **Keep Aggressive** - Continue with current settings (recommended for personal projects)
2. **Switch to Moderate** - Auto-approve files/git/packages, ask before execution
3. **Switch to Conservative** - Ask for most operations, auto-approve only reads
4. **Switch to Maximum Security** - Ask for nearly everything (production/critical systems)
5. **Compare all options** - See detailed comparison table"

## Step 4: If User Chooses "Compare all options" (5)

Show this comparison table:

| Feature | Maximum Security | Conservative | Moderate | Aggressive |
|---------|-----------------|--------------|----------|------------|
| **File Reading** | ✅ Auto | ✅ Auto | ✅ Auto | ✅ Auto |
| **File Writing/Editing** | ⚠️ Ask | ⚠️ Ask | ✅ Auto | ✅ Auto |
| **Search (Glob/Grep)** | ✅ Auto | ✅ Auto | ✅ Auto | ✅ Auto |
| **Git Status/Log/Diff** | ✅ Auto | ✅ Auto | ✅ Auto | ✅ Auto |
| **Git Commit/Push** | ⚠️ Ask | ⚠️ Ask | ✅ Auto | ✅ Auto |
| **Package Install (npm)** | ⚠️ Ask | ⚠️ Ask | ✅ Auto | ✅ Auto |
| **Run Tests/Scripts** | ⚠️ Ask | ⚠️ Ask | ⚠️ Ask | ✅ Auto |
| **Docker Commands** | ❌ Deny | ⚠️ Ask | ⚠️ Ask | ✅ Auto |
| **GitHub CLI (gh)** | ⚠️ Ask | ⚠️ Ask | ⚠️ Ask | ✅ Auto |
| **File System (mkdir/cp/mv)** | ⚠️ Ask | ⚠️ Ask | ✅ Auto | ✅ Auto |
| | | | | |
| **Best For** | Production/Critical | Open Source/Client | Work/Learning | Personal/Trusted |
| **Workflow Speed** | ⭐ Slowest | ⭐⭐ Slow | ⭐⭐⭐ Medium | ⭐⭐⭐⭐ Fastest |
| **Safety Level** | 🔒🔒🔒🔒 Maximum | 🔒🔒🔒 High | 🔒🔒 Medium | 🔒 Basic |
| **Approval Frequency** | Very Often | Often | Sometimes | Rarely |

Then ask: "Which preset would you like to use? (1-4, or 'keep' for Aggressive)"

## Step 5: Apply Selected Preset

When the user selects a preset (1-4 or keep):

### A. If user chooses "Keep Aggressive" (1 or 'keep')
Simply confirm:
"✓ Keeping **AGGRESSIVE** settings. Your workflow will remain fast and uninterrupted.

You can run `/setup-permissions` anytime to change this."

### B. If user chooses a different preset (2, 3, or 4)

1. **Determine which preset file to use:**
   - 2 = `moderate.json`
   - 3 = `conservative.json`
   - 4 = `maximum-security.json`

2. **Read the preset file** from `.claude/presets/[preset-name].json`

3. **Check for existing `.claude/settings.local.json`:**

   **If the file exists:**
   - Read the current settings
   - Compare the current `permissions.allow` array with the preset's `allow` array
   - Identify any custom permissions (permissions in current but not in ANY preset)

   **If custom permissions found:**

   Ask the user:
   "I found custom permissions in your current settings that aren't in the standard presets:

   [List the custom permissions, e.g.:]
   - Bash(ruby:*)
   - Bash(rails:*)

   Would you like to:
   a. **Replace** - Use new preset exactly as-is (lose custom permissions)
   b. **Merge** - Keep custom permissions + apply new preset base
   c. **Cancel** - Keep current settings unchanged"

   - If user chooses **Replace (a)**: Use preset as-is
   - If user chooses **Merge (b)**: Combine custom permissions with preset's allow array
   - If user chooses **Cancel (c)**: Stop and confirm no changes made

   **If NO custom permissions found (or file doesn't exist):**
   - Use the preset as-is

4. **Write the configuration** to `.claude/settings.local.json`

5. **Confirm the change:**

"✓ Configuration updated to **[PRESET NAME]**

Settings saved to: `.claude/settings.local.json`

**What changed:**
[Provide a brief summary, e.g.:]
- Now asking before executing Python/Node scripts
- Still auto-approving file operations and git commands
- Package managers (npm/yarn) still auto-approved

**Your workflow:**
[Explain the impact, e.g. for Moderate:]
- File operations: ✅ Automatic (no change)
- Git commits/push: ✅ Automatic (no change)
- Running tests: ⚠️ Will now ask for approval
- Docker commands: ⚠️ Will now ask for approval

[If merged custom permissions:]
✓ Your custom permissions were preserved:
- [list custom permissions]

**Next steps:**
- Changes take effect immediately in this session
- You can run `/setup-permissions` anytime to change presets
- Manually edit `.claude/settings.local.json` for fine-tuning
- See `.claude/SETTINGS-GUIDE.md` for detailed documentation"

## Error Handling

If any errors occur (file not found, JSON parsing errors, etc.):
- Explain the error clearly
- Suggest manual configuration as fallback
- Provide the path to SETTINGS-GUIDE.md for reference

## Additional Help

If the user asks questions about:
- **Specific permissions**: Explain using information from `.claude/SETTINGS-GUIDE.md`
- **Security implications**: Reference the risk levels and safety sections from the guide
- **Customization**: Point to the Customization Guide section and preset merging
- **What's best for their project**: Ask clarifying questions about project type, team size, public/private, etc.

## Important Notes

- Be conversational and helpful, not robotic
- Explain trade-offs honestly (speed vs. safety)
- Default to recommending Aggressive for personal projects, Conservative for professional/public work
- Remind users they can change anytime
- If in doubt, err on the side of more conservative settings
