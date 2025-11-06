# Claude Code Settings Guide

**Version**: 1.0
**Template**: claude-code-project-starter
**Configuration File**: `.claude/settings.local.json`

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Permission System Basics](#permission-system-basics)
3. [Auto-Approved Permissions Breakdown](#auto-approved-permissions-breakdown)
4. [Security & Safety Measures](#security--safety-measures)
5. [Customization Guide](#customization-guide)
6. [Common Scenarios](#common-scenarios)
7. [Troubleshooting](#troubleshooting)

---

## Overview

This template includes **aggressive auto-approval settings** designed for trusted development environments where you want Claude Code to work efficiently without constant permission prompts.

### What This Means

- ✅ **Faster workflow**: Claude can read, write, and execute common commands automatically
- ✅ **Fewer interruptions**: No approval prompts for standard development tasks
- ⚠️ **Trust required**: Only use in repositories where you trust Claude to make changes
- 🛡️ **Safety measures**: Dangerous operations are explicitly blocked

### Default Risk Profile

**Risk Level**: Moderate-Aggressive
**Best For**: Personal projects, trusted repos, development environments
**Not Recommended For**: Production systems, unfamiliar codebases, shared environments

---

## Permission System Basics

### How Permissions Work

Claude Code uses a permission system with three lists:

1. **`allow`**: Operations that don't require approval
2. **`deny`**: Operations that are always blocked (overrides allow)
3. **`ask`**: Operations that always prompt (default for unspecified operations)

### Permission Pattern Syntax

```json
"Bash(command:*)"     // Allows all variants of command
"Bash(git commit:*)"  // Allows "git commit" with any arguments
"Read(*)"             // Allows reading any file
"Task(*)"             // Allows all Task/Agent operations
```

### Evaluation Order

1. Check **deny** list first (blocks if matched)
2. Check **allow** list (permits if matched)
3. Default to **ask** (prompts user if not in allow/deny)

---

## Auto-Approved Permissions Breakdown

### 📂 File Operations

#### **`Read(*)`**

**What it allows**: Claude can read any file in your repository without approval

**Implications**:
- ✅ Freely explore codebase
- ✅ Analyze files for debugging
- ✅ Read configuration files
- ⚠️ Claude sees all file contents (including secrets if present)

**Use cases**:
- Code exploration and understanding
- Debugging by reading logs/configs
- Analyzing project structure

**Risk level**: Low (read-only operation)

---

#### **`Write(*)`**

**What it allows**: Claude can create new files anywhere in your repository

**Implications**:
- ✅ Generate new source files
- ✅ Create configuration files
- ✅ Write test files
- ⚠️ Can overwrite existing files without warning
- ⚠️ Can create files in any directory

**Use cases**:
- Creating new features/components
- Generating boilerplate code
- Creating configuration files

**Risk level**: Medium (can create/overwrite files)

**Safety note**: Always review new files before committing

---

#### **`Edit(*)`**

**What it allows**: Claude can modify any existing file

**Implications**:
- ✅ Fix bugs quickly
- ✅ Refactor code
- ✅ Update configurations
- ⚠️ Can modify critical files
- ⚠️ Changes are immediate (not staged for review)

**Use cases**:
- Bug fixes
- Feature implementation
- Code refactoring

**Risk level**: Medium-High (can modify any file)

**Safety note**: Use git to review changes before committing

---

#### **`Glob(*)`**

**What it allows**: Claude can search for files by pattern (e.g., `*.js`, `**/*.tsx`)

**Implications**:
- ✅ Quick file discovery
- ✅ Find files by extension or pattern
- ⚠️ Can see your entire file structure

**Use cases**:
- Finding all files of a type
- Locating specific components

**Risk level**: Very Low (read-only, metadata only)

---

#### **`Grep(*)`**

**What it allows**: Claude can search file contents using regex patterns

**Implications**:
- ✅ Find specific code patterns
- ✅ Search for function/class definitions
- ✅ Locate text in files
- ⚠️ Can read matching portions of files

**Use cases**:
- Finding function definitions
- Searching for TODOs or specific patterns
- Code analysis

**Risk level**: Low (read-only operation)

---

### 🔧 Git Operations

#### **`Bash(git fetch:*)`**

**What it allows**: Fetch updates from remote repositories

**Implications**:
- ✅ Update remote branch information
- ✅ Safe read-only network operation
- ❌ Does NOT modify your working directory

**Risk level**: Very Low

---

#### **`Bash(git status:*)`**

**What it allows**: Check repository status

**Implications**:
- ✅ See modified files
- ✅ Check branch status
- ❌ Read-only operation

**Risk level**: Very Low

---

#### **`Bash(git add:*)`**

**What it allows**: Stage files for commit

**Implications**:
- ✅ Prepare files for commit
- ⚠️ Can stage any file (including untracked)
- ❌ Does NOT commit (requires separate approval for commit)

**Risk level**: Low (staging only, reversible)

---

#### **`Bash(git commit:*)`**

**What it allows**: Create commits to local repository

**Implications**:
- ✅ Save work locally
- ✅ Create commit history
- ⚠️ Creates permanent commit (though amendable)
- ❌ Does NOT push to remote

**Risk level**: Low-Medium (local only, reversible)

**Safety note**: Commits can be amended or reset if needed

---

#### **`Bash(git push:*)`**

**What it allows**: Push commits to remote repository

**Implications**:
- ✅ Share work with team/remote
- ⚠️ Makes commits visible to others
- ⚠️ Can push to any branch
- 🛡️ Force push is blocked by git protocol in template

**Risk level**: Medium (affects remote repository)

**Safety note**: Review commits before pushing to shared branches

---

#### **`Bash(git log:*)`, `Bash(git diff:*)`, `Bash(git branch:*)`**

**What they allow**: View git history, changes, and branches

**Implications**:
- ✅ All read-only operations
- ✅ Help Claude understand project state

**Risk level**: Very Low

---

#### **`Bash(git checkout:*)`**

**What it allows**: Switch branches or restore files

**Implications**:
- ✅ Switch between branches
- ✅ Restore files from git
- ⚠️ Can discard uncommitted changes
- ⚠️ Can create new branches

**Risk level**: Medium (can discard work)

**Safety note**: Ensure changes are committed before branch switches

---

### 📦 Package Management

#### **`Bash(npm:*)`, `Bash(yarn:*)`, `Bash(pnpm:*)`**

**What they allow**: All npm/yarn/pnpm commands

**Implications**:
- ✅ Install dependencies (`npm install`)
- ✅ Run build scripts (`npm run build`)
- ✅ Run tests (`npm test`)
- ⚠️ Can install any package (including malicious ones)
- ⚠️ Can run any npm script defined in package.json
- ⚠️ Post-install scripts execute automatically

**Use cases**:
- Installing project dependencies
- Running build processes
- Executing test suites
- Running dev servers

**Risk level**: Medium-High (executes code, network access)

**Safety notes**:
- Review package.json before `npm install`
- Be cautious with unfamiliar packages
- Check package-lock.json changes

---

### 🐍 Python Operations

#### **`Bash(python:*)`, `Bash(pytest:*)`**

**What they allow**: Execute Python scripts and tests

**Implications**:
- ✅ Run Python scripts
- ✅ Execute test suites
- ⚠️ Can execute any Python code
- ⚠️ Has access to filesystem and network

**Use cases**:
- Running Python applications
- Executing test suites
- Running data processing scripts

**Risk level**: High (code execution)

**Safety note**: Review Python scripts before execution

---

#### **`Bash(node:*)`**

**What it allows**: Execute Node.js scripts

**Implications**:
- ✅ Run JavaScript/Node applications
- ⚠️ Can execute any Node.js code
- ⚠️ Full filesystem and network access

**Risk level**: High (code execution)

---

### 🐳 Docker Operations

#### **`Bash(docker:*)`**

**What it allows**: All Docker commands (build, run, compose, ps, logs, etc.)

**Implications**:
- ✅ Build container images
- ✅ Run containers
- ✅ Manage Docker Compose stacks
- ⚠️ Can run containers with elevated privileges
- ⚠️ Can bind mount host filesystem
- ⚠️ Network access for containers

**Use cases**:
- Building application images
- Running containerized services
- Managing development environments
- Viewing container logs

**Risk level**: High (system-level operations)

**Safety notes**:
- Review Dockerfiles before building
- Check docker-compose.yml configurations
- Be cautious with volume mounts and network settings

---

### 🖥️ File System Operations

#### **`Bash(ls:*)`, `Bash(pwd:*)`**

**What they allow**: List directories and show current path

**Implications**:
- ✅ Navigate and explore filesystem
- ✅ Read-only operations

**Risk level**: Very Low

---

#### **`Bash(echo:*)`, `Bash(cat:*)`**

**What they allow**: Display text and file contents

**Implications**:
- ✅ View file contents
- ✅ Simple text output
- ⚠️ `echo` can redirect to files (e.g., `echo "text" > file`)

**Risk level**: Low (mostly read-only)

---

#### **`Bash(mkdir:*)`**

**What it allows**: Create directories

**Implications**:
- ✅ Create project structure
- ⚠️ Can create directories anywhere

**Risk level**: Low (directory creation only)

---

#### **`Bash(cp:*)`, `Bash(mv:*)`**

**What they allow**: Copy and move files

**Implications**:
- ✅ Organize files and directories
- ⚠️ Can overwrite existing files
- ⚠️ `mv` can effectively delete by moving to obscure locations

**Risk level**: Medium (can overwrite/relocate files)

**Safety note**: Review file operations before committing

---

#### **`Bash(chmod:*)`**

**What it allows**: Change file permissions

**Implications**:
- ✅ Make scripts executable
- ✅ Fix permission issues
- ⚠️ Can remove read/write permissions
- ⚠️ Can make sensitive files executable

**Risk level**: Medium (affects file access)

---

### 🐙 GitHub CLI

#### **`Bash(gh:*)`**

**What it allows**: All GitHub CLI operations

**Implications**:
- ✅ Create pull requests
- ✅ Manage issues
- ✅ View repository information
- ✅ Create releases
- ⚠️ Can create public issues/PRs
- ⚠️ Can modify repository settings (if permissions allow)

**Use cases**:
- Creating PRs automatically
- Managing issues
- Viewing PR status

**Risk level**: Medium (affects GitHub repository)

**Safety note**: Review PR/issue content before creation

---

### 🤖 Agent Operations

#### **`Task(*)`**

**What it allows**: Use all Claude Code agent types

**Implications**:
- ✅ Launch specialized agents (Explore, general-purpose, etc.)
- ✅ Agents can use tools according to their own permissions
- ⚠️ Agents inherit the same permission settings

**Risk level**: Varies by agent and tools used

---

#### **`SlashCommand(*)`**

**What it allows**: Execute all custom slash commands

**Implications**:
- ✅ Run project-specific commands
- ✅ Execute custom workflows
- ⚠️ Commands can do anything defined in their scripts

**Risk level**: Depends on slash command definitions

---

## Security & Safety Measures

### 🛡️ Explicit Denials

#### **`Bash(rm -rf /:*)`**

**Purpose**: Block catastrophic filesystem deletion

**What it blocks**:
- `rm -rf /` (delete entire filesystem)
- `rm -rf /*` (delete root contents)

**Why it's important**: Prevents accidental or malicious full system deletion

**Note**: Does NOT block other `rm` commands (e.g., `rm -rf ./node_modules` is allowed)

---

### 🔒 Git Protocol Safety

The template's git workflow includes safety measures:

- **Force push protection**: `git push --force` requires approval (via git protocol)
- **Commit review**: Commits should be reviewed before pushing
- **Branch protection**: Configure branch protection rules on GitHub for additional safety

---

### ⚠️ What's NOT Protected

These operations are **NOT automatically blocked** and require vigilance:

1. **Installing packages**: Claude can `npm install` any package
2. **Executing scripts**: Can run any script in your repo
3. **File deletion**: `rm` commands (except root deletion) are allowed
4. **API calls**: Scripts can make network requests
5. **Environment access**: Scripts can read environment variables

---

## Customization Guide

### Adding New Auto-Approvals

**Example**: Adding Ruby/Rails commands

```json
{
  "permissions": {
    "allow": [
      // ... existing permissions ...
      "Bash(ruby:*)",
      "Bash(rails:*)",
      "Bash(bundle:*)",
      "Bash(rake:*)"
    ]
  }
}
```

### Removing Auto-Approvals

**Example**: Require approval for Docker operations

```json
{
  "permissions": {
    "allow": [
      // Remove or comment out:
      // "Bash(docker:*)"
    ]
  }
}
```

Now Claude will ask before running Docker commands.

### Adding More Denials

**Example**: Block all `rm` commands (not just root deletion)

```json
{
  "permissions": {
    "deny": [
      "Bash(rm -rf /:*)",
      "Bash(rm:*)"  // Block ALL rm commands
    ]
  }
}
```

### Making Specific Operations Require Approval

**Example**: Require approval for git push

```json
{
  "permissions": {
    "allow": [
      "Bash(git fetch:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      // Remove: "Bash(git push:*)"
      // This line no longer appears, so it will ask
    ],
    "ask": [
      "Bash(git push:*)"  // Explicitly mark as "ask"
    ]
  }
}
```

### Conservative Configuration Example

For more cautious workflows:

```json
{
  "permissions": {
    "allow": [
      // Read-only operations
      "Read(*)",
      "Glob(*)",
      "Grep(*)",
      "Bash(git status:*)",
      "Bash(git log:*)",
      "Bash(git diff:*)",
      "Bash(ls:*)",
      "Bash(pwd:*)",
      "Bash(cat:*)",

      // Agents (read-only usage)
      "Task(*)"
    ],
    "deny": [
      "Bash(rm:*)",
      "Bash(git push:*)"
    ]
  }
}
```

This configuration:
- ✅ Allows exploration and reading
- ❌ Requires approval for writes, edits, commits
- ❌ Blocks deletion and pushing

---

## Common Scenarios

### Scenario 1: Working on Open Source Project (Public Repo)

**Recommendation**: Use conservative settings

```json
{
  "permissions": {
    "allow": [
      "Read(*)", "Glob(*)", "Grep(*)",
      "Bash(git status:*)", "Bash(git diff:*)",
      "Bash(npm:*)"
    ],
    "ask": [
      "Write(*)", "Edit(*)",
      "Bash(git commit:*)", "Bash(git push:*)"
    ]
  }
}
```

**Rationale**: You want to review changes before they become public

---

### Scenario 2: Personal Side Project

**Recommendation**: Use aggressive settings (template default)

```json
{
  "permissions": {
    "allow": [
      // All template defaults
    ]
  }
}
```

**Rationale**: Speed and efficiency are priorities; you trust Claude in your personal repo

---

### Scenario 3: Learning/Tutorial Project

**Recommendation**: Aggressive settings with Docker/deployment restrictions

```json
{
  "permissions": {
    "allow": [
      "Read(*)", "Write(*)", "Edit(*)", "Glob(*)", "Grep(*)",
      "Bash(git:*)",
      "Bash(npm:*)", "Bash(python:*)",
      // Remove Docker to prevent accidental container operations
    ]
  }
}
```

---

### Scenario 4: Production/Critical Repository

**Recommendation**: Minimal auto-approvals

```json
{
  "permissions": {
    "allow": [
      "Read(*)", "Glob(*)", "Grep(*)",
      "Bash(git status:*)", "Bash(git log:*)"
    ],
    "ask": [
      "*"  // Require approval for everything else
    ]
  }
}
```

**Rationale**: Maximum safety; review every operation

---

## Troubleshooting

### "Permission denied" errors

**Problem**: Claude tries to run a command but gets permission denied

**Solution**:
1. Check if the command is in `deny` list (blocked intentionally)
2. Add the command pattern to `allow` list if you trust it
3. Review the command - Claude will ask for approval if not in allow list

---

### Commands keep asking for approval

**Problem**: Commands you want auto-approved keep prompting

**Solution**:
1. Check the command pattern syntax in `settings.local.json`
2. Ensure you're using `:*` for prefix matching (e.g., `Bash(npm:*)` not `Bash(npm *)`)
3. Restart Claude Code after changing settings

---

### Settings not taking effect

**Problem**: Changed settings but behavior hasn't changed

**Solution**:
1. Ensure `.claude/settings.local.json` is in your **project root**
2. Check JSON syntax (use a JSON validator)
3. Restart Claude Code session
4. Use `/clear` and start fresh session

---

### Too many auto-approvals, want more control

**Problem**: Claude is doing too much without asking

**Solution**:
1. Switch to conservative configuration (see examples above)
2. Remove specific permissions from `allow` list
3. Add `"ask": ["*"]` to default to asking for everything not explicitly allowed

---

### Want different settings per project

**Problem**: Need aggressive settings in one project, conservative in another

**Solution**:
- Each project has its own `.claude/settings.local.json`
- Customize per project after copying from template
- Create multiple template variants for different project types

---

## Best Practices

### ✅ Do's

1. **Review before committing**: Always review git changes before pushing
2. **Start conservative**: Begin with fewer auto-approvals, add more as you gain confidence
3. **Project-specific settings**: Customize settings for each project's needs
4. **Document changes**: Note why you modified settings in comments (JSON doesn't support comments, so use a separate NOTES.md)
5. **Use version control**: Commit your settings.local.json so team members have the same configuration

### ❌ Don'ts

1. **Don't use aggressive settings in production repos** without careful consideration
2. **Don't ignore denied commands**: If Claude tries something that gets denied, understand why
3. **Don't disable all safety measures**: Keep at least the root deletion denial
4. **Don't share settings blindly**: What works for your side project may not work for client work
5. **Don't forget to review**: Auto-approval doesn't mean no review

---

## Additional Resources

- **Claude Code Documentation**: [https://docs.claude.com/](https://docs.claude.com/)
- **Template Repository**: [https://github.com/dnorth123/claude-code-project-starter](https://github.com/dnorth123/claude-code-project-starter)
- **Settings Schema**: `.claude/settings.json` (for available options)

---

## Version History

- **v1.0** (2025-11-06): Initial settings guide with comprehensive permission explanations

---

**Questions or suggestions?** Open an issue on the [template repository](https://github.com/dnorth123/claude-code-project-starter/issues)
