# Claude Code Project Starter Template

[![Use this template](https://img.shields.io/badge/Use%20this-template-blue?style=for-the-badge)](https://github.com/dnorth123/claude-code-project-starter/generate)
[![Claude Code Compatible](https://img.shields.io/badge/Claude%20Code-Compatible-orange?style=for-the-badge)](https://claude.ai)
[![MIT License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-v3.0.0-purple?style=for-the-badge)](https://github.com/dnorth123/claude-code-project-starter/releases)

**An intelligent development companion** that maximizes Claude Code's latest capabilities. Dynamic model recommendations, real sub-agents, automated hooks, and structured workflows - all designed for personal projects that can scale to professional quality.

---

## What's New in v3.0.0

### Dynamic Model Recommendations
Claude analyzes every task and recommends the optimal model with pros/cons:
- **Opus 4.5**: Complex architecture, security audits, deep debugging
- **Sonnet 4.5**: Day-to-day development, feature implementation
- **Haiku 4.5**: Quick edits, git operations, status checks

### Real Sub-Agent Integration
Leverage Claude Code's Task tool for autonomous work:
- **Explore Agent**: Fast codebase understanding
- **Plan Agent**: Implementation strategy design
- **Bash Agent**: Command execution (with background support)
- **General-Purpose Agent**: Complex multi-step tasks

### Automated Hooks System
- **Auto-run hooks**: Environment validation on session start
- **Validated hooks**: Pre-commit linting, test runners (require confirmation)

### 8 Consolidated Role Personas
Focused expertise perspectives (down from 17):
- Full-Stack Developer, Debug Specialist, Code Reviewer, Security Reviewer
- Test Engineer, DevOps Engineer, Product Strategist, UX Designer

### Simplified Integration
Two clear tiers for existing projects:
- **Essential**: Model strategy, auto-hooks, sub-agents, personas
- **Extended**: + Validated hooks, permission presets, advanced patterns

---

## Quick Start

### New Project (5 minutes)

```bash
# Clone the template
git clone https://github.com/dnorth123/claude-code-project-starter.git my-project
cd my-project

# Run setup
./setup-project.sh

# Start Claude Code
claude
```

Then say: `"Check the docs/project/ folder and help me get started"`

### Existing Project (15-30 minutes)

```bash
# Essential tier (recommended)
./integrate-project.sh /path/to/your-project

# Extended tier (for complex/team projects)
./integrate-project.sh /path/to/your-project --extended
```

See [INTEGRATE-EXISTING.md](INTEGRATE-EXISTING.md) for details.

---

## Core Features

### Model Recommendations

Every task gets an intelligent recommendation:

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

**Override anytime**: "Use Opus for this" or "Quick mode" (Haiku)

### Sub-Agent Workflows

Use real autonomous agents for complex work:

```
Pattern: Explore -> Plan -> Execute

1. "Explore the authentication system"     -> Explore Agent
2. "Plan adding OAuth2 support"            -> Plan Agent
3. "Implement the OAuth2 plan"             -> General-Purpose Agent
4. "Run tests in background"               -> Bash Agent (background)
```

### Automated Session Start

When you start Claude Code, the session-start hook automatically:
- Checks git status and branch
- Validates dependencies (Node, Python, etc.)
- Shows project phase and progress
- Prepares model recommendations

### 8 Role Personas

Invoke specialized perspectives:

| Persona | Focus | Invoke With |
|---------|-------|-------------|
| **Full-Stack Developer** | Implementation | "Build...", "Implement..." |
| **Debug Specialist** | Troubleshooting | "Help me debug...", "I'm getting this error..." |
| **Code Reviewer** | Quality | "Review this code..." |
| **Security Reviewer** | Vulnerabilities | "Security review..." (always uses Opus) |
| **Test Engineer** | Testing | "Write tests for..." |
| **DevOps Engineer** | Infrastructure | "Help me deploy..." |
| **Product Strategist** | Requirements | "Help me define..." |
| **UX Designer** | User experience | "Design the interface..." |

---

## Two Operating Modes

### Single Project Mode

**Best for**: Focused development on one project

```bash
./setup-project.sh /path/to/new-project
```

**You get**:
- Automatic status tracking (build-status.md)
- Phase-based development (0-4)
- Smart session resume (~4K tokens)
- All v3.0 features

### Workspace Mode

**Best for**: Managing 3-10+ concurrent projects

```bash
./setup-workspace.sh
```

**You get everything in Single Project, plus**:
- Multi-project status dashboard
- Cross-project session logging
- Template management system
- Project categories (personal/work/client)

---

## File Structure

### Project Template

```
your-project/
├── .claude/
│   ├── claude.md              # Session context
│   ├── settings.local.json    # Permissions & hooks
│   ├── MODEL-STRATEGY.md      # Model recommendations
│   ├── SUBAGENTS.md           # Sub-agent patterns
│   ├── PERSONAS.md            # 8 role personas
│   └── hooks/
│       ├── auto/              # Auto-run on session start
│       │   └── session-start.sh
│       └── validated/         # Require confirmation
│           ├── pre-commit.sh
│           └── test-runner.sh
├── docs/project/
│   ├── build-status.md        # Progress tracking
│   ├── project-plan.md        # Requirements
│   ├── tech-stack.md          # Technology decisions
│   └── roadmap.md             # Future enhancements
└── README.md
```

---

## Commands Reference

### Status & Resume

| Command | Effect |
|---------|--------|
| `"Check the build status"` | Resume work, see current phase |
| `"Update status"` | Auto-update all documentation |
| `"Check context"` | See token usage |

### Model Selection

| Command | Effect |
|---------|--------|
| `"Use Opus for this"` | Force Opus 4.5 |
| `"Quick mode"` / `"Use Haiku"` | Force Haiku 4.5 |
| `"Standard"` | Use Sonnet 4.5 |

### Sub-Agents

| Command | Sub-Agent |
|---------|-----------|
| `"Find all files related to..."` | Explore |
| `"Plan the implementation of..."` | Plan |
| `"Run tests in background"` | Bash (background) |
| `"Implement this autonomously"` | General-Purpose |

### Validated Hooks

| Command | Effect |
|---------|--------|
| `"Run pre-commit checks"` | Lint/format (may modify files) |
| `"Run the test suite"` | Execute tests |

---

## Context Management

### Token Thresholds

- 🟢 **Green** (<70%): Normal operation
- 🟡 **Yellow** (70-85%): Note for later
- 🟠 **Orange** (85-95%): Clear after current task
- 🔴 **Red** (>95%): Clear immediately

### Context Clear Workflow

```bash
1. "Update status"        # Save progress
2. /clear                 # Clear context
3. "Check build status"   # Resume (~4K tokens)
```

---

## Permission Presets

Run `/setup-permissions` to configure:

| Preset | Description |
|--------|-------------|
| **Aggressive** (default) | Auto-approve everything, maximum speed |
| **Moderate** | Balanced - ask for execution commands |
| **Conservative** | More oversight on changes |
| **Maximum Security** | Approve nearly everything manually |

---

## Integration for Existing Projects

Two tiers available:

### Essential Tier (Recommended)

```bash
./integrate-project.sh /path/to/project
```

**Includes**:
- MODEL-STRATEGY.md (dynamic recommendations)
- SUBAGENTS.md (sub-agent documentation)
- PERSONAS.md (8 role personas)
- Auto-run session-start hook
- Status tracking

### Extended Tier

```bash
./integrate-project.sh /path/to/project --extended
```

**Adds**:
- Validated hooks (pre-commit, test-runner)
- Permission presets
- Advanced commands

---

## Migration from v2.0

See [MIGRATION-V2-V3.md](docs/MIGRATION-V2-V3.md) for upgrade instructions.

**Breaking changes**:
- "Agents" renamed to "Personas" (17 → 8)
- Integration tiers simplified (4 → 2)
- Hooks system added (requires settings.local.json update)

---

## Documentation

| Document | Purpose |
|----------|---------|
| [QUICKSTART.md](docs/QUICKSTART.md) | 5-minute getting started |
| [MIGRATION-V2-V3.md](docs/MIGRATION-V2-V3.md) | Upgrading from v2.0 |
| [INTEGRATE-EXISTING.md](INTEGRATE-EXISTING.md) | Adding to existing projects |
| `.claude/MODEL-STRATEGY.md` | Model recommendation guide |
| `.claude/SUBAGENTS.md` | Sub-agent patterns |
| `.claude/PERSONAS.md` | 8 role personas |
| `.claude/hooks/README.md` | Hooks documentation |

---

## Requirements

- Claude Code CLI
- Git
- Bash 4.0+

**Optional**:
- Node.js (for Node projects)
- Python (for Python projects)
- GitHub CLI (for PR/issue management)

---

## License

MIT License - see [LICENSE](LICENSE) for details.

---

## Acknowledgments

Built for the Claude Code community.

- **Optimized for**: Opus 4.5, Sonnet 4.5, Haiku 4.5
- **Designed for**: Personal projects scaling to professional quality
- **Tested with**: Real-world development workflows

---

## Get Started

1. **Clone or use template**
2. **Run setup wizard** (`./setup-project.sh`)
3. **Start Claude Code** (`claude`)
4. **Say**: "Check the docs/project/ folder and help me get started"

**Happy coding with Claude Code v3.0!**

---

**Questions?** [Open an issue](https://github.com/dnorth123/claude-code-project-starter/issues)
