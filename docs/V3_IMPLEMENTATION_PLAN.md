# Claude Code Project Starter v3.0 - Implementation Plan

## Executive Summary

Complete overhaul of the Claude Code Project Starter template to leverage the latest Claude Code capabilities, including:

- **Dynamic model recommendations** (Opus 4.5 / Sonnet 4.5 / Haiku 4.5)
- **Hooks system** for automated environment validation and session management
- **Full sub-agent integration** using Claude Code's Task tool
- **Skills system** for custom slash commands
- **Extended thinking** patterns for complex planning
- **Background tasks** for long-running operations
- **Hybrid agent system**: Real sub-agents + role-based personas

**Target Users**: Personal projects that can scale to professional-level applications.

---

## Current State Analysis

### What Exists (v2.0.0)
- Phase-based development workflow
- Token/context management with 4-tier alerts
- Permission presets (Aggressive/Moderate/Conservative/Maximum Security)
- Multi-project workspace support
- "Agents" that are actually role-based prompt templates (17+ personas)
- Custom commands via markdown files
- Integration system for existing projects

### What's Missing
| Feature | Current State | Gap |
|---------|--------------|-----|
| Model selection | Not referenced | No dynamic recommendations |
| Hooks | Not used | No session-start automation |
| Real sub-agents | Conceptual only | Not using Task tool |
| Skills | Not used | Commands are manual markdown |
| Extended thinking | Not referenced | No complex reasoning guidance |
| Background tasks | Not used | No async operation patterns |
| Model Context Protocol | Basic Brave Search only | Limited MCP leverage |

---

## v3.0 Architecture

### Core Philosophy Changes

```
v2.0 Philosophy: "Template system with documentation"
v3.0 Philosophy: "Intelligent development companion with adaptive capabilities"
```

**Key Shifts:**
1. **Static → Dynamic**: Model selection adapts to task complexity
2. **Manual → Automated**: Hooks handle setup, validation, status updates
3. **Conceptual → Real**: Sub-agents actually invoked via Task tool
4. **Documentation → Intelligence**: System learns project patterns

---

## Implementation Phases

### Phase 1: Foundation - Model & Hooks System

#### 1.1 Dynamic Model Recommendation System

**New File**: `.claude/MODEL-STRATEGY.md`

```markdown
# Model Selection Strategy

## Automatic Model Recommendations

Claude Code will recommend the optimal model based on task characteristics:

### Opus 4.5 (claude-opus-4-5-20251101)
**Best for:** Complex reasoning, architecture decisions, difficult debugging
- Multi-file refactoring
- System architecture design
- Complex algorithm implementation
- Security audits
- Performance optimization analysis
- Extended thinking tasks

### Sonnet 4.5
**Best for:** Day-to-day development, feature implementation
- Feature development
- Code reviews
- Test writing
- Documentation
- API integration
- Standard debugging

### Haiku 4.5
**Best for:** Quick operations, simple edits
- File navigation
- Simple edits
- Status checks
- Git operations
- Quick lookups
- Formatting fixes
```

**Implementation**: Add model recommendation logic to `claude.md` that suggests models based on:
- Task keywords (e.g., "architecture" → Opus, "quick fix" → Haiku)
- File complexity (number of files, LOC)
- Phase of development (planning → Opus, implementation → Sonnet)
- Error complexity (simple syntax → Haiku, complex logic → Opus)

#### 1.2 Hooks System

**New Directory**: `.claude/hooks/`

```
.claude/hooks/
├── session-start.sh          # Runs on every session start
├── pre-commit-validation.sh  # Runs before commits (optional)
└── context-checkpoint.sh     # Runs at context thresholds
```

**session-start.sh** (Primary Hook):
```bash
#!/bin/bash
# Claude Code Session Start Hook
# Validates environment and prepares for development

set -e

echo "🚀 Session Start Hook Running..."

# 1. Check Node.js version (if Node project)
if [ -f "package.json" ]; then
    required_node=$(node -p "require('./package.json').engines?.node || '18'" 2>/dev/null || echo "18")
    current_node=$(node -v 2>/dev/null || echo "not installed")
    echo "📦 Node.js: $current_node (requires: $required_node)"
fi

# 2. Check for uncommitted changes
if [ -d ".git" ]; then
    changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    if [ "$changes" -gt "0" ]; then
        echo "⚠️  Uncommitted changes: $changes files"
    else
        echo "✅ Git: Clean working tree"
    fi
fi

# 3. Check dependencies
if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
    echo "⚠️  Dependencies not installed. Run: npm install"
fi

# 4. Run project-specific validations
if [ -f ".claude/hooks/project-validate.sh" ]; then
    source .claude/hooks/project-validate.sh
fi

# 5. Load build status summary
if [ -f "docs/project/build-status.md" ]; then
    echo ""
    echo "📊 Project Status:"
    head -20 docs/project/build-status.md | grep -E "^(#|Phase|Progress|Status)" | head -5
fi

echo ""
echo "✅ Session ready. Model recommendation will appear based on your first task."
```

**Hook Configuration** (in `settings.local.json`):
```json
{
  "hooks": {
    "sessionStart": {
      "command": "bash .claude/hooks/session-start.sh",
      "timeout": 30000
    }
  }
}
```

---

### Phase 2: Sub-Agent Integration

#### 2.1 Real Sub-Agent System

Replace conceptual "agents" with actual Claude Code Task tool integration.

**New File**: `.claude/SUBAGENTS.md`

```markdown
# Claude Code Sub-Agents

## Built-in Sub-Agent Types

Claude Code provides specialized sub-agents via the Task tool:

### Explore Agent
**Type**: `Explore`
**Use for**: Codebase exploration, finding files, understanding architecture
**Invoke**: Automatic when searching/exploring

### Plan Agent
**Type**: `Plan`
**Use for**: Implementation planning, architecture decisions
**Invoke**: "Plan the implementation of [feature]"
**Features**: Extended thinking, step-by-step breakdowns

### Bash Agent
**Type**: `Bash`
**Use for**: Command execution, git operations, builds
**Invoke**: Automatic for terminal commands

### General-Purpose Agent
**Type**: `general-purpose`
**Use for**: Complex multi-step tasks, research, code search
**Invoke**: Complex tasks requiring autonomy

## Sub-Agent Patterns

### Parallel Exploration
For comprehensive understanding, launch multiple Explore agents:
- "Explore the authentication system"
- "Find all API endpoints"
- "Analyze the database schema"

### Sequential Planning
For complex features, chain agents:
1. Explore Agent → Understand current state
2. Plan Agent → Design implementation
3. General-Purpose Agent → Execute implementation

### Background Operations
For long-running tasks:
- Build processes
- Test suites
- Database migrations
```

#### 2.2 Hybrid Agent System (Sub-Agents + Role Personas)

Keep role-based personas for perspective/expertise, but clarify they're prompting strategies, not real agents.

**Renamed File**: `.workspace/ROLE-PERSONAS.md` (was `AGENT-QUICK-REF.md`)

```markdown
# Role Personas

Role personas provide specialized perspectives and expertise patterns.
They complement sub-agents by adding domain knowledge and best practices.

## How Personas Work

Personas are **prompting strategies** that shape Claude's responses.
They don't launch separate agents—they adjust the current conversation's focus.

## Available Personas

### Development Personas
- **Full-Stack Developer**: Modern web dev expertise
- **Debug Specialist**: Systematic troubleshooting approach
- **DevOps Engineer**: Infrastructure and deployment focus

### Quality Personas
- **Code Reviewer**: Architecture and best practices lens
- **Security Reviewer**: Vulnerability-focused analysis
- **Test Generator**: TDD and coverage emphasis

### Strategy Personas
- **Product Strategist**: Requirements and roadmap perspective
- **UX Designer**: User-centered design thinking
- **Content Strategist**: Messaging and copy expertise

## Combining Sub-Agents + Personas

### Example: Security Audit
1. **Explore Agent** (sub-agent): Find all auth-related code
2. **Security Reviewer** (persona): Analyze with security focus
3. **Plan Agent** (sub-agent): Create remediation plan

### Example: Feature Development
1. **Product Strategist** (persona): Define requirements
2. **Plan Agent** (sub-agent): Design implementation
3. **Full-Stack Developer** (persona): Implement with best practices
4. **Test Generator** (persona): Ensure test coverage
```

---

### Phase 3: Skills System

#### 3.1 Convert Commands to Skills

Transform markdown commands into proper Claude Code skills.

**Updated Structure**:
```
.claude/
├── commands/           # Keep for compatibility
│   └── *.md
└── skills/             # New: Proper skills
    ├── setup-project.md
    ├── smart-commit.md
    ├── context-checkpoint.md
    ├── model-recommend.md
    └── launch-subagent.md
```

**Example Skill**: `/smart-commit`

```markdown
# Smart Commit

Analyze changes and create an intelligent commit with the recommended model.

## Behavior

1. **Analyze Changes**
   - Run `git diff --staged` and `git diff`
   - Categorize: feature/fix/refactor/docs/test/chore

2. **Recommend Model**
   - Simple changes (1-2 files, <50 lines) → Haiku 4.5
   - Standard changes → Sonnet 4.5
   - Complex refactors → Opus 4.5

3. **Generate Commit Message**
   - Follow conventional commits format
   - Include scope if detectable
   - Add body for complex changes

4. **Execute**
   - Stage relevant files
   - Create commit
   - Show result

## Usage
`/smart-commit` or "commit my changes intelligently"
```

---

### Phase 4: Extended Thinking & Background Tasks

#### 4.1 Extended Thinking Patterns

**New File**: `.claude/THINKING-PATTERNS.md`

```markdown
# Extended Thinking Patterns

## When to Use Extended Thinking

Extended thinking (deep reasoning mode) is valuable for:

### Architecture Decisions
- System design choices
- Technology selection
- Scalability planning
- Trade-off analysis

### Complex Debugging
- Multi-system issues
- Race conditions
- Memory leaks
- Performance bottlenecks

### Security Analysis
- Threat modeling
- Vulnerability assessment
- Attack surface analysis

### Refactoring
- Large-scale restructuring
- API redesign
- Database schema changes

## Triggering Extended Thinking

Use these phrases to encourage deep analysis:
- "Think through this carefully..."
- "Consider all the implications..."
- "What are the trade-offs between..."
- "Analyze the architecture of..."

## Model Pairing

Extended thinking works best with:
- **Opus 4.5**: Maximum reasoning depth
- **Sonnet 4.5**: Good balance of speed/depth
```

#### 4.2 Background Task Patterns

**New File**: `.claude/BACKGROUND-TASKS.md`

```markdown
# Background Task Patterns

## When to Use Background Tasks

Background tasks allow continued work while long operations run.

### Ideal For
- Test suite execution (>30 seconds)
- Build processes
- Linting large codebases
- Database migrations
- Deployment scripts

### How to Use

1. **Launch in Background**
   "Run the tests in the background and continue with the next task"

2. **Check Status**
   "What's the status of the background tests?"

3. **Review Results**
   When notified of completion, review output

### Patterns

**Parallel Development**
```
1. Launch test suite in background
2. Continue implementing next feature
3. Review test results when complete
4. Fix any failures
```

**Build While Documenting**
```
1. Launch production build in background
2. Update documentation
3. Verify build succeeded
4. Deploy
```
```

---

### Phase 5: Integration System Update

#### 5.1 Enhanced Integration for Existing Projects

Update `integrate-project.sh` to include v3.0 features.

**New Integration Levels**:

| Level | Features | Time |
|-------|----------|------|
| **Minimal** | Model strategy, basic hooks | 15-30 min |
| **Standard** | + Sub-agents, skills, status tracking | 1-2 hours |
| **Full** | + Extended thinking, background tasks, personas | 2-4 hours |
| **Professional** | + Security presets, CI/CD hooks, team workflows | 4-8 hours |

**New Integration Options**:
```bash
./integrate-project.sh --level full --with-hooks --with-skills
```

---

### Phase 6: Documentation & Migration

#### 6.1 Updated Documentation Structure

```
docs/
├── QUICKSTART.md           # 5-minute getting started
├── MODEL-SELECTION.md      # When to use which model
├── SUBAGENT-GUIDE.md       # Complete sub-agent reference
├── HOOKS-GUIDE.md          # Hook configuration and examples
├── SKILLS-REFERENCE.md     # All available skills
├── MIGRATION-V2-V3.md      # Upgrading from v2.0
└── project/                # Project-specific docs (unchanged)
```

#### 6.2 Migration Guide

**MIGRATION-V2-V3.md**:
```markdown
# Migrating from v2.0 to v3.0

## Breaking Changes

1. **Agent References**
   - v2.0: "Agents" were role-based prompts
   - v3.0: Real sub-agents via Task tool + separate role personas

2. **Commands → Skills**
   - v2.0: Markdown files in `.claude/commands/`
   - v3.0: Skills in `.claude/skills/` with enhanced capabilities

3. **Model Selection**
   - v2.0: Not addressed
   - v3.0: Dynamic model recommendations throughout

## Migration Steps

### Automatic Migration
Run the migration script:
```bash
./migrate-v2-to-v3.sh
```

### Manual Migration
1. Update `.claude/` directory structure
2. Add hooks configuration
3. Convert commands to skills
4. Update CLAUDE.md references
```

---

## Implementation Order

```
Week 1: Foundation
├── Day 1-2: Model recommendation system
├── Day 3-4: Hooks system implementation
└── Day 5: Testing & refinement

Week 2: Sub-Agents & Skills
├── Day 1-2: Sub-agent documentation & integration
├── Day 3-4: Skills system implementation
└── Day 5: Hybrid agent system (personas)

Week 3: Advanced Features
├── Day 1-2: Extended thinking patterns
├── Day 3-4: Background task patterns
└── Day 5: Testing all features together

Week 4: Integration & Polish
├── Day 1-2: Update integration system
├── Day 3-4: Migration tools & documentation
└── Day 5: Final testing, README update, release
```

---

## File Changes Summary

### New Files
```
.claude/
├── hooks/
│   ├── session-start.sh
│   ├── pre-commit-validation.sh
│   └── context-checkpoint.sh
├── skills/
│   ├── setup-project.md
│   ├── smart-commit.md
│   ├── context-checkpoint.md
│   ├── model-recommend.md
│   └── launch-subagent.md
├── MODEL-STRATEGY.md
├── SUBAGENTS.md
├── THINKING-PATTERNS.md
└── BACKGROUND-TASKS.md

.workspace/
├── ROLE-PERSONAS.md (renamed from AGENT-QUICK-REF.md)
└── SUBAGENT-WORKFLOWS.md

docs/
├── QUICKSTART.md
├── MODEL-SELECTION.md
├── SUBAGENT-GUIDE.md
├── HOOKS-GUIDE.md
├── SKILLS-REFERENCE.md
└── MIGRATION-V2-V3.md

Scripts:
├── migrate-v2-to-v3.sh
└── integrate-project.sh (updated)
```

### Modified Files
```
.claude/claude.md              # Add model recommendations, hook references
.claude/settings.local.json   # Add hooks configuration
.workspace/CLAUDE.md          # Update agent references
README.md                      # Update for v3.0 features
```

### Deprecated/Removed
```
.workspace/AGENT-QUICK-REF.md  # Renamed to ROLE-PERSONAS.md
```

---

## Success Metrics

### Quantitative
- [ ] Session start time < 5 seconds with hooks
- [ ] Model recommendations appear for 90%+ of tasks
- [ ] Sub-agent invocations work reliably
- [ ] All v2.0 features still functional

### Qualitative
- [ ] Clear distinction between sub-agents and personas
- [ ] Natural model switching feels seamless
- [ ] Hooks provide useful session context
- [ ] Documentation is clear and actionable

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Breaking existing projects | Migration script + compatibility mode |
| Hook failures blocking work | Graceful degradation, timeout handling |
| Model confusion | Clear documentation, smart defaults |
| Complexity overload | Progressive disclosure, sensible defaults |

---

## Questions for Approval

Before proceeding with implementation:

1. **Hook Scope**: Should hooks run automatically or be opt-in initially?
2. **Persona Retention**: Keep all 17 personas or consolidate to core set?
3. **Skill Naming**: Use `/skill-name` or more natural invocations?
4. **Default Model**: Sonnet 4.5 as default, or let system always recommend?
5. **Integration Levels**: Is the 4-tier integration (Minimal/Standard/Full/Professional) appropriate?

---

## Next Steps

Upon approval:
1. Create feature branch for v3.0 development
2. Implement Phase 1 (Model & Hooks)
3. Iterate with feedback
4. Continue through remaining phases
5. Release v3.0

---

*Document Version: 1.0*
*Created: January 2026*
*Status: Awaiting Approval*
