# Model Strategy System

> **Version**: 3.0
> **Approach**: Always-Analyze with Recommendations

## Overview

Claude Code analyzes every task and provides intelligent model recommendations. Each recommendation includes:

- **Primary model** with rationale
- **Pros** of using that model
- **Cons** / trade-offs to consider
- **Alternative** if you prefer different trade-offs

---

## Model Profiles

### Opus 4.5 (claude-opus-4-5-20251101)

**The Deep Thinker** - Maximum reasoning capability

| Attribute | Rating |
|-----------|--------|
| Reasoning Depth | Excellent |
| Speed | Slower |
| Cost | Higher |
| Best For | Complex decisions |

**Strengths**:
- Deepest reasoning and extended thinking capability
- Best for architecture and complex system design
- Superior at multi-file refactoring (>5 files)
- Excels at security analysis and edge case detection
- Most thorough code review
- Handles ambiguous requirements well

**Best For**:
- System architecture design
- Complex debugging (race conditions, memory leaks, deadlocks)
- Security audits and threat modeling
- Large-scale refactoring
- Critical algorithm implementation
- Phase 0 planning and design decisions
- Performance optimization analysis

**Trade-offs**:
- Higher latency (takes longer to respond)
- Higher token cost
- May be overkill for straightforward tasks

---

### Sonnet 4.5

**The Balanced Performer** - Optimal speed/capability ratio

| Attribute | Rating |
|-----------|--------|
| Reasoning Depth | Very Good |
| Speed | Fast |
| Cost | Moderate |
| Best For | Daily development |

**Strengths**:
- Excellent balance of speed and capability
- Strong at feature implementation
- Good pattern recognition and consistency
- Efficient multi-file editing (2-5 files)
- Reliable test generation
- Handles most development tasks well

**Best For**:
- Day-to-day feature development
- Standard debugging
- Code reviews (non-architectural)
- API integration
- Documentation updates
- Test writing
- Refactoring (small to medium)

**Trade-offs**:
- May miss subtle architectural issues
- Complex edge cases might benefit from Opus
- Extended thinking less powerful than Opus

---

### Haiku 4.5

**The Speed Demon** - Maximum efficiency for routine tasks

| Attribute | Rating |
|-----------|--------|
| Reasoning Depth | Good |
| Speed | Very Fast |
| Cost | Low |
| Best For | Quick operations |

**Strengths**:
- Fastest response time
- Most cost-efficient
- Excellent for routine operations
- Low latency for interactive work
- Perfect for simple, well-defined tasks

**Best For**:
- File navigation and search
- Simple edits (typos, formatting, style)
- Git operations (commits, status, branches)
- Quick lookups and status checks
- Simple refactors (rename, move)
- Running commands

**Trade-offs**:
- Limited complex reasoning
- May miss nuances in code review
- Not suitable for architectural decisions
- Struggles with ambiguous requirements

---

## Recommendation Matrix

| Task Type | Primary | Alternative | When to Upgrade |
|-----------|---------|-------------|-----------------|
| **Architecture design** | Opus 4.5 | Sonnet 4.5 | Use Opus for initial design |
| **Feature implementation** | Sonnet 4.5 | Opus 4.5 | Upgrade if hitting complexity walls |
| **Bug fix (simple)** | Haiku 4.5 | Sonnet 4.5 | Upgrade if cause unclear |
| **Bug fix (complex)** | Opus 4.5 | Sonnet 4.5 | Race conditions, memory issues |
| **Code review** | Sonnet 4.5 | Opus 4.5 | Upgrade for security-critical review |
| **Security audit** | Opus 4.5 | - | Always use Opus |
| **Test writing** | Sonnet 4.5 | Haiku 4.5 | Haiku fine for simple unit tests |
| **Documentation** | Sonnet 4.5 | Haiku 4.5 | Haiku fine for minor updates |
| **Refactoring (large)** | Opus 4.5 | Sonnet 4.5 | >5 files or architectural changes |
| **Refactoring (small)** | Sonnet 4.5 | Haiku 4.5 | Haiku fine for renames, moves |
| **Git operations** | Haiku 4.5 | - | Always sufficient |
| **Status checks** | Haiku 4.5 | - | Always sufficient |
| **Planning (Phase 0)** | Opus 4.5 | Sonnet 4.5 | Use Opus for comprehensive planning |
| **Planning (task-level)** | Sonnet 4.5 | Opus 4.5 | Upgrade for complex features |

---

## Task Analysis Signals

Claude analyzes these signals to determine recommendations:

### Complexity Indicators → Opus 4.5

**Keywords/Phrases**:
- "design", "architect", "system"
- "think through", "analyze carefully"
- "security", "vulnerability", "audit"
- "performance", "optimize", "scale"
- "refactor the entire", "restructure"

**Context Signals**:
- Multi-system interaction required
- Security implications present
- Performance optimization needed
- Architectural decisions required
- Error messages with unclear cause
- More than 5 files affected
- New unfamiliar codebase

---

### Standard Indicators → Sonnet 4.5

**Keywords/Phrases**:
- "implement", "build", "create", "add"
- "fix", "debug", "troubleshoot"
- "review", "check", "test"
- "document", "update", "integrate"

**Context Signals**:
- Feature implementation
- API integration
- Test generation
- Code review request
- Documentation work
- Standard debugging
- 2-5 files affected
- Familiar patterns

---

### Simple Indicators → Haiku 4.5

**Keywords/Phrases**:
- "rename", "move", "format"
- "quick", "simple", "just"
- "commit", "push", "status"
- "find", "search", "where is"

**Context Signals**:
- Single file edits
- Formatting/style fixes
- Git operations
- Status checks
- File navigation
- Rename/move operations
- Quick questions
- Well-defined scope

---

## Recommendation Format

When Claude analyzes a task, recommendations appear as:

```
Model Recommendation: [Model Name]

Task: [Brief description of detected task]

Pros:
- [Advantage 1]
- [Advantage 2]
- [Advantage 3]

Cons:
- [Trade-off 1]
- [Trade-off 2]

Alternative: [Alternative model] if [condition]
```

### Example: Feature Implementation

```
Model Recommendation: Sonnet 4.5

Task: Implement user authentication with OAuth2

Pros:
- Optimal balance of speed and capability for feature work
- Handles multi-file changes efficiently
- Good at following existing patterns in codebase

Cons:
- May need Opus 4.5 if security architecture decisions required
- Complex token refresh edge cases might benefit from deeper analysis

Alternative: Use Opus 4.5 if this involves security-critical design decisions
```

### Example: Simple Fix

```
Model Recommendation: Haiku 4.5

Task: Fix typo in error message

Pros:
- Fastest response time for simple edits
- Most cost-efficient for well-defined tasks
- No reasoning overhead needed

Cons:
- None for this task type

Alternative: None needed - Haiku is ideal for this task
```

### Example: Architecture Decision

```
Model Recommendation: Opus 4.5

Task: Design database schema for multi-tenant SaaS application

Pros:
- Deep reasoning for complex trade-off analysis
- Best at considering edge cases and future scaling
- Superior at multi-system interaction design

Cons:
- Higher latency (expect longer response)
- Higher cost per request

Alternative: Use Sonnet 4.5 for refinement after initial design is complete
```

---

## User Overrides

You can always override recommendations:

| Command | Effect |
|---------|--------|
| "Use Opus for this" | Force Opus 4.5 |
| "Quick mode" | Force Haiku 4.5 |
| "Use Haiku" | Force Haiku 4.5 |
| "Standard" | Use Sonnet 4.5 |
| "Deep analysis" | Force Opus 4.5 |

The system respects your preferences while still providing recommendations for future tasks.

---

## Model Selection in Planning Mode

When using the Plan agent or during Phase 0 planning, model recommendations also apply:

### Planning Task Complexity

| Planning Scope | Recommended Model |
|----------------|-------------------|
| Full project architecture | Opus 4.5 |
| Feature design (complex) | Opus 4.5 |
| Feature design (standard) | Sonnet 4.5 |
| Task breakdown | Sonnet 4.5 |
| Simple planning | Haiku 4.5 |

### Planning Output Quality

**Opus 4.5 Planning**:
- Comprehensive trade-off analysis
- Multiple implementation approaches considered
- Risk identification and mitigation
- Long-term maintainability considerations

**Sonnet 4.5 Planning**:
- Clear step-by-step plans
- Key decision points identified
- Standard best practices applied
- Efficient planning for known patterns

**Haiku 4.5 Planning**:
- Quick task lists
- Straightforward breakdowns
- Simple checklists
- Fast iteration

---

## Sub-Agent Model Pairing

Different sub-agents benefit from different models:

| Sub-Agent | Default Model | Upgrade Trigger |
|-----------|---------------|-----------------|
| **Explore** | Haiku 4.5 | Complex architecture understanding |
| **Plan** | Sonnet 4.5 | Architectural decisions, security |
| **Bash** | Haiku 4.5 | Rarely needs upgrade |
| **General-Purpose** | Sonnet 4.5 | Complex multi-step tasks |

---

## Best Practices

### Do

- Let the system analyze and recommend first
- Override when you have specific knowledge about complexity
- Use Opus for security-related work
- Use Haiku for routine operations to save time

### Don't

- Force Opus for simple tasks (wastes time/cost)
- Use Haiku for complex debugging (will struggle)
- Ignore recommendations without reason
- Switch models mid-task unnecessarily

---

*Last Updated: January 2026*
*Template Version: 3.0*
