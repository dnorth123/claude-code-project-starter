# Claude Code Project Starter v3.0 - Implementation Plan

> **Status**: APPROVED - Implementation in Progress
> **Version**: 1.1 (Refined based on feedback)
> **Updated**: January 2026

## Executive Summary

Complete overhaul of the Claude Code Project Starter template to leverage the latest Claude Code capabilities:

- **Dynamic model analysis** with pros/cons recommendations (Opus 4.5 / Sonnet 4.5 / Haiku 4.5)
- **Hooks system** with automatic + user-validated categories
- **Full sub-agent integration** using Claude Code's Task tool
- **8 consolidated role personas** (down from 17)
- **Simplified 2-tier integration** system
- **Extended thinking** and **background task** patterns

**Target Users**: Personal projects that can scale to professional-level applications.

---

## Refined Decisions (User Feedback)

### 1. Hooks: Auto-Run vs. User Validation

| Hook Type | Behavior | Examples |
|-----------|----------|----------|
| **Auto-Run** (Safe, non-destructive) | Execute silently on session start | Environment check, git status, dependency validation, build status display |
| **User-Validated** (Potentially disruptive) | Prompt before execution | Pre-commit linting, auto-formatting, test runs, database operations |

### 2. Role Personas: Consolidated to 8

**Core 8 Personas** (optimized for sub-agent synergy):

| Persona | Focus | Complements Sub-Agent |
|---------|-------|----------------------|
| **Full-Stack Developer** | Implementation, best practices | General-purpose agent |
| **Debug Specialist** | Systematic troubleshooting | Explore agent |
| **Code Reviewer** | Quality, architecture | Plan agent |
| **Security Reviewer** | Vulnerability analysis | Explore agent |
| **Test Engineer** | TDD, coverage strategies | Bash agent |
| **DevOps Engineer** | Infrastructure, deployment | Bash agent |
| **Product Strategist** | Requirements, roadmaps | Plan agent |
| **UX Designer** | User-centered design | Plan agent |

**Removed** (merged or redundant with sub-agents):
- Tech Writer → Merged into system documentation
- Content Strategist → Specialized, add back if needed
- Discovery/UX Researcher → Merged into Product Strategist
- Productivity Optimizer → Specialized, add back if needed
- Launch Orchestrator → Merged into DevOps Engineer
- AI Architect → Specialized, add back if needed
- Prompt Engineer → Specialized, add back if needed
- Data Analyst → Specialized, add back if needed

### 3. Model Recommendations: Always Analyze

Every task receives a model recommendation with:
- **Recommended model** for the task
- **Pros** of using that model
- **Cons** / trade-offs
- **Alternative** if user prefers different trade-off

**Example Format**:
```
📊 Model Recommendation: Sonnet 4.5

Task: Implement user authentication feature

✅ Pros:
- Optimal balance of speed and capability for feature work
- Handles multi-file changes efficiently
- Good at following existing patterns

⚠️ Cons:
- May need Opus 4.5 if architectural decisions required
- Complex edge cases might benefit from deeper reasoning

🔄 Alternative: Use Opus 4.5 if this involves security-critical design decisions
```

### 4. Integration Tiers: Simplified to 2

| Tier | Description | Contents |
|------|-------------|----------|
| **Essential** | Recommended for all projects | Model strategy, auto-hooks, sub-agent docs, 8 personas, status tracking |
| **Extended** | For complex/team projects | + Validated hooks, custom skills, CI/CD integration, advanced patterns |

---

## Implementation Order (Optimized)

The most logical order for maximum value:

```
Phase 1: Model Strategy System (Foundation)
         ↓ Informs all other recommendations
Phase 2: Sub-Agent Integration (Core Capability)
         ↓ Enables advanced workflows
Phase 3: Hooks System (Automation Layer)
         ↓ Built on sub-agent patterns
Phase 4: Role Personas (Consolidated 8)
         ↓ Complements sub-agents
Phase 5: Integration System (Simplified)
         ↓ Packages everything together
Phase 6: Documentation & Migration
```

---

## Phase 1: Model Strategy System

### Goal
Create a comprehensive model recommendation system that always analyzes tasks and provides intelligent recommendations with trade-offs.

### New Files

#### `.claude/MODEL-STRATEGY.md`

```markdown
# Model Strategy System

## Always-Analyze Approach

Claude Code analyzes every task and recommends the optimal model. Recommendations include:
- Primary recommendation with rationale
- Pros and cons of the choice
- Alternative model if different trade-offs preferred

## Model Profiles

### Opus 4.5 (claude-opus-4-5-20251101)

**Strengths**:
- Deepest reasoning and extended thinking
- Best for architecture and complex decisions
- Superior at multi-file refactoring
- Excels at security analysis and edge cases
- Most thorough code review

**Best For**:
- System architecture design
- Complex debugging (race conditions, memory leaks)
- Security audits and threat modeling
- Large-scale refactoring
- Critical algorithm implementation
- Phase 0 planning and design decisions

**Trade-offs**:
- Higher latency
- Higher cost
- May be overkill for simple tasks

---

### Sonnet 4.5

**Strengths**:
- Excellent balance of speed and capability
- Strong at feature implementation
- Good pattern recognition and consistency
- Efficient multi-file editing
- Reliable test generation

**Best For**:
- Day-to-day feature development
- Standard debugging
- Code reviews (non-architectural)
- API integration
- Documentation updates
- Test writing

**Trade-offs**:
- May miss subtle architectural issues
- Complex edge cases may need Opus
- Extended thinking less powerful

---

### Haiku 4.5

**Strengths**:
- Fastest response time
- Most cost-efficient
- Excellent for routine operations
- Low latency for interactive work

**Best For**:
- File navigation and search
- Simple edits (typos, formatting)
- Git operations (commits, status)
- Quick lookups and checks
- Status updates
- Simple refactors (rename, move)

**Trade-offs**:
- Limited complex reasoning
- May miss nuances in code review
- Not suitable for architectural decisions

---

## Recommendation Matrix

| Task Type | Primary | Alternative | Notes |
|-----------|---------|-------------|-------|
| Architecture design | Opus 4.5 | Sonnet 4.5 | Use Opus for initial design, Sonnet for refinement |
| Feature implementation | Sonnet 4.5 | Opus 4.5 | Upgrade if hitting complexity walls |
| Bug fix (simple) | Haiku 4.5 | Sonnet 4.5 | Upgrade if cause unclear |
| Bug fix (complex) | Opus 4.5 | Sonnet 4.5 | Use Opus for race conditions, memory issues |
| Code review | Sonnet 4.5 | Opus 4.5 | Use Opus for security-critical or architectural review |
| Security audit | Opus 4.5 | - | Always use Opus for security |
| Test writing | Sonnet 4.5 | Haiku 4.5 | Haiku fine for simple unit tests |
| Documentation | Sonnet 4.5 | Haiku 4.5 | Haiku fine for minor updates |
| Refactoring (large) | Opus 4.5 | Sonnet 4.5 | Use Opus for >5 files or architectural changes |
| Refactoring (small) | Sonnet 4.5 | Haiku 4.5 | Haiku fine for renames, moves |
| Git operations | Haiku 4.5 | - | Always sufficient |
| Status checks | Haiku 4.5 | - | Always sufficient |
| Planning (Phase 0) | Opus 4.5 | Sonnet 4.5 | Use Opus for comprehensive planning |
| Planning (task-level) | Sonnet 4.5 | Opus 4.5 | Upgrade for complex features |

---

## Task Analysis Signals

Claude analyzes these signals to recommend models:

### Complexity Indicators → Opus 4.5
- Multi-system interaction
- Security implications
- Performance optimization
- Architectural decisions
- "Think through", "analyze", "design"
- Error messages with unclear cause
- >5 files affected

### Standard Indicators → Sonnet 4.5
- Feature implementation
- API integration
- Test generation
- Code review request
- Documentation
- Standard debugging
- 2-5 files affected

### Simple Indicators → Haiku 4.5
- Single file edits
- Formatting/style fixes
- Git operations
- Status checks
- File navigation
- Rename/move operations
- Quick questions

---

## User Override

Users can always override recommendations:
- "Use Opus for this" - Force Opus 4.5
- "Quick mode" or "Use Haiku" - Force Haiku 4.5
- "Standard" - Use Sonnet 4.5

The system respects user preferences while still providing recommendations.
```

### Integration Points

Update `.claude/claude.md` to include model recommendation section and examples.

---

## Phase 2: Sub-Agent Integration

### Goal
Document and enable full use of Claude Code's Task tool with specialized sub-agents.

### New Files

#### `.claude/SUBAGENTS.md`

```markdown
# Claude Code Sub-Agents

## Overview

Claude Code provides specialized sub-agents via the Task tool. These are real, autonomous agents that execute tasks independently and return results.

## Built-in Sub-Agent Types

### Explore Agent
**Type**: `Explore`
**Invocation**: Automatic for codebase exploration

**Capabilities**:
- Fast file pattern matching (glob)
- Code search (grep)
- Architecture understanding
- Dependency analysis

**Use When**:
- "Where is X implemented?"
- "Find all files related to Y"
- "How does the auth system work?"
- "What's the codebase structure?"

**Model Pairing**: Usually runs with Haiku for speed, escalates to Sonnet if complex.

---

### Plan Agent
**Type**: `Plan`
**Invocation**: "Plan the implementation of [feature]"

**Capabilities**:
- Implementation strategy design
- Step-by-step breakdowns
- Architectural trade-off analysis
- File change identification

**Use When**:
- Starting a new feature
- Complex refactoring
- Architecture decisions
- Multi-step implementations

**Model Pairing**: Sonnet 4.5 default, Opus 4.5 for complex architecture.

**Output Format**:
1. Step-by-step implementation plan
2. Files to create/modify
3. Critical decisions identified
4. Potential risks/challenges

---

### Bash Agent
**Type**: `Bash`
**Invocation**: Automatic for command execution

**Capabilities**:
- Command execution
- Build processes
- Test running
- Git operations
- Package management

**Use When**:
- Running tests
- Building projects
- Git operations
- Installing dependencies
- Running scripts

**Model Pairing**: Haiku 4.5 sufficient for most operations.

---

### General-Purpose Agent
**Type**: `general-purpose`
**Invocation**: Complex multi-step tasks

**Capabilities**:
- Autonomous multi-step execution
- Research and code search
- Complex task completion
- Cross-file operations

**Use When**:
- Multi-step implementations
- Complex research tasks
- Tasks requiring multiple tool types
- Autonomous execution desired

**Model Pairing**: Sonnet 4.5 default, Opus 4.5 for complex tasks.

---

## Sub-Agent Patterns

### Pattern 1: Explore → Plan → Execute

Best for new features or unfamiliar codebases:

```
1. Explore Agent: "Find all authentication-related code"
   → Returns: File locations, patterns, dependencies

2. Plan Agent: "Plan adding OAuth2 support"
   → Returns: Implementation steps, files to modify

3. General-Purpose Agent: Execute the plan
   → Returns: Completed implementation
```

### Pattern 2: Parallel Exploration

Best for comprehensive codebase understanding:

```
Launch in parallel:
├── Explore Agent: "Find all API endpoints"
├── Explore Agent: "Find database models"
└── Explore Agent: "Find authentication code"

Combine results for full picture.
```

### Pattern 3: Background Build + Continue

Best for efficient time use:

```
1. Bash Agent (background): "npm run build"
2. Continue with documentation or planning
3. Check build results when complete
```

### Pattern 4: Iterative Debugging

Best for complex bugs:

```
1. Explore Agent: Find error location
2. Explore Agent: Find related code
3. Plan Agent: Diagnose root cause
4. General-Purpose Agent: Implement fix
5. Bash Agent: Run tests to verify
```

---

## Background Execution

Sub-agents can run in background for long tasks:

**Ideal for**:
- Test suites (>30 seconds)
- Build processes
- Large codebase searches
- Database migrations

**Usage**:
"Run the tests in background and continue with [next task]"

**Checking status**:
"What's the status of the background task?"

---

## Sub-Agent + Persona Synergy

Sub-agents handle execution; personas provide perspective:

| Sub-Agent | Best Paired Personas |
|-----------|---------------------|
| Explore | Debug Specialist, Security Reviewer |
| Plan | Product Strategist, Code Reviewer, UX Designer |
| Bash | Test Engineer, DevOps Engineer |
| General-Purpose | Full-Stack Developer |

**Example**: Security Audit
1. **Explore Agent** finds auth code
2. **Security Reviewer persona** analyzes vulnerabilities
3. **Plan Agent** creates remediation plan
4. **General-Purpose Agent** implements fixes
```

---

## Phase 3: Hooks System

### Goal
Implement hooks with clear auto-run vs. user-validated categorization.

### New Directory Structure

```
.claude/hooks/
├── auto/                    # Auto-run hooks (safe, non-destructive)
│   ├── session-start.sh     # Environment validation
│   └── context-check.sh     # Token monitoring
├── validated/               # User-validated hooks (potentially disruptive)
│   ├── pre-commit.sh        # Lint/format before commit
│   ├── test-runner.sh       # Run test suite
│   └── deploy-check.sh      # Pre-deployment validation
└── README.md                # Hook documentation
```

### Auto-Run Hooks

#### `session-start.sh`
```bash
#!/bin/bash
# Auto-runs on every session start
# Safe, non-destructive, informational only

echo "📋 Session Environment Check"
echo "─────────────────────────────"

# Git status (informational)
if [ -d ".git" ]; then
    branch=$(git branch --show-current 2>/dev/null)
    changes=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    echo "🔀 Branch: $branch"
    if [ "$changes" -gt "0" ]; then
        echo "📝 Uncommitted: $changes files"
    else
        echo "✅ Working tree: clean"
    fi
fi

# Node.js check (informational)
if [ -f "package.json" ]; then
    if [ -d "node_modules" ]; then
        echo "📦 Dependencies: installed"
    else
        echo "⚠️  Dependencies: not installed (run npm install)"
    fi
fi

# Python check (informational)
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    if [ -d ".venv" ] || [ -d "venv" ]; then
        echo "🐍 Virtual env: found"
    else
        echo "⚠️  Virtual env: not found"
    fi
fi

# Build status (informational)
if [ -f "docs/project/build-status.md" ]; then
    phase=$(grep -m1 "Current Phase" docs/project/build-status.md 2>/dev/null | head -1)
    if [ -n "$phase" ]; then
        echo "📊 $phase"
    fi
fi

echo "─────────────────────────────"
echo "✅ Ready. Model will be recommended based on your task."
```

### User-Validated Hooks

#### `pre-commit.sh`
```bash
#!/bin/bash
# Requires user confirmation before running
# Modifies files (linting/formatting)

echo "🔍 Pre-commit validation"
echo "This will run linting and may auto-fix issues."
echo ""

# Check what would be linted
if [ -f "package.json" ]; then
    echo "Will run: npm run lint (if available)"
fi

if [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
    echo "Will run: ruff check / black (if available)"
fi

echo ""
echo "Proceed? (This may modify files)"
```

### Hook Configuration

Update `settings.local.json`:
```json
{
  "hooks": {
    "SessionStart": [
      {
        "command": "bash .claude/hooks/auto/session-start.sh",
        "timeout": 10000,
        "silent": false
      }
    ]
  }
}
```

---

## Phase 4: Role Personas (Consolidated 8)

### Goal
Replace 17 personas with 8 focused roles that complement sub-agents.

### New File: `.claude/PERSONAS.md`

```markdown
# Role Personas

## Overview

Role personas provide specialized perspectives and domain expertise. They complement sub-agents:
- **Sub-agents** = Execution (do the work)
- **Personas** = Perspective (how to think about the work)

## The Core 8 Personas

### 1. Full-Stack Developer
**Focus**: Implementation, modern best practices, clean code

**Invoke**: "As a full-stack developer..." or natural development requests

**Expertise**:
- Frontend: React, Vue, Next.js, TypeScript
- Backend: Node.js, Python, Go
- Database: PostgreSQL, MongoDB, Redis
- API design and integration

**Best With**: General-purpose agent for implementation

---

### 2. Debug Specialist
**Focus**: Systematic troubleshooting, root cause analysis

**Invoke**: "Help me debug..." or "I'm getting this error..."

**Methodology**:
1. Reproduce the issue
2. Isolate variables
3. Form hypotheses
4. Test systematically
5. Verify fix doesn't introduce regressions

**Best With**: Explore agent to find related code

---

### 3. Code Reviewer
**Focus**: Quality, architecture, maintainability

**Invoke**: "Review this code..." or "Check my implementation..."

**Reviews For**:
- Code clarity and readability
- Design patterns and architecture
- Performance considerations
- Error handling
- Edge cases
- Test coverage

**Best With**: Plan agent for architectural review

---

### 4. Security Reviewer
**Focus**: Vulnerability analysis, secure coding

**Invoke**: "Security review..." or "Check for vulnerabilities..."

**Checks For**:
- OWASP Top 10 vulnerabilities
- Authentication/authorization flaws
- Input validation
- Secrets management
- SQL injection, XSS, CSRF
- Dependency vulnerabilities

**Best With**: Explore agent to find security-sensitive code

**Model Note**: Always recommend Opus 4.5 for security reviews

---

### 5. Test Engineer
**Focus**: TDD, test strategy, coverage

**Invoke**: "Write tests for..." or "Help me test..."

**Approach**:
- Unit tests for logic
- Integration tests for flows
- E2E tests for critical paths
- Edge case identification
- Mock strategy

**Best With**: Bash agent for running tests

---

### 6. DevOps Engineer
**Focus**: Infrastructure, deployment, CI/CD

**Invoke**: "Help me deploy..." or "Set up CI/CD..."

**Expertise**:
- Docker and containerization
- CI/CD pipelines (GitHub Actions, etc.)
- Cloud platforms (AWS, GCP, Vercel)
- Monitoring and logging
- Environment management

**Best With**: Bash agent for infrastructure commands

---

### 7. Product Strategist
**Focus**: Requirements, roadmaps, feature definition

**Invoke**: "Help me define..." or "Plan the requirements for..."

**Approach**:
- User story development
- Feature prioritization
- Scope management
- MVP definition
- Roadmap planning

**Best With**: Plan agent for implementation planning

---

### 8. UX Designer
**Focus**: User-centered design, interface patterns

**Invoke**: "Design the interface for..." or "UX review..."

**Expertise**:
- Information architecture
- Interaction design
- Accessibility (a11y)
- Design systems
- User flow optimization

**Best With**: Plan agent for design planning

---

## Persona + Sub-Agent Workflows

### Feature Development
```
1. Product Strategist: Define requirements
2. Plan Agent: Create implementation plan
3. UX Designer: Design interface approach
4. Full-Stack Developer: Implement
5. Test Engineer: Write tests
6. Code Reviewer: Final review
```

### Bug Investigation
```
1. Debug Specialist: Systematic analysis
2. Explore Agent: Find related code
3. Security Reviewer: Check if security-related
4. Full-Stack Developer: Implement fix
5. Test Engineer: Add regression test
```

### Security Audit
```
1. Explore Agent: Find security-sensitive code
2. Security Reviewer: Analyze vulnerabilities
3. Plan Agent: Create remediation plan
4. Full-Stack Developer: Implement fixes
5. Security Reviewer: Verify fixes
```

### Deployment
```
1. DevOps Engineer: Plan deployment
2. Test Engineer: Verify all tests pass
3. Code Reviewer: Pre-deploy review
4. Bash Agent: Execute deployment
5. DevOps Engineer: Verify deployment
```
```

---

## Phase 5: Simplified Integration System

### Goal
Reduce integration tiers from 4 to 2 for clarity.

### New Tiers

#### Essential Tier (Recommended for All)
**Includes**:
- Model strategy system (always-analyze)
- Auto-run hooks (session-start, context-check)
- Sub-agent documentation
- 8 core personas
- Status tracking system
- Phase-based workflow

**Setup Time**: 15-30 minutes

**Command**: `./integrate-project.sh` (default)

#### Extended Tier (Complex/Team Projects)
**Includes Everything in Essential, Plus**:
- Validated hooks (pre-commit, test-runner)
- Custom skills support
- CI/CD hook integration
- Advanced background task patterns
- Team workflow documentation

**Setup Time**: 1-2 hours

**Command**: `./integrate-project.sh --extended`

### Updated Integration Script

```bash
#!/bin/bash
# integrate-project.sh v3.0

TIER="${1:---essential}"

case "$TIER" in
  --essential|"")
    echo "Installing Essential tier..."
    # Copy: MODEL-STRATEGY.md, SUBAGENTS.md, PERSONAS.md
    # Copy: hooks/auto/
    # Copy: settings updates
    # Skip: hooks/validated/, custom skills
    ;;
  --extended)
    echo "Installing Extended tier..."
    # Copy everything
    ;;
  *)
    echo "Usage: ./integrate-project.sh [--essential|--extended]"
    exit 1
    ;;
esac
```

---

## Phase 6: Documentation & Migration

### Updated File Structure

```
project-template/
├── .claude/
│   ├── claude.md                    # Updated with model recommendations
│   ├── settings.local.json          # Updated with hooks
│   ├── MODEL-STRATEGY.md            # NEW: Model recommendation system
│   ├── SUBAGENTS.md                 # NEW: Sub-agent documentation
│   ├── PERSONAS.md                  # NEW: 8 consolidated personas
│   ├── hooks/
│   │   ├── auto/
│   │   │   ├── session-start.sh     # Auto-run: environment check
│   │   │   └── context-check.sh     # Auto-run: token monitoring
│   │   ├── validated/
│   │   │   ├── pre-commit.sh        # Validated: lint/format
│   │   │   └── test-runner.sh       # Validated: run tests
│   │   └── README.md                # Hook documentation
│   ├── presets/                     # Keep existing presets
│   └── commands/                    # Keep for compatibility
│
├── docs/
│   ├── QUICKSTART.md                # NEW: 5-minute getting started
│   ├── MIGRATION-V2-V3.md           # NEW: Upgrade guide
│   └── project/                     # Unchanged
│
└── workspace-template/
    └── .workspace/
        ├── CLAUDE.md                # Updated references
        ├── PERSONAS.md              # NEW: Workspace-level personas
        ├── SUBAGENT-WORKFLOWS.md    # NEW: Multi-project patterns
        └── AGENT-QUICK-REF.md       # DEPRECATED: Redirect to PERSONAS.md
```

### Migration Guide Summary

**For v2.0 Users**:
1. Run `./migrate-v2-to-v3.sh`
2. Review new MODEL-STRATEGY.md
3. Verify hooks work correctly
4. Update any custom agent references to use personas

**Breaking Changes**:
- "Agents" renamed to "Personas" (clarifies they're perspectives, not sub-agents)
- 17 personas → 8 core personas
- Commands location unchanged but skills recommended for new commands

---

## Implementation Checklist

### Phase 1: Model Strategy
- [ ] Create MODEL-STRATEGY.md
- [ ] Update claude.md with model recommendation section
- [ ] Add recommendation format examples
- [ ] Test recommendation logic

### Phase 2: Sub-Agents
- [ ] Create SUBAGENTS.md
- [ ] Document all sub-agent types
- [ ] Add workflow patterns
- [ ] Test sub-agent invocations

### Phase 3: Hooks
- [ ] Create hooks directory structure
- [ ] Implement session-start.sh (auto)
- [ ] Implement context-check.sh (auto)
- [ ] Implement pre-commit.sh (validated)
- [ ] Update settings.local.json
- [ ] Test hook execution

### Phase 4: Personas
- [ ] Create PERSONAS.md with 8 roles
- [ ] Document persona + sub-agent synergy
- [ ] Remove deprecated AGENT-QUICK-REF.md references
- [ ] Update workspace CLAUDE.md

### Phase 5: Integration
- [ ] Update integrate-project.sh for 2 tiers
- [ ] Create Essential tier package
- [ ] Create Extended tier package
- [ ] Test both integration paths

### Phase 6: Documentation
- [ ] Create QUICKSTART.md
- [ ] Create MIGRATION-V2-V3.md
- [ ] Update main README.md
- [ ] Final testing and polish

---

*Document Version: 1.1*
*Status: APPROVED - Ready for Implementation*
*Updated: January 2026*
