# Claude Code Project Starter Template

[![Use this template](https://img.shields.io/badge/Use%20this-template-blue?style=for-the-badge)](https://github.com/dnorth123/claude-code-project-starter/generate)
[![Claude Code Compatible](https://img.shields.io/badge/Claude%20Code-Compatible-orange?style=for-the-badge)](https://claude.ai)
[![MIT License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-v2.0.0-purple?style=for-the-badge)](https://github.com/dnorth123/claude-code-project-starter/releases)

**Two powerful modes in one template**: Build a single project with automatic status tracking, OR manage multiple projects with intelligent workspace organization. Choose the approach that fits your workflow.

---

## 🎯 Which Mode Is Right for You?

### 🔷 Single Project Mode
**Best for**: Building one focused project with Claude Code

✨ You get:
- Structured documentation (BUILD-STATUS.md, phases, roadmap)
- Automatic status updates via `"Update status"` command
- Intelligent context management with proactive alerts
- Phase-based development approach
- Token-efficient design (80-85% context for coding)
- Smart resume after breaks

👉 **Setup time**: 2 minutes
👉 **Perfect for**: Side projects, learning projects, prototypes, tools

[Jump to Single Project Setup →](#-single-project-mode-setup)

---

### 🔶 Workspace Mode
**Best for**: Juggling multiple projects with Claude Code

✨ You get:
- All Single Project Mode features **PLUS**:
- Multi-project status tracking across all your work
- Cross-project session logging
- Template management system
- Organized project categories (personal, work, client)
- Single command to check status of all projects
- Workspace-level context management

👉 **Setup time**: 3 minutes
👉 **Perfect for**: Developers managing 3-10+ projects, portfolio work, multi-client work

[Jump to Workspace Mode Setup →](#-workspace-mode-setup)

---

## 📊 Feature Comparison

| Feature | Single Project | Workspace |
|---------|----------------|-----------|
| **AUTO status updates** | ✅ | ✅ |
| **Context management** | ✅ Per-project | ✅ Workspace-wide |
| **Phase-based development** | ✅ | ✅ (per project) |
| **Smart resume** | ✅ | ✅ |
| **Multi-project tracking** | ❌ | ✅ |
| **Session logging** | ✅ Per-project | ✅ Cross-project |
| **Template system** | ❌ | ✅ |
| **Project categories** | ❌ | ✅ |
| **Token overhead** | ~4K (2%) | ~4K (2%) |

---

## 🚀 Single Project Mode Setup

Perfect when you want to focus on building one thing.

### Step 1: Create Your Project

**Option A: GitHub CLI (Recommended)**
```bash
gh repo create my-awesome-project --template dnorth123/claude-code-project-starter --private --clone
cd my-awesome-project
```

**Option B: GitHub Web**
1. Click ["Use this template"](https://github.com/dnorth123/claude-code-project-starter/generate)
2. Name your repository
3. Clone it locally

**Option C: Direct Clone**
```bash
git clone https://github.com/dnorth123/claude-code-project-starter.git my-project
cd my-project
rm -rf .git && git init
```

### Step 2: Run Setup Wizard

```bash
./setup-project.sh
```

The wizard will:
- ✅ Copy project template files to your directory
- ✅ Initialize BUILD-STATUS.md with your project name
- ✅ Create initial documentation structure
- ✅ Set up git repository
- ✅ Create first commit
- ✅ Clean up workspace files

### Step 3: Start Building

```bash
claude  # Start Claude Code
```

Then say:
```
Check the docs/project/ folder and help me get started
```

Claude will guide you through planning and building your project!

### 📖 Single Project Commands

| Command | What It Does |
|---------|--------------|
| `"Check the build status and tell me where we are at"` | Resume work, see current phase & next tasks |
| `"Update status"` | Auto-update all documentation with progress |
| `"Check context"` | See token usage and get recommendations |
| `"Phase [N] complete"` | Mark phase done, update docs, get next steps |

---

## 🏢 Workspace Mode Setup

Perfect when you're juggling multiple projects.

### Step 1: Create Workspace Repository

**Option A: GitHub CLI (Recommended)**
```bash
gh repo create my-workspace --template dnorth123/claude-code-project-starter --private --clone
cd my-workspace
```

**Option B: GitHub Web**
1. Click ["Use this template"](https://github.com/dnorth123/claude-code-project-starter/generate)
2. Name it something like "coding-workspace" or "dev-projects"
3. Clone it locally

**Option C: Direct Clone**
```bash
git clone https://github.com/dnorth123/claude-code-project-starter.git my-workspace
cd my-workspace
rm -rf .git && git init
```

### Step 2: Run Workspace Setup Wizard

```bash
./setup-workspace.sh
```

The wizard will:
- ✅ Ask for your preferred workspace location (default: ~/Projects)
- ✅ Copy workspace structure (.workspace/, projects/)
- ✅ Personalize paths in configuration files
- ✅ Initialize git repository
- ✅ Create initial session log
- ✅ Set up project template system

### Step 3: Navigate & Start

```bash
cd ~/Projects  # Or your chosen location
claude
```

Then say:
```
What's the status of my projects
```

### 📖 Workspace Commands

| Command | What It Does |
|---------|--------------|
| `"What's the status of my projects"` | See all projects, recent activity, context health |
| `"Work on [project-name]"` | Switch to specific project, load its status |
| `"Update status"` | Update session log, project status, BUILD-STATUS |
| `"Check context"` | See workspace-wide token usage |

### 🗂️ Workspace Structure

After setup, your workspace looks like this:

```
~/Projects/                      # Or your chosen location
├── .workspace/                  # Workspace configuration
│   ├── CLAUDE.md               # Commands & preferences
│   ├── README.md               # Workspace guide
│   ├── ROADMAP.md              # Improvement tracking
│   ├── .session-log.md         # Cross-project session log
│   └── templates/              # Project templates
│       └── project-starter/    # Full project template
│
├── projects/                    # Your projects
│   ├── personal/               # Personal projects
│   ├── work/                   # Work projects
│   ├── client/                 # Client projects
│   └── templates/              # Template development
│
├── sync-templates.sh            # Template sync utility
└── .gitignore                   # Excludes temp files
```

### 🆕 Creating Projects in Workspace

**From template:**
```bash
cd projects/personal
cp -r ../../.workspace/templates/project-starter my-new-project
cd my-new-project
claude
# Say: "Check the docs/project/ folder and help me get started"
```

**Simple project (no template):**
```bash
cd projects/personal
mkdir quick-experiment
cd quick-experiment
echo "Status: Just started | $(date +%Y-%m-%d)" > .status
```

---

## 💡 Key Features (Both Modes)

### 🤖 Automatic Status Updates

Just say `"Update status"` and Claude:
- ✅ Analyzes your session and file changes
- ✅ Updates documentation automatically
- ✅ Logs progress and decisions
- ✅ Shows summary and next steps

### 🎯 Intelligent Context Management

Claude proactively manages token usage:
- 🟢 **Green (<70%)**: Smooth sailing, keep coding
- 🟡 **Yellow (70-85%)**: Note for later, finish current task
- 🟠 **Orange (85-95%)**: Clear context after current task
- 🔴 **Red (>95%)**: Clear immediately

### 📊 Phase-Based Development

Break projects into manageable phases:
- **Phase 0**: Planning (define scope, tech stack)
- **Phase 1-3**: Implementation (build core features)
- **Phase 4**: Polish & Deploy (testing, optimization)

Each phase has clear goals, tasks, and git tags.

### ⚡ Smart Session Resume

Close Claude Code anytime. Resume with:
```
Check the build status and tell me where we are at
```

Claude loads ~4K tokens (2%) but knows your full project state!

---

## 🎨 Perfect For

### Single Project Mode
- ✨ Weekend side projects you actually want to finish
- 📚 Learning new frameworks/technologies
- 🔬 Quick prototypes and proof-of-concepts
- 🛠️ Personal tools and utilities
- 🧪 Technical experiments

### Workspace Mode
- 💼 Managing multiple client projects
- 🎯 Portfolio with 5-10+ projects
- 🔄 Switching between work and personal projects
- 📦 Template development and reuse
- 🏢 Freelance work with multiple active contracts

---

## 📖 Documentation

### For Single Project Users
- **BUILD STATUS**: `docs/project/build-status.md` - Your project's command center
- **Setup Guide**: `Setup.md` - First-time setup instructions
- **Enhancements**: `ENHANCEMENT-SETUP.md` - Adding features after MVP

### For Workspace Users
- **Workspace Guide**: `.workspace/README.md` - Comprehensive workspace usage
- **Commands Reference**: `.workspace/CLAUDE.md` - All commands and agents
- **Roadmap**: `.workspace/ROADMAP.md` - Workspace improvement tracking
- **Project Template**: `.workspace/templates/project-starter/` - Full project template docs

---

## 🔧 Advanced Features

### Token Budget Breakdown

**Single Project:**
- BUILD-STATUS.md: ~3K tokens (1.5%)
- Planning docs: ~3K tokens (1.5%)
- **Total overhead**: ~6K tokens (3%)
- **Available for coding**: ~194K tokens (97%)

**Workspace:**
- Session log: ~150 tokens (0.075%)
- Project .status files: ~300 tokens (0.15%)
- Current BUILD-STATUS: ~3K tokens (1.5%)
- **Total overhead**: ~4K tokens (2%)
- **Available for coding**: ~196K tokens (98%)

### Context Clear Workflow

When context gets full:

1. **Save everything:**
   ```
   Update status
   ```

2. **Clear context:**
   ```
   /clear
   ```

3. **Resume immediately:**
   ```
   Check the build status and tell me where we are at
   ```

Resume cost: Only 2-4K tokens!

### ⚙️ Configurable Auto-Approval Permissions

Both modes include **aggressive auto-approval settings by default**, but you can easily customize the permission level for each project.

**🎛️ Choose Your Permission Level**

When you start a new project, run:
```
/setup-permissions
```

Claude will help you choose from 4 presets:
- 🔵 **Aggressive** (default): Maximum speed - auto-approve everything
- 🟢 **Moderate**: Balanced - auto-approve files/git/packages, ask for execution
- 🟡 **Conservative**: More oversight - ask for most changes
- 🔴 **Maximum Security**: Maximum control - approve nearly everything

**What's in Aggressive (Default):**
- ✅ All file operations (Read, Write, Edit, Glob, Grep)
- ✅ Complete git workflow (status, diff, commit, push, branch, checkout)
- ✅ Package managers (npm, yarn, pnpm)
- ✅ Python/Node execution and testing
- ✅ File system operations (ls, mkdir, cp, mv, chmod, etc.)
- ✅ Docker commands (build, run, compose, logs, etc.)
- ✅ GitHub CLI (gh) for PR/issue management

**Safety Measures:**
- 🛡️ Dangerous commands (like `rm -rf /`) are explicitly denied
- 🛡️ Git force push requires approval (via git protocol)

**Why This Matters:**
- ⚡ Eliminates approval prompts for common development operations
- 🚀 Significantly speeds up Claude Code workflows
- 🎯 Ideal for personal projects and trusted development environments
- 🔧 Easy to adjust for different project types (personal, client, production)

**Customization:**
- **Quick setup**: Run `/setup-permissions` in any project to reconfigure
- **Detailed guide**: See `project-template/.claude/SETTINGS-GUIDE.md` for comprehensive documentation
- **Manual edit**: Edit `.claude/settings.local.json` directly for fine-tuning

---

## 🎓 Getting Help

### Quick Start Issues?

**Single Project Mode:**
- Make sure you ran `./setup-project.sh`
- Start Claude Code in your project directory
- Say: `"Check the docs/project/ folder and help me get started"`

**Workspace Mode:**
- Make sure you ran `./setup-workspace.sh`
- Navigate to your workspace directory
- Start Claude Code
- Say: `"What's the status of my projects"`

### Common Questions

**Q: Can I switch from Single Project to Workspace later?**
A: Yes! Create a workspace, move your project into `projects/personal/`, add a `.status` file.

**Q: Can I use Workspace for just one project?**
A: Absolutely, but Single Project Mode is simpler if you're focused on one thing.

**Q: Do I need both modes?**
A: No! Choose based on your current needs. You can always switch.

**Q: What if I hit the token limit?**
A: Claude will alert you proactively. Just say `"Update status"` then run `/clear`.

---

## 🚀 What's New in v2.0.0

- ✨ **NEW**: Dual-mode support (Single Project + Workspace)
- ✨ **NEW**: Interactive setup wizards for both modes
- ✨ **NEW**: Multi-project workspace organization
- ✨ **NEW**: Cross-project session tracking
- ✨ **NEW**: Template management system
- ✅ All v1.0 features preserved and enhanced
- 📖 Comprehensive documentation for both modes

---

## 📜 License

MIT License - see [LICENSE](LICENSE) for details

---

## 🙏 Acknowledgments

Built with ❤️ for the Claude Code community.

- **Inspired by**: Real-world solo development challenges
- **Optimized for**: Claude Code's 200K token context window
- **Tested with**: Multiple weekend projects and portfolio work

---

## 🎯 Next Steps

1. **Choose your mode** (Single Project or Workspace)
2. **Run the setup wizard** (`./setup-project.sh` or `./setup-workspace.sh`)
3. **Start Claude Code** in your project/workspace
4. **Begin building** with intelligent assistance

**Happy coding! 🚀**

---

**Questions or feedback?** Open an issue on [GitHub](https://github.com/dnorth123/claude-code-project-starter/issues)
