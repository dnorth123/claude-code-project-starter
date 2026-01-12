# Claude Code Sub-Agents

> **Version**: 3.0
> **Type**: Core Capability Documentation

## Overview

Claude Code provides specialized **sub-agents** via the Task tool. These are real, autonomous agents that:

- Execute tasks independently
- Have access to specific tools
- Return results to the main conversation
- Can run in the background

**Key Distinction**:
- **Sub-agents** = Real autonomous execution (Task tool)
- **Personas** = Perspective/expertise framing (see PERSONAS.md)

---

## Built-in Sub-Agent Types

### Explore Agent

**Type**: `Explore`

**Purpose**: Fast codebase exploration and understanding

**Capabilities**:
- File pattern matching (glob patterns)
- Code search (grep/regex)
- Architecture understanding
- Dependency analysis
- Quick file discovery

**Automatic Invocation**: Claude uses Explore agent for questions like:
- "Where is X implemented?"
- "Find all files related to Y"
- "How does the auth system work?"
- "What's the codebase structure?"

**Thoroughness Levels**:
- `quick` - Basic searches, first matches
- `medium` - Moderate exploration
- `very thorough` - Comprehensive analysis across multiple locations

**Model Pairing**:
- Default: Haiku 4.5 (speed optimized)
- Escalates to Sonnet if complex patterns detected

**Example Usage**:
```
"Explore the authentication system - find all related files and understand the flow"
"Quick search for all API endpoints"
"Thoroughly analyze how error handling works across the codebase"
```

---

### Plan Agent

**Type**: `Plan`

**Purpose**: Implementation strategy and architecture planning

**Capabilities**:
- Implementation strategy design
- Step-by-step breakdowns
- Architectural trade-off analysis
- File change identification
- Risk assessment
- Critical decision identification

**Invocation Triggers**:
- "Plan the implementation of [feature]"
- "Design the architecture for [system]"
- "How should I approach [complex task]?"

**Output Format**:
1. Step-by-step implementation plan
2. Files to create/modify
3. Critical decisions identified
4. Potential risks/challenges
5. Recommended model for execution

**Model Pairing**:
- Default: Sonnet 4.5
- Complex architecture: Opus 4.5 (recommended for Phase 0)

**Example Usage**:
```
"Plan the implementation of user authentication with OAuth2"
"Design the database schema for a multi-tenant system"
"Plan how to refactor the payment processing module"
```

---

### Bash Agent

**Type**: `Bash`

**Purpose**: Command execution and terminal operations

**Capabilities**:
- Shell command execution
- Build processes
- Test running
- Git operations
- Package management
- Script execution

**Automatic Invocation**: Claude uses Bash agent for:
- Running tests
- Building projects
- Git operations
- Installing dependencies
- Executing scripts

**Background Execution**: Can run long tasks in background:
- Test suites (>30 seconds)
- Build processes
- Database operations

**Model Pairing**: Haiku 4.5 (almost always sufficient)

**Example Usage**:
```
"Run the test suite"
"Build the project for production"
"Run npm install and then start the dev server"
"Run tests in background while I continue working"
```

---

### General-Purpose Agent

**Type**: `general-purpose`

**Purpose**: Complex multi-step autonomous tasks

**Capabilities**:
- Autonomous multi-step execution
- Research and code search
- Complex task completion
- Cross-file operations
- Full tool access

**Invocation Triggers**:
- Complex implementations requiring autonomy
- Multi-step research tasks
- Tasks requiring multiple tool types
- "Do this autonomously"

**Model Pairing**:
- Default: Sonnet 4.5
- Complex tasks: Opus 4.5

**Example Usage**:
```
"Implement the user registration feature based on the plan"
"Research how similar projects handle rate limiting and summarize"
"Autonomously fix all the TypeScript errors in the project"
```

---

## Sub-Agent Patterns

### Pattern 1: Explore → Plan → Execute

**Best for**: New features, unfamiliar codebases

```
Step 1: Explore Agent
   "Find all authentication-related code"
   → Returns: File locations, patterns, dependencies

Step 2: Plan Agent
   "Plan adding OAuth2 support based on what we found"
   → Returns: Implementation steps, files to modify, decisions

Step 3: General-Purpose Agent
   "Execute the OAuth2 implementation plan"
   → Returns: Completed implementation
```

**When to Use**:
- Starting work in unfamiliar codebase
- Adding features to existing systems
- Understanding before modifying

---

### Pattern 2: Parallel Exploration

**Best for**: Comprehensive codebase understanding

```
Launch in parallel:
├── Explore Agent: "Find all API endpoints"
├── Explore Agent: "Find database models"
└── Explore Agent: "Find authentication code"

Combine results for complete picture.
```

**When to Use**:
- Initial project onboarding
- Architecture documentation
- Pre-refactoring analysis

---

### Pattern 3: Background Build + Continue

**Best for**: Efficient time usage

```
Step 1: Bash Agent (background)
   "npm run build"

Step 2: Continue working
   - Update documentation
   - Plan next feature
   - Review code

Step 3: Check results
   "What's the status of the build?"
```

**When to Use**:
- Long-running build processes
- Test suites
- CI-like workflows

---

### Pattern 4: Iterative Debugging

**Best for**: Complex bugs

```
Step 1: Explore Agent
   "Find where this error originates"

Step 2: Explore Agent
   "Find all code paths that call this function"

Step 3: Plan Agent
   "Analyze the bug and create a fix plan"

Step 4: General-Purpose Agent
   "Implement the fix"

Step 5: Bash Agent
   "Run the tests to verify the fix"
```

**When to Use**:
- Bugs with unclear root cause
- Multi-file issues
- Race conditions
- Memory leaks

---

### Pattern 5: Security Audit Flow

**Best for**: Security-focused analysis

```
Step 1: Explore Agent
   "Find all authentication and authorization code"

Step 2: Explore Agent
   "Find all input handling and validation"

Step 3: (Apply Security Reviewer persona)
   Analyze findings for vulnerabilities

Step 4: Plan Agent
   "Create remediation plan for identified issues"

Step 5: General-Purpose Agent
   "Implement security fixes"
```

**Model Note**: Use Opus 4.5 for security analysis steps.

---

## Background Execution

Sub-agents can run in the background for long-running tasks.

### When to Use Background

| Task Type | Duration Threshold |
|-----------|-------------------|
| Test suites | >30 seconds |
| Build processes | >1 minute |
| Large searches | >20 seconds |
| Database migrations | Any duration |
| Deployment scripts | Any duration |

### How to Launch Background Tasks

```
"Run the tests in background and continue with [next task]"
"Build in background while I work on documentation"
"Start the database migration in background"
```

### Checking Background Status

```
"What's the status of the background task?"
"Is the build finished?"
"Show me the test results"
```

### Best Practices

- Don't launch too many background tasks (2-3 max)
- Check results before depending on them
- Use for truly long operations, not quick tasks

---

## Sub-Agent + Persona Synergy

Sub-agents handle **execution**. Personas provide **perspective**.

| Sub-Agent | Best Paired Personas |
|-----------|---------------------|
| **Explore** | Debug Specialist, Security Reviewer |
| **Plan** | Product Strategist, Code Reviewer, UX Designer |
| **Bash** | Test Engineer, DevOps Engineer |
| **General-Purpose** | Full-Stack Developer |

### Synergy Example: Feature Development

```
1. Product Strategist (persona) + Plan Agent
   → Define requirements and create implementation plan

2. UX Designer (persona) + Plan Agent
   → Design interface approach

3. Full-Stack Developer (persona) + General-Purpose Agent
   → Implement the feature

4. Test Engineer (persona) + Bash Agent
   → Write and run tests

5. Code Reviewer (persona) + Explore Agent
   → Review implementation quality
```

### Synergy Example: Security Audit

```
1. Explore Agent
   → Find security-sensitive code

2. Security Reviewer (persona)
   → Analyze with security focus (use Opus 4.5)

3. Plan Agent
   → Create remediation plan

4. General-Purpose Agent
   → Implement fixes

5. Security Reviewer (persona)
   → Verify fixes
```

---

## Model Recommendations by Sub-Agent

| Sub-Agent | Default | When to Upgrade | Upgrade To |
|-----------|---------|-----------------|------------|
| Explore | Haiku | Complex architecture | Sonnet |
| Plan | Sonnet | Security, architecture | Opus |
| Bash | Haiku | Rarely needed | - |
| General-Purpose | Sonnet | Complex multi-step | Opus |

---

## Quick Reference

### Invoke Specific Sub-Agent

| Goal | Invocation |
|------|------------|
| Search codebase | "Find...", "Where is...", "Search for..." |
| Plan implementation | "Plan...", "Design...", "How should I..." |
| Run commands | "Run...", "Execute...", "Build..." |
| Autonomous work | "Implement...", "Fix all...", "Do this autonomously" |

### Background Tasks

```
"[task] in background"
"[task] while I continue with [other work]"
"Start [task] and continue"
```

### Check Status

```
"Status of background task"
"Is [task] done?"
"Show results of [task]"
```

---

## Advanced: Ralph Autonomous Loop

For unattended, multi-hour development sessions, see the **Ralph pattern** in `.claude/RALPH.md`.

**What is Ralph?**
An autonomous loop that runs Claude Code repeatedly until all tasks complete. Unlike sub-agents (single tasks), Ralph handles entire features overnight.

**When to Use Ralph vs. Sub-Agents**

| Scenario | Use |
|----------|-----|
| Single exploration task | Explore Agent |
| Plan one feature | Plan Agent |
| Run tests | Bash Agent |
| Multi-step implementation (attended) | General-Purpose Agent |
| **Entire feature overnight (unattended)** | **Ralph** |
| **Batch migrations** | **Ralph** |

**Quick Start**
```bash
# Initialize Ralph for a feature
/ralph-init

# Run autonomously (up to 25 iterations)
./.claude/ralph/ralph.sh 25
```

See `.claude/RALPH.md` for complete documentation, best practices, and pitfalls.

---

*Last Updated: January 2026*
*Template Version: 3.0*
