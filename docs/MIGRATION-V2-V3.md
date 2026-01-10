# Migration Guide: v2.0 to v3.0

> **Time**: 15-30 minutes
> **Breaking Changes**: Yes (see below)

## Overview

v3.0 is a significant upgrade that introduces:

- Dynamic model recommendations (always-analyze)
- Real sub-agents via Claude Code's Task tool
- Hooks system for automation
- Consolidated role personas (17 → 8)
- Simplified integration tiers (4 → 2)

---

## Breaking Changes

### 1. Agents → Personas

**v2.0**: "Agents" were role-based prompt templates
**v3.0**: Clear separation between:
- **Sub-agents**: Real autonomous agents (Explore, Plan, Bash, General-Purpose)
- **Personas**: Perspective/expertise framing (8 core roles)

**Impact**: Update any references from "agents" to "personas" or "sub-agents" as appropriate.

**Files Changed**:
- `AGENT-QUICK-REF.md` → Deprecated (replaced by `PERSONAS.md`)
- New: `SUBAGENTS.md` for real sub-agent documentation

### 2. 17 Personas → 8 Core Personas

**Removed/Merged**:
| Removed | Merged Into |
|---------|-------------|
| Tech Writer | System documentation |
| Content Strategist | Specialized (add back if needed) |
| Discovery Researcher | Product Strategist |
| UX Researcher | Product Strategist |
| Productivity Optimizer | Specialized |
| Launch Orchestrator | DevOps Engineer |
| AI Architect | Specialized |
| Prompt Engineer | Specialized |
| Data Analyst | Specialized |

**Remaining 8**:
1. Full-Stack Developer
2. Debug Specialist
3. Code Reviewer
4. Security Reviewer
5. Test Engineer (renamed from Test Generator)
6. DevOps Engineer
7. Product Strategist
8. UX Designer

### 3. Integration Tiers Simplified

**v2.0**: Minimal / Standard / Full / Professional (4 tiers)
**v3.0**: Essential / Extended (2 tiers)

| v2.0 Tier | v3.0 Equivalent |
|-----------|-----------------|
| Minimal | Essential |
| Standard | Essential |
| Full | Extended |
| Professional | Extended |

### 4. Hooks System Added

**New**: `.claude/hooks/` directory with auto-run and validated hooks

**Configuration**: `settings.local.json` now includes hooks configuration

---

## Migration Steps

### Option 1: Automatic Migration Script

```bash
# From the template repository root
./migrate-v2-to-v3.sh /path/to/your-v2-project
```

The script will:
1. Back up existing configuration
2. Add new v3.0 files (MODEL-STRATEGY.md, SUBAGENTS.md, PERSONAS.md)
3. Create hooks directory structure
4. Update settings.local.json
5. Preserve your existing project documentation

### Option 2: Manual Migration

#### Step 1: Add New Files

Copy these files to your project's `.claude/` directory:

```bash
# From template
cp project-template/.claude/MODEL-STRATEGY.md your-project/.claude/
cp project-template/.claude/SUBAGENTS.md your-project/.claude/
cp project-template/.claude/PERSONAS.md your-project/.claude/
cp -r project-template/.claude/hooks your-project/.claude/
```

#### Step 2: Update settings.local.json

Add hooks configuration:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/auto/session-start.sh",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

Add hook permission:

```json
{
  "permissions": {
    "allow": [
      // ... existing permissions ...
      "Bash(bash .claude/hooks/*)"
    ]
  }
}
```

#### Step 3: Update Agent References

Search your project for references to the old "agents" and update:

| Old Reference | New Reference |
|--------------|---------------|
| "Use the Full-Stack Developer agent" | "As a Full-Stack Developer persona" |
| "Launch the Debug Specialist agent" | "Debug Specialist perspective" |
| `AGENT-QUICK-REF.md` | `PERSONAS.md` |

#### Step 4: Make Hooks Executable

```bash
chmod +x .claude/hooks/auto/*.sh
chmod +x .claude/hooks/validated/*.sh
```

#### Step 5: Review Model Strategy

Read `MODEL-STRATEGY.md` to understand the new model recommendation system.

---

## Validation Checklist

After migration, verify:

- [ ] Session start hook runs successfully
- [ ] Model recommendations appear for tasks
- [ ] Sub-agent invocations work (`Plan the implementation of...`)
- [ ] Personas can be invoked (`As a Security Reviewer...`)
- [ ] Existing project documentation preserved
- [ ] Status tracking still works (`Update status`)

---

## Rollback

If you need to rollback:

```bash
# If using migration script, restore from backup
cp -r .claude-backup-v2/* .claude/

# Or manually remove v3.0 additions
rm .claude/MODEL-STRATEGY.md
rm .claude/SUBAGENTS.md
rm .claude/PERSONAS.md
rm -rf .claude/hooks/
# Restore original settings.local.json
```

---

## New Features to Explore

### Model Recommendations

Claude now analyzes every task and recommends the optimal model:

```
Model Recommendation: Opus 4.5

Task: Design database schema for multi-tenant system

Pros:
- Deep reasoning for complex architecture
- Best at considering edge cases

Cons:
- Higher latency

Alternative: Use Sonnet for refinement after initial design
```

### Real Sub-Agents

Use the Task tool for autonomous work:

```
"Explore the authentication system"  → Explore agent
"Plan the implementation of OAuth2"  → Plan agent
"Run tests in background"            → Bash agent (background)
```

### Hooks

Auto-run hooks on session start:
- Environment validation
- Git status
- Dependency checks
- Build status display

Validated hooks (require confirmation):
- Pre-commit linting
- Test suite execution

### Persona + Sub-Agent Synergy

Combine real sub-agents with persona perspectives:

```
1. Explore Agent finds security-sensitive code
2. Security Reviewer persona (Opus 4.5) analyzes vulnerabilities
3. Plan Agent creates remediation plan
4. Full-Stack Developer persona implements fixes
```

---

## Getting Help

If you encounter issues during migration:

1. Check the error message carefully
2. Verify file permissions (especially hooks)
3. Validate JSON syntax in settings.local.json
4. Review the full documentation in `README.md`

---

*Migration Guide Version: 1.0*
*For Template Version: 3.0*
*Last Updated: January 2026*
