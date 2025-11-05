# Claude Configuration

## Environment Variables

### Performance Optimization
- **CLAUDE_DANGEROUS_SKIP_PERMISSIONS=true**: Enabled globally in `~/.zshrc` for faster file operations (75% speed boost)
  - This bypasses certain safety permissions to improve performance
  - Already configured for all sessions and projects

## Available Agents

Claude Code provides specialized agents for different types of tasks. These can be launched using the Task tool:

### Development Agents
- **general-purpose**: General-purpose agent for researching complex questions, searching for code, and executing multi-step tasks
- **Full-Stack Developer**: Modern full-stack development specialist for rapid MVP development with Next.js, React, Vue, Node.js, Supabase, and other contemporary web technologies
- **Code Reviewer**: Code quality specialist focused on architecture review, refactoring suggestions, best practices, code optimization, and maintaining technical standards
- **Debug Specialist**: Troubleshooting expert for complex technical issues across languages and frameworks, root cause analysis, and systematic problem resolution
- **devops-engineer**: DevOps specialist for deployment, monitoring, CI/CD, and infrastructure optimization
- **data-analyst**: Analytics specialist for metrics, insights, and data-driven decision making

### Design & UX Agents
- **ux-designer**: Product designer specializing in interface design, interaction patterns, design systems, visual design, and prototyping
- **ux-researcher**: User research specialist focusing on user interviews, usability testing, behavioral analysis, research methodology, and user insights

### Content & Strategy Agents
- **content-strategist**: Content strategy and copywriting expert specializing in messaging, brand voice, content marketing, UX writing, and customer-facing communications
- **product-strategist**: Comprehensive product management expert handling both strategic (market analysis, competitive positioning, roadmap planning, business strategy) and tactical work (PRDs, user stories, functional requirements, feature specifications)
- **tech-writer**: Documentation specialist for technical and user-facing documentation

### Quality & Security Agents
- **Test Generator**: QA specialist with TDD enforcement and 80% coverage requirements for comprehensive testing
- **Security Reviewer**: Security specialist for defensive security auditing, vulnerability assessment, secure coding practices, compliance (GDPR, SOC2), and security architecture review

### Productivity & Workflow Agents
- **Productivity Optimizer**: ADHD workflow specialist optimizing productivity systems for neurodivergent entrepreneurs
- **Launch Orchestrator**: 7-day launch coordinator specializing in rapid product launches and go-to-market execution
- **AI Architect**: Multi-agent workflow designer specializing in Claude-powered automation and intelligent system orchestration

### Discovery & Research Agents
- **Discovery Researcher**: Market validation specialist for rapid product discovery and customer insights
- **Prompt Engineer**: Claude optimization specialist for AI-powered product development and automation

### Configuration Agents
- **statusline-setup**: Use this agent to configure the user's Claude Code status line setting
- **output-style-setup**: Use this agent to create a Claude Code output style

---

## How to Use Agents

### Invoking Agents

**Natural language (recommended):**
```
"I need a full-stack developer to help build authentication"
"Can a debug specialist help me with this error?"
"I need a UX designer to design the dashboard"
```

Claude will automatically route to the appropriate agent.

**Explicit invocation:**
Use the Task tool with specific subagent_type parameter.

### Recommended Agent Workflows

**For New Features:**
1. Product Strategist → Define requirements
2. Full-Stack Developer → Implement
3. Test Generator → Create tests
4. Code Reviewer → Review quality

**For Launch:**
1. Launch Orchestrator → Plan 7-day sprint
2. Content Strategist → Create marketing copy
3. DevOps Engineer → Setup deployment

**For Troubleshooting:**
1. Debug Specialist → Identify root cause
2. Security Reviewer → Check if security-related
3. Full-Stack Developer → Implement fix
4. Test Generator → Prevent regression

**For UI/UX Work:**
1. UX Researcher → User insights
2. UX Designer → Design solution
3. Full-Stack Developer → Implement
4. UX Researcher → Validate with users

**For Pre-Launch:**
1. Code Reviewer → Architecture review
2. Security Reviewer → Security audit
3. DevOps Engineer → Deployment setup
4. Test Generator → Full coverage check
5. Content Strategist → Launch messaging
6. Launch Orchestrator → 7-day launch plan

**Most Used Agents:**
- **Full-Stack Developer** - Primary development partner (use 80% of the time)
- **Debug Specialist** - When stuck on errors
- **Code Reviewer** - Before merging, phase completions
- **Test Generator** - Quality assurance

**Quick Reference:** See `AGENT-QUICK-REF.md` for complete usage guide

---

## Custom Workspace Commands

These custom commands automate common workflows:

### `/setup-template` (Project Template Only)
**Location:** `project-template/.claude/commands/setup-template.md`
**Use when:** Starting a new project from template
**What it does:** Guides through Phase 0 planning, creates phase plans, updates BUILD-STATUS

### `/update-status`
**Location:** `.workspace/commands/update-status.md`
**Use when:** After completing tasks, before context clear, end of session
**What it does:** Analyzes session, updates .session-log.md, project .status, BUILD-STATUS.md, commits changes

### `/check-context`
**Location:** `.workspace/commands/check-context.md`
**Use when:** Want to see token usage, before starting major work, during long sessions
**What it does:** Reports token usage, health status (🟢🟡🟠🔴), provides clear recommendations

### `/workspace-status`
**Location:** `.workspace/commands/workspace-status.md`
**Use when:** Starting work, switching projects, checking what's active
**What it does:** Shows recent projects, loads most recent BUILD-STATUS, suggests what to work on

### `/capture-roadmap-item` (Passive - Auto-runs)
**Location:** `project-template/.claude/commands/capture-roadmap-item.md`
**Triggers:** "Save for v2", "Out of scope", "Add to roadmap", etc.
**What it does:** Automatically captures deferred ideas to docs/project/roadmap.md

**Usage:** These commands work via natural language or slash command syntax

---

## MCP Servers

### Brave Search
- **Server**: `brave-search`
- **Type**: stdio
- **Command**: `npx @modelcontextprotocol/server-brave-search`
- **Scope**: User (available in all projects)
- **API Key**: Configured in `~/.claude.json`

#### Setup
The Brave Search MCP server has been configured to work across all projects. It provides web search capabilities through the Brave Search API.

To add or update the server:
```bash
# Add to user config (all projects)
claude mcp add brave-search -s user -- npx @modelcontextprotocol/server-brave-search

# Add to specific project only
claude mcp add brave-search -s project -- npx @modelcontextprotocol/server-brave-search
```

#### API Key Management
The API key is stored in the configuration file with the environment variable `BRAVE_API_KEY`.

To get a new API key:
1. Visit https://brave.com/search/api/
2. Sign up for an account
3. Generate an API key from the dashboard

---

## Workspace Status Commands

### Quick Status Check
**Command**: "What's the status of my projects"

**What happens**:
1. Claude reads `.session-log.md` (~150 tokens)
2. Identifies most recently active project
3. Reads project `.status` file (~15-150 tokens)
4. Auto-loads BUILD-STATUS.md if it exists (~1-3K tokens)
5. Presents summary:
   - **Most Recent Project**: Name, phase/status, next action, last worked
   - **Other Recent Projects** (2-3): Names, high-level status, last worked
   - **Context Health**: Current token usage with color indicator

**Example response**:
```
Most Recent: my-web-app
- Status: Phase 3 - Implementation
- Next: Complete authentication module
- Last worked: Nov 1, 2025

Recent Projects:
- portfolio-site: Phase 4 Complete - Production Ready
- experiment-react-hooks: Phase 1 - Planning

Context: 60K tokens (30%) 🟢

Which would you like to work on?
```

### Project Selection
**Command**: "Work on [project-name]" or just say the project name

**What happens**:
1. Claude auto-loads project BUILD-STATUS.md (if exists)
2. Reports current status and next task
3. Ready to continue work immediately

### Context Monitoring
**Active tracking** with automatic alerts using health zones:
- 🟢 Green (< 70%) | 🟡 Yellow (70-85%) | 🟠 Orange (85-95%) | 🔴 Red (> 95%)

**Manual check:** Say "Check context" or use `/check-context` command

**Detailed thresholds:** See `CONTEXT-THRESHOLDS.md` for complete guidelines

**Clear workflow:**
1. "Update status" - saves all progress
2. `/clear` - resets context
3. "Check the build status" - loads ~4K tokens, ready to continue

### Status Updates
**Command**: "Update status"

**What happens**:
1. Claude analyzes current session and file changes
2. Updates `.session-log.md` (appends session entry)
3. Updates project `.status` file
4. Updates project BUILD-STATUS.md if exists
5. Shows summary and next steps

### Files Structure
```
~/Projects/
├── .workspace/                  # Workspace configuration
│   ├── CLAUDE.md               # This file - Commands & preferences
│   ├── .session-log.md         # Session tracking (~150 tokens)
│   └── README.md               # Workspace setup guide
│
├── projects/                    # All coding projects
│   ├── personal/               # Personal projects
│   │   ├── my-web-app/
│   │   │   ├── .status        # Quick status (~100 tokens)
│   │   │   └── BUILD-STATUS.md # Full tracking (~3K tokens)
│   │   └── portfolio-site/
│   │       └── .status         # Simple one-liner (~50 tokens)
│   │
│   └── templates/              # Project templates
│       └── cc-project-starter-template/
│           └── .status         # Template status (~80 tokens)
│
└── .gitignore                   # Excludes tracking files
```

### Token Budget
- **Status check**: 200-500 tokens (0.1-0.25%)
- **Project resume**: 1,500-4,000 tokens (0.75-2%)
- **Total overhead**: < 2% for full workspace context

### Notes
- `.status` files are context-aware: simple projects get one line, complex projects get more detail
- `.session-log.md` auto-trims to last 30 entries
- Both files are local-only (in .gitignore)

---

## Project Templates

### Using Templates

**Start new project from template**:
```bash
cd projects/personal
cp -r ../../.workspace/templates/project-starter my-new-project
cd my-new-project
# Follow template setup
```

**Template locations**:
- `.workspace/templates/project-starter/` - Stable version for creating new projects
- `projects/templates/cc-project-starter-template/` - Working/development copy

### Developing Templates

**Update workflow**:
1. **Edit** working copy: `projects/templates/cc-project-starter-template/`
2. **Test** changes by creating a test project
3. **Sync** to stable: `./sync-templates.sh`
4. **Decide** if shareable (check `.workspace/ROADMAP.md`)
5. If "Template Improvement":
   - Push to GitHub repo
   - Update workspace-starter-template (when created)
   - Mark complete in ROADMAP.md

### Template Types

**project-starter** (cc-project-starter-template):
- Full project setup with BUILD-STATUS.md
- Phase-based development
- Automatic status tracking
- Context management
- Use for: Complex projects, MVPs, learning projects

**Future templates** (ideas):
- `simple-project` - Minimal setup for quick experiments
- `library` - Package/library starter
- `cli-tool` - Command-line tool template

---

## Workspace Improvements

### Roadmap System

**Track improvements** in `.workspace/ROADMAP.md`:

**Categories**:
- **Personal Workspace Improvements** - Just for your workflow
- **Template Improvements** - Share with others via workspace-starter-template
- **Ideas Parking Lot** - Future possibilities

**Workflow**:
1. Add idea to appropriate section in ROADMAP.md
2. Implement when ready
3. Move to "Completed" section
4. If "Template Improvement" → update public template

**Review**: Check roadmap monthly or when planning workspace enhancements

### Decision Log

ROADMAP.md includes a decision log for tracking:
- Why certain structural choices were made
- Trade-offs considered
- Alternative approaches evaluated

This helps Future You understand current setup.
