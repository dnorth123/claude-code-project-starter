# Claude Code Project Starter Template

[![Use this template](https://img.shields.io/badge/Use%20this-template-blue?style=for-the-badge)](https://github.com/dnorth123/claude-code-project-starter/generate)
[![Claude Code Compatible](https://img.shields.io/badge/Claude%20Code-Compatible-orange?style=for-the-badge)](https://claude.ai)
[![MIT License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-v1.0.0-purple?style=for-the-badge)](https://github.com/dnorth123/claude-code-project-starter/releases)

A structured template for building solo projects with Claude Code. This template is perfect for beginners and more advanced users. This template provides automatic status tracking, intelligent context management, and a phase-based development approach that maximizes productivity while working within token limits.

## 🎯 What This Template Does

This template transforms how you build projects with Claude Code by providing:

- **Structured documentation** that keeps you organized across multiple sessions
- **Automatic context management** that alerts you before hitting token limits  
- **Smart resume system** that lets you pick up exactly where you left off
- **Phase-based development** that breaks projects into manageable chunks
- **Token-efficient design** that preserves 80-85% of context for actual coding

## ✨ Key Features

### Automatic Status Updates

- Say `"Update status"` and Claude automatically updates your progress
- Tracks completed tasks, decisions made, and next steps
- Maintains a session log for easy reference

### Intelligent Context Management

- 🟢 Green (< 70%): Smooth sailing
- 🟡 Yellow (70-85%): Note for later  
- 🟠 Orange (85-95%): Clear after current task
- 🔴 Red (95%+): Clear immediately
- Proactive alerts before you hit limits
- Guides you through context clears smoothly

### Phase-Based Development

- Planning phase helps define scope and approach
- Breaks development into logical phases (typically 3-5)
- Each phase has clear goals and deliverables
- Git tags at phase completions for easy rollback

### Smart Session Resume

- Close Claude Code anytime, resume exactly where you left off
- Simple command: `"Check the build status and tell me where we are at"`
- Claude loads minimal context (~4K tokens) but knows full project state

## 🎨 Perfect For

- **Side Projects** - Finally finish those weekend projects
- **Learning Projects** - Build while learning new frameworks
- **Prototypes** - Quickly validate ideas with working code
- **Tools & Utilities** - Create personal productivity tools
- **Experiments** - Try new technologies with structure

## 🚀 Getting Started

### Create New Project from Template

#### Option 1: GitHub CLI (Recommended)

```bash
# Create and clone in one command
gh repo create my-awesome-project --template dnorth123/claude-code-project-starter --private --clone
cd my-awesome-project
```

#### Option 2: GitHub Web

1. Click the ["Use this template"](https://github.com/dnorth123/claude-code-project-starter/generate) button above
2. Name your new repository
3. Clone your new repo locally

#### Option 3: Direct Clone & Setup

```bash
# Clone the template
git clone https://github.com/dnorth123/claude-code-project-starter.git my-awesome-project
cd my-awesome-project

# Remove template git history and start fresh
rm -rf .git
git init
git add .
git commit -m "Initial commit from claude-code-project-starter template"
```

### Initial Setup (5 minutes)

1. **Update project docs with your specifics:**
   
   **Your Project Plan** (docs/project/project-plan.md)    
   
   Define what you're building: overview, scope, user flows, features/requirements, and more.
   
   Fill in what you know, leave `[TBD]` or `[Unsure]` for items to discuss with Claude.
   
   Once you start the planning process, Claude Code will:
   
   1. Review what you've defined
   2. Ask questions to fill gaps
   3. Help refine scope and requirements
   4. Create detailed phase plans
   5. Get you ready to start building
   
   **Your Tech Stack** (docs/project/tech-stack.md)
   
   Define the core technologies you want to use, key dependencies, architecture notes and more. 
   
   Fill in what you know. Mark uncertain items as `[TBD]` or `[Considering...]`.
   
   During the planning process, Claude Code will:
   
   1. Review your defined stack
   2. Ask about `[TBD]` items
   3. Recommend technologies based on your requirements
   4. Help make final decisions
   5. Document rationale
   6. Prepare for Phase 1 development

        **Build Status Tracker** (docs/project/build-status.md)    

        Update with your repository URL and local folder path

```

```

2. **Start Claude Code and begin planning:**
   
   ```bash
   1. Open Claude Code in your project directory
   2. Switch to Plan Mode using Shift+Tab
   3. Then enter:
   "Check the docs/project/ folder and help me get started"
   ```

3. **Claude will:**
   
   - Review your initial project plan and tech stack.
   - Ask clarifying questions based on what you've provided
   - Help finalize and document technical decisions
   - Iteratively work with you to create detailed phase plans
   - Give you a firm foundation to start building

## 📁 Template Structure

```
your-project/
├── docs/
│   └── project/
│       ├── build-status.md       # Current status & progress tracking
│       ├── project-plan.md       # Requirements & features
│       ├── tech-stack.md         # Technical decisions
│       ├── roadmap.md           # Future enhancements (auto-populated)
│       └── phases/               # Detailed phase plans (created during planning)
├── .claude/
│   └── claude.md                 # Session context (auto-updated)
├── .gitignore
├── README.md                     # Project readme (customize this)
└── SETUP.md                      # Template instructions & tips
```

## 🚀 Beyond MVP: Roadmap System

The template includes a built-in roadmap system that:

- **Captures future ideas** without disrupting current development
- **Prevents scope creep** by giving ideas a proper home
- **Enables continuous development** after MVP completion
- **Maintains momentum** with natural transition to v2 features

During planning or on-going development, simply say:

- `"Add to roadmap: [feature idea]"`
- `"That's a good v2 feature"`
- `"Let's save that for later"`

Claude automatically maintains your roadmap and offers to plan enhancements after MVP completion.

## 🔧 How the Process Works

### Day 1: Planning (30 minutes)

```bash
"Check the docs/project/ folder and help me get started"
# Claude reviews docs, asks questions, creates phase plans

"Start Phase 1"
# Begin building foundation

"Update status"
# Save progress before ending session
```

### Day 2: Continue Development

```bash
"Check the build status and tell me where we are at"
# Claude loads status, reminds you of context, continues work

"Phase 1 complete"
# Claude tags completion, checks context health

"Start Phase 2"
# Move to next phase
```

### When Context Gets Full

```bash
# Claude alerts: 🟠 Orange - approaching limit

"Save everything"
# Claude updates all docs, commits changes

/clear
# You clear context in Claude Code

"Check the build status and tell me where we are at"
# Resume with fresh context
```

## 📝 Key Commands

| Command                                                    | What It Does                | When to Use               |
| ---------------------------------------------------------- | --------------------------- | ------------------------- |
| `"Check the docs/project/ folder and help me get started"` | Starts planning session     | First time only           |
| `"Check the build status and tell me where we are at"`     | Loads project status        | Resume work               |
| `"Update status"`                                          | Auto-updates progress       | Every 30-60 min           |
| `"Check context"`                                          | Shows token usage           | Verify context health     |
| `"Start Phase [N]"`                                        | Begins new phase            | After planning/completion |
| `"Phase [N] complete"`                                     | Marks phase done            | End of phase              |
| `"Save everything"`                                        | Prepares for context clear  | Before `/clear`           |
| `"Add to roadmap: [idea]"`                                 | Captures future enhancement | Anytime during dev        |
| `"Review roadmap"`                                         | Reviews collected ideas     | After MVP completion      |

## 💡 Token Budget Management

The template is designed to provide a robust development system that minimizes token usage and maximizes coding time:

| Activity                 | Token Usage   | % of Budget |
| ------------------------ | ------------- | ----------- |
| Planning (one-time)      | ~26K          | 13%         |
| Resume session           | ~4-7K         | 2-3.5%      |
| Status update            | ~3K           | 1.5%        |
| **Available for coding** | **~160-170K** | **80-85%**  |

## 🎯 Example Use Cases

### Weekend Project

- Friday night: 30 min planning session
- Saturday: 2-3 hours Phase 1 (foundation)
- Sunday morning: 2 hours Phase 2 (features)
- Sunday afternoon: 1 hour Phase 3 (polish)
- **Result**: Deployed working project by Sunday evening

### Learning Project

- Define learning goals in project-plan.md
- Choose technologies you want to learn
- Build something real while learning
- Phase structure prevents overwhelm
- Git tags let you experiment safely

### Proof of Concept

- Quickly validate an idea
- Focus on core functionality in Phase 1
- Add nice-to-haves only if time permits
- Ship MVP fast with structured approach

## 🔥 Pro Tips

1. **Be specific in planning** - The better your project-plan.md, the smoother development goes
2. **Trust the phases** - Resist adding features mid-phase, note them for later
3. **Update regularly** - Run `"Update status"` every 30-60 minutes
4. **Clear when prompted** - Don't push context limits, clear when Claude suggests
5. **Use git tags** - Phase completion tags make rollback easy if experiments fail
6. **Capture all ideas** - Use `"Add to roadmap"` liberally; filter later when planning v2

## 📊 Version History

See [Releases](https://github.com/dnorth123/claude-code-project-starter/releases) for a detailed version history.

### Latest: v1.0.0 (November 2025)

- ✅ Initial release with core template structure
- ✅ Automatic status tracking system
- ✅ Intelligent context management
- ✅ Phase-based development workflow
- ✅ Complete documentation

## 🤝 Contributing

This is a personal template, but suggestions are welcome! Feel free to:

- Fork and customize for your workflow
- Open issues for bugs or improvements
- Share your customizations
- Submit PRs with enhancements

## 📄 License

MIT License - Use this template however you want! See [LICENSE](LICENSE) file for details.

## 🙌 Acknowledgments

Built specifically for use with [Claude Code](https://claude.ai) and Anthropic's Claude AI assistant. The template structure is designed around Claude's context windows and capabilities.

Special thanks to:

- The Claude Code team at Anthropic for making AI-assisted development accessible
- The open source community for inspiration on project structuring

## 🌟 Show Your Support

If this template helps you ship projects:

- ⭐ Star this repo
- 🐦 Share it on social media
- 💬 Let me know what you built with it!

---

**Ready to build something awesome?** Click ["Use this template"](https://github.com/dnorth123/claude-code-project-starter/generate) and turn that project idea into reality! 🚀

Remember: The best project is a shipped project. This template helps you ship.