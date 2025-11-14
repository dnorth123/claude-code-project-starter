# 🎨 Role-Based Template System - Brainstorming

**Date**: 2025-11-14
**Status**: Planning / Awaiting Decision
**Session**: Initial brainstorming for role-specific template variants

---

## 📝 Overview

This document outlines multiple approaches to tailor the claude-code-project-starter template system for different professional roles beyond software development (e.g., UX designers, product managers, marketing specialists, data analysts, etc.).

**Current State**: The template is developer-focused with BUILD-STATUS.md, project-plan.md, tech-stack.md, and phase-based development.

**Goal**: Make the system useful and natural for non-developer roles while maintaining the core benefits (automatic status tracking, context management, smart resume, etc.).

---

## 🎯 Approach 1: Multiple Template Variants

### Concept
Create separate template directories for each role, each with role-appropriate documentation structure and workflows.

### Structure
```
templates/
├── developer/          # Current template (baseline)
├── ux-designer/
├── product-manager/
├── marketing/
├── data-analyst/
├── devops/
└── technical-writer/
```

### Role-Specific Examples

#### 🎨 UX Designer Template

**Documentation Structure:**
- `docs/design/design-status.md` (instead of build-status.md)
- `docs/design/design-system.md` (color palette, typography, components)
- `docs/design/user-flows.md` (journeys, scenarios)
- `docs/design/accessibility-checklist.md`
- `docs/design/prototype-versions.md`
- `docs/design/user-research.md` (findings, personas)

**Tech Stack Focus:**
- Figma/Sketch files tracking
- Design tokens (JSON/YAML)
- Component library (Storybook, etc.)
- Prototyping tools (Framer, ProtoPie)

**Phase Structure:**
- Phase 0: Research & Discovery
- Phase 1: Information Architecture & Wireframes
- Phase 2: Visual Design & Design System
- Phase 3: Prototyping & Testing
- Phase 4: Handoff & Documentation

**Commands:**
- "Update design status" (instead of build status)
- "Review design system"
- "Check accessibility compliance"
- "Export design specs"

**Git Integration:**
- Track .fig files, design tokens
- Version design system components
- Tag major design milestones

#### 📊 Product Manager Template

**Documentation Structure:**
- `docs/product/product-status.md`
- `docs/product/roadmap.md` (more detailed than dev roadmap)
- `docs/product/user-stories.md`
- `docs/product/requirements.md` (PRD structure)
- `docs/product/metrics.md` (KPIs, success criteria)
- `docs/product/stakeholder-feedback.md`
- `docs/product/competitive-analysis.md`
- `docs/product/release-notes.md`

**Phase Structure:**
- Phase 0: Discovery & Problem Definition
- Phase 1: Requirements & User Stories
- Phase 2: Prioritization & Roadmap Planning
- Phase 3: Execution Tracking & Stakeholder Management
- Phase 4: Launch & Post-Launch Analysis

**Commands:**
- "Update product roadmap"
- "Add user story"
- "Track feature status"
- "Generate release notes"
- "Check OKR progress"

**Integration Focus:**
- Jira/Linear integration concepts
- Google Analytics/Mixpanel tracking
- User feedback aggregation

#### 📣 Marketing Specialist Template

**Documentation Structure:**
- `docs/marketing/campaign-status.md`
- `docs/marketing/content-calendar.md`
- `docs/marketing/campaign-plans/` (per campaign)
- `docs/marketing/audience-personas.md`
- `docs/marketing/messaging-framework.md`
- `docs/marketing/performance-metrics.md`
- `docs/marketing/content-library.md`
- `docs/marketing/brand-guidelines.md`

**Phase Structure:**
- Phase 0: Strategy & Planning
- Phase 1: Content Creation
- Phase 2: Campaign Execution
- Phase 3: Optimization & A/B Testing
- Phase 4: Analysis & Reporting

**Commands:**
- "Update campaign status"
- "Add content to calendar"
- "Track campaign metrics"
- "Generate performance report"

**Tech Stack Focus:**
- Marketing automation tools
- Analytics platforms
- CMS platforms
- Email marketing tools
- Social media schedulers

**Pros:**
- ✅ Clear separation between roles
- ✅ Easier to understand for users
- ✅ Can optimize each template independently

**Cons:**
- ❌ More maintenance burden (N templates to update)
- ❌ Harder to add features across all templates
- ❌ Doesn't support mixed-role projects well

---

## 🎯 Approach 2: Interactive Setup with Role Detection

### Concept
Enhance `setup-project.sh` to ask about the project type upfront, then configure the template accordingly.

### Implementation

**Add role selection at setup start:**

```bash
echo "What type of project are you working on?"
echo "1) Software Development"
echo "2) UX/UI Design"
echo "3) Product Management"
echo "4) Marketing Campaign"
echo "5) Data Analysis"
echo "6) DevOps/Infrastructure"
echo "7) Technical Documentation"
echo "8) Custom (I'll configure manually)"
```

**Then adapt based on selection:**

1. **Copy appropriate template** from templates/[role]/
2. **Ask role-specific questions:**
   - **UX Designer:** "Are you designing for web, mobile, or both?"
   - **PM:** "Is this a B2B or B2C product?"
   - **Marketing:** "What's the primary channel? (Social, Email, Content, Paid)"
3. **Configure role-specific commands** in `.claude/claude.md`
4. **Set up role-appropriate permission presets**
5. **Create role-specific .gitignore** (e.g., design files, data files, etc.)

**Pros:**
- ✅ Guided experience for new users
- ✅ Customizes template at creation time
- ✅ Can combine with other approaches
- ✅ Easy to extend with more roles

**Cons:**
- ❌ Still requires maintaining separate templates (if using Approach 1)
- ❌ Users can't easily change role after setup

---

## 🎯 Approach 3: Modular Documentation System

### Concept
Keep one base template, add optional modules that get included based on project needs.

### Structure

```
project-template/
├── core/                    # Base system (everyone gets this)
│   ├── .claude/
│   └── docs/project/
├── modules/
│   ├── design/             # Add for UX designers
│   │   └── docs/design/
│   ├── product/            # Add for PMs
│   │   └── docs/product/
│   ├── marketing/          # Add for marketing
│   │   └── docs/marketing/
│   ├── data/               # Add for data analysts
│   │   └── docs/data/
│   └── devops/             # Add for DevOps
│       └── docs/infrastructure/
```

**Setup wizard asks:**
```
"Select all that apply to your project:"
[ ] Software Development (core - always included)
[ ] Design System
[ ] Product Management
[ ] Marketing Content
[ ] Data Analytics
[ ] Infrastructure/DevOps
```

**Can add modules later:**
```bash
./add-module.sh design
```

**Pros:**
- ✅ Single template to maintain
- ✅ Supports mixed-role projects (e.g., dev + design)
- ✅ Users can add modules incrementally
- ✅ Less duplication

**Cons:**
- ❌ More complex to implement
- ❌ Module interactions need careful design
- ❌ Core template needs to be role-agnostic

---

## 🎯 Approach 4: Hybrid Tech Stack Recommendations

### Concept
Smart tech stack detection during setup that populates tech-stack.md with role-appropriate content.

### Implementation

**In `setup-project.sh`, ask context questions:**

```bash
# For UX Designers:
"What design tools do you use?"
[ ] Figma  [ ] Sketch  [ ] Adobe XD  [ ] Framer

"Do you need to track design tokens?"
"Do you need a component library?"
"Will you be prototyping?"

# For Marketing:
"What platforms will you use?"
[ ] WordPress  [ ] Webflow  [ ] HubSpot  [ ] Mailchimp

# For Product:
"Do you track with Jira/Linear/other?"
"Will you need analytics integration?"
```

**Then populate `tech-stack.md` with role-appropriate sections:**

**UX Designer tech-stack.md:**
```markdown
# Design Stack

## Design Tools
- **Primary**: Figma
- **Prototyping**: Framer
- **Handoff**: Zeplin

## Component System
- Design tokens in JSON
- Storybook for component docs

## Plugins & Extensions
- Figma Auto Layout
- Content Reel
- A11y - Color Contrast Checker
```

**Marketing tech-stack.md:**
```markdown
# Marketing Stack

## Content Management
- **CMS**: Webflow
- **Blog**: WordPress

## Campaign Tools
- **Email**: Mailchimp
- **Social**: Buffer
- **Analytics**: Google Analytics 4

## Creative Tools
- Canva Pro
- Adobe Creative Cloud
```

**Pros:**
- ✅ Easy to implement
- ✅ Provides immediate value
- ✅ Educational for users (suggests tools they might need)
- ✅ Works with any approach

**Cons:**
- ❌ Need to maintain curated tool lists
- ❌ Tools change frequently

---

## 🎯 Approach 5: Role-Specific Workflow Commands

### Concept
Customize `.claude/claude.md` commands and behaviors per role.

### Examples

**Current (Developer):**
- "Update status" → updates BUILD-STATUS.md
- "Check context" → token usage
- "Phase [N] complete" → git tags

**UX Designer:**
- "Update design status" → updates design-status.md
- "Export component specs" → generates handoff docs
- "Check accessibility" → reviews WCAG compliance
- "Version design system" → creates design system snapshot
- "Design review complete" → marks milestone

**Product Manager:**
- "Update product roadmap" → syncs roadmap.md
- "Add feature request" → creates structured entry
- "Generate PRD" → compiles requirements doc
- "Track sprint progress" → updates sprint status
- "Prepare stakeholder update" → generates summary

**Marketing Specialist:**
- "Update campaign calendar" → syncs calendar
- "Track campaign metrics" → updates performance data
- "Generate content brief" → creates template
- "Schedule content" → adds to calendar
- "Campaign complete" → generates report

**Pros:**
- ✅ Makes Claude feel role-specific
- ✅ Natural language matches role vocabulary
- ✅ Core system remains the same
- ✅ Easy to customize per project

**Cons:**
- ❌ Need to document commands clearly
- ❌ Users need to learn role-specific commands

---

## 🎯 Approach 6: Permission Presets by Role

### Concept
Add role-specific permission presets to the `/setup-permissions` command.

**Current presets:**
- Aggressive (dev-focused)
- Moderate
- Conservative
- Maximum Security

**Add role-based presets:**

### UX Designer Preset

```json
{
  "name": "UX Designer - Design Focused",
  "autoApprove": {
    "Read": "all",
    "Write": ["*.md", "*.json", "*.css", "*.scss"],
    "Edit": ["*.md", "design-tokens/*"],
    "Bash": [
      "git status", "git add", "git commit", "git push",
      "npm run storybook",
      "npm run build-tokens"
    ]
  },
  "askFirst": {
    "Bash": ["npm install*", "rm*"],
    "Write": ["*.js", "*.ts"]
  }
}
```

### Product Manager Preset

```json
{
  "name": "Product Manager - Documentation Focused",
  "autoApprove": {
    "Read": "all",
    "Write": ["docs/**/*.md", "*.csv"],
    "Edit": ["docs/**/*.md"],
    "Bash": [
      "git status", "git add", "git commit", "git push"
    ]
  },
  "askFirst": {
    "Bash": ["npm*", "pip*", "docker*"],
    "Write": ["*.js", "*.py", "*.sh"]
  }
}
```

### Marketing Specialist Preset

```json
{
  "name": "Marketing - Content Focused",
  "autoApprove": {
    "Read": "all",
    "Write": ["content/**/*", "campaigns/**/*", "*.md"],
    "Edit": ["content/**/*", "campaigns/**/*"],
    "Bash": [
      "git status", "git add", "git commit", "git push",
      "imagemagick", "convert"
    ]
  }
}
```

**Pros:**
- ✅ Improves security for non-technical users
- ✅ Makes auto-approval feel safer
- ✅ Extends existing permission system
- ✅ Easy to add new presets

**Cons:**
- ❌ Requires maintaining permission patterns per role
- ❌ May need to update as tools evolve

---

## 🎯 Approach 7: Context Management Variations

### Concept
Different roles have different context needs - adjust thresholds accordingly.

### Analysis

**Developers:**
- Large code files
- Multiple dependencies
- Need 70% threshold alerts

**UX Designers:**
- Many small image references
- Design token files
- Could work with 80% threshold

**Product Managers:**
- Mostly text/markdown
- Large requirement docs
- Could work with 85% threshold

### Implementation

Make context thresholds configurable per template:

```markdown
# In .claude/claude.md

**Context Budget Thresholds** (Role: UX Designer):
- 🟢 Green: < 160K tokens (80%)
- 🟡 Yellow: 160-180K tokens (80-90%)
- 🟠 Orange: 180-195K tokens (90-97%)
- 🔴 Red: > 195K tokens (97%+)
```

**Pros:**
- ✅ Optimizes context usage per role
- ✅ Reduces unnecessary alerts
- ✅ Simple to configure

**Cons:**
- ❌ Need to educate users on why thresholds differ
- ❌ May need experimentation to find right values

---

## 🎯 Approach 8: Workspace Categories by Role

### Concept
For Workspace Mode, organize projects by role-specific categories instead of generic personal/work/client.

**Current structure:**
```
projects/
├── personal/
├── work/
└── client/
```

### Role-Based Structures

**For UX Designer:**
```
projects/
├── client-projects/
├── design-systems/
├── prototypes/
├── user-research/
└── portfolio-pieces/
```

**For Product Manager:**
```
projects/
├── active-products/
├── discovery/
├── archived-products/
└── experiments/
```

**For Marketing:**
```
projects/
├── campaigns/
│   ├── q1-2024/
│   ├── q2-2024/
├── content-library/
├── brand-assets/
└── analytics-reports/
```

**Pros:**
- ✅ Workspace feels natural to role
- ✅ Better organization for role-specific work
- ✅ Easy to implement in setup

**Cons:**
- ❌ Less flexible for multi-role users
- ❌ May not fit everyone's mental model

---

## 🎯 Approach 9: Integration Hooks by Role

### Concept
Add role-specific integration setup options during project creation.

### Examples

**UX Designer Integrations:**
- Figma API webhook setup
- Design token sync script
- Storybook deployment
- Screenshot automation

**Product Manager Integrations:**
- Jira/Linear webhook
- Analytics dashboard embed
- User feedback aggregation
- Changelog generation

**Marketing Integrations:**
- Google Analytics API
- Social media scheduling
- Email platform webhooks
- SEO tools integration

**Pros:**
- ✅ Provides immediate practical value
- ✅ Reduces setup friction
- ✅ Shows Claude Code can integrate with their existing tools

**Cons:**
- ❌ Complex to implement
- ❌ Requires API knowledge for many services
- ❌ Maintenance burden for integrations

---

## 📋 Implementation Recommendations

### Option A: Phased Approach (Recommended)

**Phase 1:** Start with Approach 2 (interactive setup with role detection) + Approach 4 (smart tech stack)
- Easiest to implement
- Immediate value
- Foundation for future enhancements
- Estimated time: 4-6 hours

**Phase 2:** Add Approach 1 (multiple template variants) for top 3 roles
- UX Designer
- Product Manager
- Marketing Specialist
- Estimated time: 8-12 hours

**Phase 3:** Add Approach 6 (role-specific permission presets)
- Estimated time: 3-4 hours

**Phase 4:** Add Approach 3 (modular system) for mixed-role projects
- Estimated time: 6-8 hours

**Total estimated time: 21-30 hours**

### Option B: Minimal Viable Product

**Just Approach 2 + Approach 5**
- Interactive setup that customizes commands and docs
- Single template, configured at setup time
- Fast to implement, covers 80% of use cases
- Estimated time: 3-5 hours

### Option C: Full Featured

**All approaches combined**
- Maximum flexibility
- Best user experience
- Longer development time
- Estimated time: 30-40 hours

---

## 🤔 Questions for Decision Making

Before implementation, need answers to:

### 1. Which roles are most important to support first?

- [ ] UX/UI Designer
- [ ] Product Manager
- [ ] Marketing Specialist
- [ ] Data Analyst
- [ ] DevOps Engineer
- [ ] Technical Writer
- [ ] Other: _______________

**Priority order:** _______________

### 2. Preference on approach?

- [ ] Multiple separate templates (easier to understand, harder to maintain)
- [ ] One template with modules (more flexible, slightly complex)
- [ ] Intelligent setup that configures a single template (balance)
- [ ] Combination: _______________

### 3. How much customization?

- [ ] **Light touch:** Just change doc names and commands
- [ ] **Medium:** Different phase structures and workflows
- [ ] **Deep:** Completely different experience per role

### 4. Workspace vs Single Project?

- [ ] Role-specific features in both modes
- [ ] Focus on Single Project mode first
- [ ] Focus on Workspace mode first
- [ ] Different features for each mode

### 5. Technical stack recommendations

- [ ] Maintain curated lists of tools per role
- [ ] Auto-populate tech-stack.md based on role
- [ ] Offer suggestions but let user customize
- [ ] Don't include tool recommendations

### 6. Git integration

Should we customize git workflows per role?
- [ ] Yes - different commit message templates, tag conventions
- [ ] No - keep git workflow consistent across roles
- [ ] Maybe - for specific roles only

### 7. Timeline preference

- [ ] Option A: Phased approach (21-30 hours)
- [ ] Option B: MVP (3-5 hours)
- [ ] Option C: Full featured (30-40 hours)
- [ ] Custom timeline: _______________

---

## 📝 Additional Considerations

### Maintenance Impact

**Adding role-specific templates means:**
- More documentation to keep updated
- More examples to maintain
- More testing needed per release
- Need clear contribution guidelines

**Mitigation strategies:**
- Use template inheritance/composition where possible
- Automated testing for template structure
- Community contributions for role-specific improvements

### User Education

**Will need to document:**
- How to choose the right template
- How to customize templates
- How to migrate between templates
- Role-specific best practices

### Community Input

**Consider:**
- Survey existing users about their roles
- Beta test with non-developer users
- Create role-specific example repositories
- Build case studies per role

---

## 🎯 Next Steps

Once decisions are made above:

1. **Create implementation plan** with specific tasks
2. **Set up test projects** for each role
3. **Implement chosen approach(es)**
4. **Document role-specific workflows**
5. **Create examples and case studies**
6. **Gather feedback from role-specific users**
7. **Iterate based on real-world usage**

---

## 📎 Related Files to Review

- Current `setup-project.sh`: /home/user/claude-code-project-starter/setup-project.sh
- Current template structure: /home/user/claude-code-project-starter/project-template/
- Permission system: /home/user/claude-code-project-starter/project-template/.claude/presets/
- Current README: /home/user/claude-code-project-starter/README.md

---

**Session Status**: Awaiting decisions on questions above before proceeding with implementation.

**Contact**: Reply to this session with answers to the questions, or request clarification on any approach.
