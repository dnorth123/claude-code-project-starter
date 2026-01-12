# Thinking vs. Writing Mode Protocol

> **Version**: 3.1
> **Type**: Workflow Strategy Guide

## The Core Problem

> "By default, AI models jump to creating the final artifact. You must explicitly instruct Claude to stay in thinking mode—to ask sharp questions and explore complex problems before drafting anything."

When you ask Claude to help with something complex, the natural instinct is to immediately produce output—code, documents, solutions. But **premature solutioning** often leads to:

- Building the wrong thing
- Missing edge cases
- Suboptimal architecture decisions
- Rework and frustration

## The Solution: Explicit Mode Control

Separate your workflow into distinct phases:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  THINKING MODE  │ ──▶ │  DECISION POINT │ ──▶ │  WRITING MODE   │
│                 │     │                 │     │                 │
│  • Questions    │     │  • Clear scope  │     │  • Code         │
│  • Exploration  │     │  • Chosen path  │     │  • Documents    │
│  • Options      │     │  • Constraints  │     │  • Artifacts    │
│  • Trade-offs   │     │  • Criteria     │     │  • Tests        │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

---

## When to Use Thinking Mode

### Use Thinking Mode When:

| Situation | Why |
|-----------|-----|
| Problem is ambiguous | Need to clarify what you're actually solving |
| Multiple valid approaches | Need to evaluate trade-offs |
| High cost of being wrong | Architecture, security, data models |
| You're unsure what you need | Need exploration before commitment |
| Starting new feature/project | Need to map the problem space |
| Complex debugging | Need to form hypotheses |

### Skip to Writing Mode When:

| Situation | Why |
|-----------|-----|
| Requirements crystal clear | No ambiguity to resolve |
| Well-defined task | "Add X to Y" type requests |
| Following established pattern | Replicating existing approach |
| Quick fix or enhancement | Scope is trivially small |
| Bug with obvious cause | Solution is clear |

---

## Thinking Mode Protocol

### Phase 1: Problem Understanding

**Goal**: Ensure you're solving the right problem.

**Actions**:
1. Restate the problem in your own words
2. Identify stakeholders and their needs
3. List assumptions you're making
4. Ask clarifying questions

**Prompts to Use**:
```
"Before we build, let me make sure I understand..."
"Think through this problem with me—don't write code yet"
"Help me understand all the requirements before we implement"
"What questions should we answer first?"
```

**Questions Claude Should Ask**:
- What problem are we actually solving?
- Who is affected and how?
- What does success look like?
- What constraints exist?
- What has been tried before?

### Phase 2: Option Exploration

**Goal**: Identify multiple valid approaches.

**Actions**:
1. Generate at least 3 different approaches
2. Analyze trade-offs for each
3. Identify risks and unknowns
4. Consider short-term vs. long-term

**Prompts to Use**:
```
"What are all the ways we could approach this?"
"Give me 3+ options with trade-offs"
"What are the architectural choices here?"
"Explore the design space before recommending"
```

**Option Format**:
```markdown
## Option A: [Name]
**Approach**: [How it works]
**Pros**: [Benefits]
**Cons**: [Drawbacks]
**Risk**: [What could go wrong]
**Best when**: [Ideal conditions]
**Effort**: [Rough complexity]
```

### Phase 3: Decision Point

**Goal**: Make an informed choice.

**Actions**:
1. Summarize the options
2. State your recommendation
3. Acknowledge trade-offs being accepted
4. Define success criteria

**Prompts to Use**:
```
"Based on our exploration, which approach do you recommend?"
"Given [constraints], what should we build?"
"Make a recommendation with reasoning"
```

### Phase 4: Transition to Writing

**Goal**: Clear handoff from thinking to producing.

**Prompts to Use**:
```
"I've decided on Option B. Let's implement it."
"Switch to implementation mode"
"The thinking is done—build it"
"Requirements are clear. Write the code."
```

---

## Anti-Patterns to Avoid

### ❌ Premature Solutioning
```
User: "We need notifications"
Claude: "Here's a complete notification system..." [immediately writes code]
```

**Problem**: May build the wrong notification system.

### ✅ Proper Exploration
```
User: "We need notifications"
Claude: "Before we build, let me understand what you need.
        What types of notifications? Which channels?
        How much user control over preferences?"
```

### ❌ False Binary
```
"Should we use Redis or Postgres for this?"
```

**Problem**: Assumes only two options.

### ✅ Open Exploration
```
"What are all the ways we could handle this state?
 Let's consider Redis, Postgres, in-memory, file-based,
 and any other approaches before deciding."
```

### ❌ Skipping to Recommendation
```
User: "How should we handle auth?"
Claude: "Use NextAuth. Here's the setup..." [no alternatives]
```

**Problem**: No exploration of trade-offs.

### ✅ Options Then Recommendation
```
User: "How should we handle auth?"
Claude: "Let me explore the options:
        1. NextAuth (Auth.js) - Provider-based, managed
        2. Clerk - Fully managed with UI
        3. Custom JWT - Full control
        4. Supabase Auth - If using Supabase

        Given your needs, I recommend X because..."
```

---

## Integration with Sub-Agents

Sub-agents can help with thinking mode:

### Explore Agent for Research
```
"Use Explore agent to find how auth is currently handled
 before we plan changes"
```

### Plan Agent for Architecture
```
"Use Plan agent to design the implementation approach
 after we've decided on Option B"
```

### Parallel Research for Options
```
"Research all three framework options simultaneously,
 then we'll compare and decide"
```

---

## Integration with Output Styles

| Mode | Output Style | Purpose |
|------|--------------|---------|
| Thinking | `thinking-mode` | Deep exploration, questions |
| Thinking | `research-mode` | External research, learning |
| Writing | `implementation-mode` | Code production |
| Writing | `documentation-mode` | Technical writing |
| Hybrid | `review-mode` | Critical analysis |

### Using Output Styles

```
# Start in thinking mode
"Switch to thinking-mode output style. Help me explore
 the architecture options for our API."

[... exploration happens ...]

# Transition to writing
"Good, I've decided on REST with versioned endpoints.
 Switch to implementation-mode and let's build it."
```

---

## Practical Examples

### Example 1: New Feature

**Bad Flow**:
```
User: "Add user profiles to the app"
Claude: [Immediately writes profile component, API, database schema]
Result: Built wrong thing, needs major rework
```

**Good Flow**:
```
User: "Add user profiles to the app"
Claude (thinking): "What should profiles include?
                   - Basic info (name, email)?
                   - Avatar/photo?
                   - Bio/description?
                   - Social links?
                   - Activity history?
                   - Privacy settings?

                   Who can view profiles?
                   Can users edit their own?
                   Do we need admin management?"

User: "Just basic info and avatar for now. Public profiles."

Claude (writing): [Builds focused MVP profile feature]
Result: Exactly what was needed
```

### Example 2: Bug Investigation

**Bad Flow**:
```
User: "Users are getting logged out randomly"
Claude: [Immediately suggests token expiry fix]
Result: Wrong diagnosis, bug persists
```

**Good Flow**:
```
User: "Users are getting logged out randomly"
Claude (thinking): "Let me understand the pattern:
                   - How often does it happen?
                   - Any correlation with time/action?
                   - All users or specific ones?
                   - Any recent changes?
                   - What does 'logged out' mean exactly?

                   Possible causes:
                   1. Token expiry
                   2. Cookie issues
                   3. Session storage problems
                   4. Multiple tabs conflicts
                   5. Server restarts

                   Let me investigate each..."

[After investigation]

Claude (writing): "Found it—Redis session store failing silently.
                  Here's the fix..."
```

---

## Quick Reference

### Trigger Thinking Mode
- "Think through this with me"
- "Don't write code yet, just explore"
- "What questions should we answer first?"
- "Give me options before recommending"
- "Use thinking-mode output style"

### Trigger Writing Mode
- "I've decided, let's build it"
- "Requirements are clear, implement it"
- "Switch to implementation mode"
- "Write the code for Option B"

### Check Current Mode
- "Are you in thinking or writing mode?"
- "Should we explore more or start building?"

---

## Summary

| Phase | Focus | Output |
|-------|-------|--------|
| **Thinking** | Understanding, exploring | Questions, options, analysis |
| **Decision** | Choosing | Clear path forward |
| **Writing** | Producing | Code, docs, artifacts |

**Key Principle**: The time spent thinking saves multiples in implementation time. A 10-minute exploration can prevent hours of rework.

---

*Last Updated: January 2026*
*Template Version: 3.1*
