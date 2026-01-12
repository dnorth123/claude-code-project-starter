# Output Styles System

> **Version**: 3.1
> **Type**: Workflow Configuration

## Overview

Output Styles allow you to **customize Claude's behavior and focus** for different types of work. By default, Claude Code is optimized for software engineering. Output styles let you shift that focus.

**Key Insight**: By default, AI models jump to creating the final "artifact." Output styles let you control when Claude should explore/think vs. when it should produce output.

---

## Available Output Styles

| Style | Focus | Use Case |
|-------|-------|----------|
| `research-mode` | Thinking, questions, exploration | Research, analysis, learning |
| `implementation-mode` | Code production (default) | Building features, fixing bugs |
| `thinking-mode` | Deep exploration before action | Complex problems, architecture |
| `documentation-mode` | Technical writing | Docs, READMEs, guides |
| `review-mode` | Critical analysis | Code review, audits |

---

## How to Use

### Switch Output Style

```bash
# In conversation
"Switch to research mode"
"Use thinking mode for this"
"Apply documentation style"

# Or reference directly
"Using the research-mode output style, help me understand..."
```

### Style-Specific Invocations

```bash
# Research Mode
"Research [topic] - don't write code, just explore"
"Help me understand [concept] deeply"

# Thinking Mode
"Think through [problem] before we implement"
"Explore the options for [decision]"

# Documentation Mode
"Document how [system] works"
"Write technical docs for [feature]"

# Review Mode
"Critically analyze [code/approach]"
"Review [implementation] for issues"
```

---

## Output Style Files

Each style is defined in a Markdown file with:

```markdown
---
name: style-name
keep-coding-instructions: true/false
---

# Style Name

[Style-specific instructions for Claude]
```

### Frontmatter Options

| Option | Values | Description |
|--------|--------|-------------|
| `keep-coding-instructions` | `true`/`false` | Whether to retain coding focus |
| `persona-compatible` | list | Which personas work with this style |

---

## Integration with Personas

Output styles complement personas:

| Combination | Best For |
|-------------|----------|
| Research Mode + Debug Specialist | Investigating complex bugs |
| Thinking Mode + Product Strategist | Strategic planning |
| Documentation Mode + Full-Stack Developer | Technical documentation |
| Review Mode + Security Reviewer | Security audits |
| Implementation Mode + Any | Default coding work |

---

## Creating Custom Output Styles

1. Create a new `.md` file in `.claude/output-styles/`
2. Add frontmatter with `name` and `keep-coding-instructions`
3. Write instructions that shape Claude's behavior
4. Reference by name in conversations

### Template

```markdown
---
name: my-custom-style
keep-coding-instructions: false
persona-compatible: [Product Strategist, UX Designer]
---

# My Custom Style

## Focus
[What this style optimizes for]

## Behavior
[How Claude should behave]

## Output Format
[What outputs should look like]

## Do
- [Behavior to encourage]

## Don't
- [Behavior to avoid]
```

---

## Best Practices

1. **Start with Thinking**: For complex problems, use `thinking-mode` before `implementation-mode`
2. **Match to Task**: Research tasks → research mode; building → implementation mode
3. **Combine with Personas**: Use styles for *how* to work, personas for *what* expertise
4. **Explicit Transitions**: Clearly state when switching styles

---

*Last Updated: January 2026*
*Template Version: 3.1*
