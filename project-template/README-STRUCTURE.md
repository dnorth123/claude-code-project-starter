# Project README Structure Guide

This file provides a recommended structure for your project README.md. During Phase 0 planning, Claude Code will use this as a reference to create your project-specific README.md file.

---

## Recommended Structure

```markdown
# [Project Name]

[Brief tagline - 1 sentence describing what your project does]

## Overview

[2-3 paragraph description of your project]
- What problem does it solve?
- Who is it for?
- What makes it unique or valuable?

## Tech Stack

**Frontend:**
- [Framework/Library] - [Why you chose it]
- [Styling solution]
- [Key libraries]

**Backend:** (if applicable)
- [Framework]
- [Database]
- [API type]

**Infrastructure:**
- Hosting: [Platform]
- CI/CD: [Tool/Service]

[Auto-synced from docs/project/tech-stack.md during planning]

## Current Status

🚧 **Phase [N]** - [Phase Name] ([X]% complete)

**Completed:**
- ✅ [Feature/milestone]
- ✅ [Feature/milestone]

**In Progress:**
- 🔄 [Current work]

**Next:**
- ⏭️ [Upcoming work]

[Auto-updated via "Update status" command from docs/project/build-status.md]

## Getting Started

### Prerequisites

- Node.js [version]
- [Other requirements]

### Installation

```bash
# Clone the repository
git clone [your-repo-url]
cd [project-name]

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env
# Edit .env with your configuration

# Run development server
npm run dev
```

### Configuration

[Any configuration steps needed]

## Usage

[How to use the application - main features and workflows]

### Example

```bash
# Example command or usage
npm run [command]
```

[Screenshots or GIFs if applicable]

## Development

### Project Structure

```
project/
├── [key directory]/ - [description]
├── [key directory]/ - [description]
└── [key directory]/ - [description]
```

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run test` - Run tests
- [Other scripts]

### Development Workflow

[Brief explanation of how to contribute/develop]

## Deployment

### Production Build

```bash
npm run build
```

### Deploy to [Platform]

[Deployment instructions specific to your hosting platform]

**Live URL:** [Deployment URL when available]

## Roadmap

See [docs/project/roadmap.md](docs/project/roadmap.md) for future enhancements and planned features.

## License

[License type - e.g., MIT, Apache 2.0, Proprietary]

## Acknowledgments

- Built with [Claude Code](https://claude.ai/code)
- [Other acknowledgments]

---

**Project Status:** Active Development | MVP Complete | Production
**Last Updated:** [Auto-updated]
```

---

## Section Guidelines

### Auto-Updated Sections
These sections are automatically updated by Claude Code during development:

- **Tech Stack** - Synced from `docs/project/tech-stack.md` during Phase 0 and major tech changes
- **Current Status** - Updated via "Update status" command from `docs/project/build-status.md`
- **Roadmap reference** - Points to `docs/project/roadmap.md`
- **Last Updated** - Timestamp of last README update

### Manual Sections
These sections are created during Phase 0 and updated manually as needed:

- **Overview** - Based on `docs/project/project-plan.md` overview
- **Getting Started** - Created once project is runnable
- **Usage** - Added as features are completed
- **Development** - Documented as project structure stabilizes
- **Deployment** - Added when deployment is configured

### Optional Sections
Add these if relevant to your project:

- **API Documentation** - For backend APIs
- **Testing** - If you have test coverage
- **Contributing** - For open source projects
- **Changelog** - For tracking version history
- **FAQ** - For common questions
- **Troubleshooting** - For known issues

---

## Tips for Effective READMEs

1. **Keep it current** - Use "Update status" regularly to keep status section fresh
2. **Be concise** - Put detailed docs in separate files, link from README
3. **Use visuals** - Screenshots, GIFs, or diagrams help users understand quickly
4. **Start simple** - During Phase 0, create minimal README; expand as project grows
5. **Think user-first** - What does someone need to know to use/run your project?

---

## Phase 0 Creation Process

During Phase 0 planning, Claude Code will:

1. **Archive template README** - Rename `README.md` → `TEMPLATE-README.md`
2. **Extract project info** from planning docs:
   - Project name and overview from `project-plan.md`
   - Tech stack from `tech-stack.md`
   - Current status from `build-status.md`
3. **Create initial README.md** with:
   - Header and overview
   - Tech stack section
   - Status showing "Phase 0 - Planning Complete"
   - Placeholder sections for setup/usage (to be filled as project develops)
4. **Commit the change** - New README is part of Phase 0 completion

---

This structure guide stays in your repository as `README-STRUCTURE.md` for reference throughout development.
