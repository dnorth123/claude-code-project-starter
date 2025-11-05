# Agent Quick Reference

Quick guide to Claude Code's built-in agents and when to use them.

---

## By Task Type

### 🎯 Planning & Strategy

**Product Strategist**
- Use for: PRDs, requirements, feature specs, roadmap planning
- Best when: Starting new features, defining scope, market analysis
- Invoke: "I need help defining requirements for [feature]"

**Discovery Researcher**
- Use for: Market validation, customer insights, competitive analysis
- Best when: Validating ideas, understanding users, research phase
- Invoke: "Help me validate the market for [idea]"

**UX Researcher**
- Use for: User interviews, usability testing, behavioral analysis
- Best when: Need user insights, testing assumptions, understanding pain points
- Invoke: "I need to understand how users [behavior]"

---

### 💻 Development

**Full-Stack Developer**
- Use for: Next.js, React, Vue, Node.js, Supabase development
- Best when: Building features, implementing UI, API development
- Invoke: "I need to build [feature] with [tech stack]"
- **Most used agent** - Your primary development partner

**Debug Specialist**
- Use for: Troubleshooting, root cause analysis, complex bugs
- Best when: Stuck on errors, mysterious behavior, system issues
- Invoke: "I'm getting this error: [error]" or "Help me debug [issue]"

**Test Generator**
- Use for: TDD, test suites, 80% coverage requirement
- Best when: Need tests written, enforcing quality, preventing regressions
- Invoke: "Generate tests for [component/function]"

---

### 🔍 Quality & Security

**Code Reviewer**
- Use for: Architecture review, refactoring, best practices, optimization
- Best when: Before merging, phase completion, major refactor
- Invoke: "Review my [component/module] code"

**Security Reviewer**
- Use for: Vulnerability assessment, secure coding, compliance (GDPR, SOC2)
- Best when: Handling auth, payments, sensitive data, pre-launch
- Invoke: "Security review of [feature/system]"

**DevOps Engineer**
- Use for: Deployment, CI/CD, monitoring, infrastructure
- Best when: Setting up deployment, optimization, scaling issues
- Invoke: "Help me deploy to [platform]" or "Set up CI/CD"

---

### 🎨 Design & Content

**UX Designer**
- Use for: Interface design, interaction patterns, design systems, prototyping
- Best when: Designing UI, creating components, establishing patterns
- Invoke: "Design the [feature] interface"

**Content Strategist**
- Use for: Messaging, brand voice, copywriting, marketing content
- Best when: Writing landing pages, emails, app copy, marketing
- Invoke: "Write copy for [feature/page]"

**Tech Writer**
- Use for: Technical documentation, API docs, user guides
- Best when: Documenting features, writing guides, API documentation
- Invoke: "Document [feature/API]"

---

### ⚡ Productivity & Workflows

**Productivity Optimizer**
- Use for: ADHD-friendly workflows, productivity systems for entrepreneurs
- Best when: Optimizing workflow, managing focus, building better systems
- Invoke: "Help me optimize my [workflow/process]"

**Launch Orchestrator**
- Use for: 7-day launch sprints, go-to-market execution
- Best when: Ready to launch, need coordinated push, deadline approaching
- Invoke: "Plan a 7-day launch for [product]"

**AI Architect**
- Use for: Multi-agent workflows, Claude-powered automation
- Best when: Building AI features, workflow automation, agent design
- Invoke: "Design an agent workflow for [task]"

---

### 🔧 Specialized

**Prompt Engineer**
- Use for: Claude optimization, AI-powered product features
- Best when: Building AI features, optimizing prompts, agent design
- Invoke: "Optimize this prompt: [prompt]"

**Data Analyst**
- Use for: Metrics, insights, data-driven decisions
- Best when: Need analytics, understanding data, making decisions
- Invoke: "Analyze [data/metrics]"

---

## Common Workflows

### 🚀 MVP Development
```
1. Product Strategist → Define requirements
2. Full-Stack Developer → Build features
3. Test Generator → Create test suite
4. Code Reviewer → Review quality
5. Launch Orchestrator → Plan launch
```

### ✨ Feature Addition
```
1. Product Strategist → Write feature spec
2. UX Designer → Design interface
3. Full-Stack Developer → Implement
4. Test Generator → Add tests
5. Code Reviewer → Final review
```

### 🐛 Bug Investigation
```
1. Debug Specialist → Identify root cause
2. Security Reviewer → Check if security-related
3. Full-Stack Developer → Implement fix
4. Test Generator → Add regression test
```

### 🎨 UI/UX Work
```
1. UX Researcher → User insights
2. UX Designer → Design solution
3. Full-Stack Developer → Implement
4. UX Researcher → Validate with users
```

### 🚢 Pre-Launch
```
1. Code Reviewer → Architecture review
2. Security Reviewer → Security audit
3. DevOps Engineer → Deployment setup
4. Test Generator → Full coverage check
5. Content Strategist → Launch messaging
6. Launch Orchestrator → 7-day launch plan
```

### 📱 Mobile Expansion
```
1. Product Strategist → Mobile strategy
2. Discovery Researcher → Validate demand
3. UX Designer → Mobile-first design
4. Full-Stack Developer → API optimization
5. Full-Stack Developer → Mobile implementation
```

---

## Quick Decision Tree

**Building a feature?** → Full-Stack Developer

**Stuck on a bug?** → Debug Specialist

**Need tests?** → Test Generator

**Planning something?** → Product Strategist

**Designing UI?** → UX Designer

**Writing copy?** → Content Strategist

**Deploying?** → DevOps Engineer

**Security concern?** → Security Reviewer

**Code quality check?** → Code Reviewer

**About to launch?** → Launch Orchestrator

**Understanding users?** → UX Researcher or Discovery Researcher

**Building AI features?** → AI Architect or Prompt Engineer

**Workflow optimization?** → Productivity Optimizer

---

## How to Invoke Agents

### Natural Language (Recommended)
```
"I need a full-stack developer to help build authentication"
"Can a debug specialist help me with this error?"
"I need a UX designer to design the dashboard"
```

Claude will automatically route to the appropriate agent.

### Explicit (When Specific)
```
Use the Task tool with:
- subagent_type: "full-stack-developer"
- prompt: "Build user authentication with Supabase"
```

---

## Agent Combinations

### Small Team Simulation
For complex work, engage multiple agents in sequence:

```
Session 1: Product Strategist + UX Designer
→ Define feature + Design interface

Session 2: Full-Stack Developer
→ Implement feature

Session 3: Test Generator + Code Reviewer
→ Tests + Quality check

Session 4: Content Strategist + Launch Orchestrator
→ Messaging + Launch plan
```

### Parallel Work
For independent tasks:

```
Simultaneously:
├─ DevOps Engineer → Set up deployment
├─ Content Strategist → Write landing page
└─ Security Reviewer → Audit existing code

Then: Full-Stack Developer → Integrate everything
```

---

## Token Considerations

**Light agents** (~2K tokens):
- Test Generator
- Content Strategist
- Tech Writer

**Medium agents** (~3-5K tokens):
- Full-Stack Developer
- Code Reviewer
- Debug Specialist

**Heavy agents** (~5-8K tokens):
- Product Strategist (requires context)
- UX Designer (design systems)
- Launch Orchestrator (comprehensive plans)

**Tip:** Use "Check context" command to monitor token usage when using multiple agents.

---

## Best Practices

### ✅ Do
- Be specific about what you need
- Provide context about your project
- Use agents sequentially for complex work
- Combine agents for comprehensive coverage
- Check context when using multiple agents

### ❌ Don't
- Load all agents at once
- Switch agents mid-task without reason
- Use wrong agent for the task
- Forget to provide necessary context
- Ignore agent recommendations

---

## Examples

### Good Usage
```
✅ "I need a full-stack developer to build user authentication
   with Supabase. The app is Next.js 14 with TypeScript."

✅ "Can a debug specialist help? I'm getting 'Cannot read
   property of undefined' in my React component when fetching data."

✅ "I need a code review before merging. This adds the payment
   integration with Stripe."
```

### Unclear Usage
```
❌ "Help me code"
   → Too vague, specify what you're building

❌ "Review this" [no context]
   → What should be reviewed? What are you concerned about?

❌ "Make it better"
   → Better how? Performance? UX? Code quality?
```

---

## Reference

**Full agent list:** See `.workspace/CLAUDE.md` for detailed descriptions

**Custom commands:** See `.workspace/commands/` for project-specific workflows

**Context thresholds:** See `.workspace/CONTEXT-THRESHOLDS.md` for token management

---

**Quick Tip:** Most of the time, you'll use **Full-Stack Developer** for building and **Debug Specialist** for fixing. The other agents are for specialized needs.

**Last Updated:** November 2025
