---
name: parallel-research
description: Research multiple topics simultaneously using sub-agents
triggers: [research competitors, analyze multiple, compare these, research all, parallel research, investigate several]
---

# Parallel Research Skill

## Purpose

Research multiple topics, competitors, or options **simultaneously** using sub-agents. Each sub-agent has its own 200K token context window, allowing comprehensive parallel analysis.

> "Subagents can research 15 competitors simultaneously, making the workflow up to 5x faster than sequential processing."

## When to Use

- Competitive analysis (multiple competitors)
- Technology comparison (multiple frameworks/tools)
- Market research (multiple segments)
- Architecture options (multiple approaches)
- Any N-way comparison where N > 2

## Prerequisites

- Clear list of research targets
- Defined research criteria
- Web search access (for external research)
- Sufficient context for internal research

## Workflow

### Step 1: Define Research Targets

Identify what to research:
```
Targets: [Company A, Company B, Company C, ...]
Criteria: [pricing, features, market position, ...]
Depth: [surface, moderate, deep]
```

### Step 2: Create Research Prompts

Generate specific prompts for each target:
```
For each target:
- What specific information to gather
- What questions to answer
- What format to return
```

### Step 3: Launch Parallel Sub-Agents

Deploy multiple General-Purpose agents simultaneously:

```
┌─────────────────────────────────────────────────────┐
│                    Main Agent                        │
└────────────┬──────────┬──────────┬──────────────────┘
             │          │          │
    ┌────────▼──┐ ┌─────▼─────┐ ┌──▼────────┐
    │ Research  │ │ Research  │ │ Research  │
    │ Target A  │ │ Target B  │ │ Target C  │
    │ (200K)    │ │ (200K)    │ │ (200K)    │
    └────────┬──┘ └─────┬─────┘ └──┬────────┘
             │          │          │
    ┌────────▼──────────▼──────────▼────────┐
    │           Synthesize Results           │
    └────────────────────────────────────────┘
```

### Step 4: Synthesize Findings

Combine results into coherent analysis:
- Common patterns across targets
- Key differentiators
- Strengths/weaknesses matrix
- Recommendations

## Output Format

```markdown
# Parallel Research: [Topic]

**Targets Researched**: [N]
**Research Depth**: [surface/moderate/deep]
**Date**: [YYYY-MM-DD]

## Executive Summary

[2-3 sentence overview of key findings]

## Comparison Matrix

| Criteria | Target A | Target B | Target C |
|----------|----------|----------|----------|
| [Criterion 1] | [Value] | [Value] | [Value] |
| [Criterion 2] | [Value] | [Value] | [Value] |

## Individual Analyses

### Target A

**Overview**: [Brief description]

**Strengths**:
- [Strength 1]
- [Strength 2]

**Weaknesses**:
- [Weakness 1]
- [Weakness 2]

**Key Insight**: [Most important finding]

### Target B
[Same structure...]

### Target C
[Same structure...]

## Cross-Target Patterns

### Common Themes
- [Pattern found across multiple targets]

### Key Differentiators
- [What makes each unique]

## Recommendations

Based on [your stated criteria/needs]:

1. **Best for [use case]**: Target X because...
2. **Best for [other use case]**: Target Y because...
3. **Avoid if**: Target Z if...

## Methodology

[Brief description of how research was conducted]
```

## Example

**Input**: "Research React, Vue, and Svelte for our new dashboard project"

**Process**:
1. Launch 3 parallel research agents
2. Each researches one framework
3. Agents return findings
4. Synthesize into comparison

**Sub-Agent Prompt (React)**:
```
Research React for a dashboard project. Cover:
- Current version and ecosystem maturity
- Learning curve and team adoption
- Component library options
- State management patterns
- Performance characteristics
- Enterprise adoption
- Community and support

Return structured findings for comparison.
```

**Output**:
```markdown
# Parallel Research: Frontend Framework Selection

**Targets Researched**: 3 (React, Vue, Svelte)
**Research Depth**: Moderate
**Date**: 2026-01-12

## Executive Summary

React offers the largest ecosystem and enterprise adoption. Vue provides
the best balance of power and simplicity. Svelte delivers superior
performance with a steeper production learning curve.

## Comparison Matrix

| Criteria | React | Vue | Svelte |
|----------|-------|-----|--------|
| Ecosystem Size | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Learning Curve | Moderate | Easy | Easy→Hard |
| Performance | Good | Good | Excellent |
| Enterprise Use | High | Medium | Growing |
| Bundle Size | Larger | Medium | Smallest |

## Recommendations

For your dashboard project:

1. **Best if team knows React**: Stick with React - MUI/Ant Design
   have excellent dashboard components
2. **Best for quick development**: Vue + Vuetify - fastest to
   productive
3. **Best for performance-critical**: Svelte - but fewer pre-built
   dashboard components
```

## Tips for Effective Parallel Research

1. **Be Specific**: Clear criteria = better comparisons
2. **Limit Scope**: 5-10 targets optimal, 15+ may lose coherence
3. **Define Output Format**: Tell agents what structure to return
4. **Use for Breadth**: Sequential research for depth on winner

## Model Recommendations

- **Sub-agents**: Sonnet 4.5 (good balance of speed/quality)
- **Synthesis**: Sonnet 4.5 or Opus 4.5 for complex analysis

---

*This skill dramatically accelerates comparative research.*
