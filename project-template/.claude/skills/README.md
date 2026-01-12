# Agent Skills System

> **Version**: 3.1
> **Type**: Packaged Reproducible Workflows

## Overview

Skills are **packaged, reproducible workflows** that Claude recognizes and activates automatically when your request matches the skill's description. Unlike slash commands (user-invoked), skills are expertise modules that Claude applies contextually.

**Key Insight**: Skills let you package complex workflows (like "catch me up on recent changes" or "research competitors in parallel") into reusable modules that work the same way every time.

---

## Available Skills

| Skill | Purpose | Activation |
|-------|---------|------------|
| `catch-up` | Summarize recent project progress | "Catch me up on..." |
| `parallel-research` | Research multiple topics simultaneously | "Research X, Y, Z competitors..." |
| `blob-converter` | Convert PDFs/docs to Markdown | "Convert this PDF to markdown" |
| `self-verify` | Verification-led development | "Verify this implementation works" |

---

## How Skills Work

### Automatic Activation

Skills are activated when Claude recognizes matching intent:

```bash
# Activates catch-up skill
"Catch me up on what happened this week"
"What's been done since Monday?"
"Summarize the last few days of work"

# Activates parallel-research skill
"Research React, Vue, and Svelte - compare them"
"Analyze these 10 competitors"
"Find information about all these libraries"

# Activates blob-converter skill
"Convert this PDF to markdown"
"I have a Word doc that needs to be readable"
"Turn these slides into markdown"

# Activates self-verify skill
"Verify the auth system works"
"Make sure this feature is working correctly"
"Test and verify the implementation"
```

### Manual Invocation

You can also invoke skills explicitly:

```bash
"Use the catch-up skill for the last 3 days"
"Apply parallel-research to these competitors: [list]"
"Run self-verify on the checkout flow"
```

---

## Skill File Format

Each skill is defined in a Markdown file with:

```markdown
---
name: skill-name
description: When to use this skill
triggers: [list, of, trigger, phrases]
---

# Skill Name

## Purpose
[What this skill accomplishes]

## Workflow
[Step-by-step process]

## Output Format
[What the skill produces]

## Examples
[Example inputs and outputs]
```

---

## Creating Custom Skills

1. Create a new `.md` file in `.claude/skills/`
2. Add frontmatter with `name`, `description`, and `triggers`
3. Document the workflow clearly
4. Test with various trigger phrases

### Template

```markdown
---
name: my-custom-skill
description: Brief description of when this skill applies
triggers: [keyword1, keyword2, "phrase trigger"]
---

# My Custom Skill

## Purpose
[Problem this skill solves]

## Prerequisites
[What's needed before running]

## Workflow

### Step 1: [Name]
[What to do]

### Step 2: [Name]
[What to do]

## Output Format
[Structure of the output]

## Example

**Input**: [Example request]

**Output**: [Example result]
```

---

## Skill + Sub-Agent Integration

Skills often leverage sub-agents for execution:

| Skill | Primary Sub-Agent | Use Case |
|-------|-------------------|----------|
| `catch-up` | Explore Agent | Finding recent file changes |
| `parallel-research` | Multiple General-Purpose Agents | Concurrent research |
| `blob-converter` | Bash Agent | File conversion commands |
| `self-verify` | Bash Agent + Explore Agent | Running tests, checking results |

---

## Best Practices

### Skill Design

1. **Single Purpose**: Each skill should do one thing well
2. **Clear Triggers**: Make activation phrases obvious
3. **Consistent Output**: Same input should produce same output structure
4. **Error Handling**: Define what happens when things go wrong

### Using Skills

1. **Trust Activation**: Let Claude recognize when to use skills
2. **Provide Context**: Give enough info for the skill to work
3. **Review Output**: Skills automate but humans verify
4. **Iterate**: Refine skills based on actual usage

---

## Skills vs. Commands vs. Personas

| Concept | Purpose | Invocation |
|---------|---------|------------|
| **Skills** | Packaged workflows | Automatic (contextual) |
| **Commands** | User-triggered actions | Explicit (`/command`) |
| **Personas** | Expertise perspective | Explicit ("As a...") |

### Example Combination

```
Request: "Catch me up on security changes from last week,
         then review them as a Security Reviewer"

Execution:
1. catch-up skill (automatic) → Finds recent changes
2. Filters to security-related changes
3. Security Reviewer persona (explicit) → Analyzes findings
```

---

*Last Updated: January 2026*
*Template Version: 3.1*
