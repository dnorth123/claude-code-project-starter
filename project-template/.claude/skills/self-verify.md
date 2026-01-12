---
name: self-verify
description: Verification-led development - give Claude ways to verify its own work
triggers: [verify, make sure it works, test this, check the implementation, verify implementation, self-check]
---

# Self-Verify Skill

## Purpose

Implement **verification-led development** - always give Claude a way to verify its own work. This reduces errors and builds confidence that implementations are correct.

> "Humans and AI alike make minor errors; therefore, you should always give Claude a way to verify its own work. For code, this means generating and running tests; for UI, it involves using tools to navigate and verify visuals."

## Core Principle

**Never trust implementation alone.** Every significant change should have a verification step.

## Verification Methods by Type

### Code Changes

| Change Type | Verification Method |
|-------------|---------------------|
| New function | Write and run unit test |
| API endpoint | `curl` request or integration test |
| Bug fix | Reproduce bug first, then verify fix |
| Refactor | Run existing tests, compare output |
| Database change | Query to verify data state |

### UI Changes

| Change Type | Verification Method |
|-------------|---------------------|
| Component | Visual inspection, screenshot comparison |
| Layout | Browser resize, responsive check |
| Form | Submit test data, verify handling |
| Navigation | Click through flows |

### Configuration Changes

| Change Type | Verification Method |
|-------------|---------------------|
| Environment variable | Echo/log value |
| Build config | Run build, check output |
| Deploy config | Deploy to staging first |

## Workflow

### Step 1: Understand What to Verify

Before implementing, identify:
- What is the expected behavior?
- How will we know it works?
- What could go wrong?

### Step 2: Set Up Verification First (TDD Optional)

```
Option A: Test First (TDD)
1. Write failing test
2. Implement
3. Test passes

Option B: Implement Then Verify
1. Implement
2. Write test
3. Run test
4. Iterate if needed
```

### Step 3: Run Verification

Execute the verification:

```bash
# Unit tests
npm test -- --grep "function name"
pytest -k "test_function_name"

# API verification
curl -X POST http://localhost:3000/api/endpoint -d '{"test": "data"}'

# Integration tests
npm run test:integration

# E2E tests
npm run test:e2e
```

### Step 4: Document Results

Record what was verified:
- Test output
- API response
- Visual confirmation
- Performance metrics

## Output Format

When verifying, provide structured results:

```markdown
## Verification Report

### Implementation
**Feature**: [What was implemented]
**Files Changed**: [List of files]

### Verification Steps

#### Test 1: [Test Name]
**Method**: [How verified]
**Expected**: [What should happen]
**Actual**: [What happened]
**Status**: ✅ Pass / ❌ Fail

#### Test 2: [Test Name]
**Method**: [How verified]
**Expected**: [What should happen]
**Actual**: [What happened]
**Status**: ✅ Pass / ❌ Fail

### Summary
- Total Checks: [N]
- Passed: [N]
- Failed: [N]

### Confidence Level
[High/Medium/Low] - [Reasoning]

### Remaining Risks
- [Any untested scenarios]
```

## Example

**Input**: "Add password strength validation and verify it works"

**Implementation**:
```typescript
// src/utils/password.ts
export function checkPasswordStrength(password: string): {
  score: number;
  feedback: string[];
} {
  const feedback: string[] = [];
  let score = 0;

  if (password.length >= 8) score++;
  else feedback.push('At least 8 characters required');

  if (/[A-Z]/.test(password)) score++;
  else feedback.push('Add uppercase letter');

  if (/[a-z]/.test(password)) score++;
  else feedback.push('Add lowercase letter');

  if (/[0-9]/.test(password)) score++;
  else feedback.push('Add number');

  if (/[^A-Za-z0-9]/.test(password)) score++;
  else feedback.push('Add special character');

  return { score, feedback };
}
```

**Verification**:
```markdown
## Verification Report

### Implementation
**Feature**: Password strength validation
**Files Changed**: src/utils/password.ts, src/utils/password.test.ts

### Verification Steps

#### Test 1: Weak Password
**Method**: Unit test
**Expected**: Score 1, multiple feedback items
**Actual**: Score 1, feedback: ["Add uppercase...", "Add number...", "Add special..."]
**Status**: ✅ Pass

#### Test 2: Strong Password
**Method**: Unit test
**Expected**: Score 5, no feedback
**Actual**: Score 5, feedback: []
**Status**: ✅ Pass

#### Test 3: Edge Cases
**Method**: Unit test (empty string, very long, unicode)
**Expected**: Handle gracefully
**Actual**: All handled correctly
**Status**: ✅ Pass

#### Test 4: Integration
**Method**: Manual test in registration form
**Expected**: Feedback displays, submit blocked if weak
**Actual**: Works as expected
**Status**: ✅ Pass

### Summary
- Total Checks: 4
- Passed: 4
- Failed: 0

### Confidence Level
High - All unit tests pass, manual integration verified
```

## Verification Checklist

Use this checklist for thorough verification:

```markdown
## Pre-Implementation
- [ ] Requirements understood
- [ ] Verification approach defined
- [ ] Test data prepared

## Implementation
- [ ] Code complete
- [ ] Error handling added
- [ ] Edge cases considered

## Verification
- [ ] Unit tests written and passing
- [ ] Integration tested
- [ ] Manual smoke test done
- [ ] Error cases verified
- [ ] Performance acceptable

## Documentation
- [ ] Code comments if needed
- [ ] API docs updated
- [ ] Test coverage recorded
```

## Common Verification Patterns

### API Endpoint Verification
```bash
# Test endpoint exists and returns correct structure
curl -s http://localhost:3000/api/users | jq '.users | length'

# Test error handling
curl -s -w "%{http_code}" http://localhost:3000/api/users/invalid

# Test with authentication
curl -H "Authorization: Bearer $TOKEN" http://localhost:3000/api/protected
```

### Database Change Verification
```sql
-- Before change: record state
SELECT COUNT(*) FROM users;

-- After migration: verify
SELECT COUNT(*) FROM users;
SELECT * FROM users LIMIT 5;
```

### Frontend Component Verification
```bash
# Build succeeds
npm run build

# Tests pass
npm test -- ComponentName

# Storybook renders (if applicable)
npm run storybook
```

## When to Skip Verification

Verification can be lighter for:
- Typo fixes in comments
- Documentation-only changes
- Formatting/linting changes

But even then, run the existing test suite.

---

*This skill ensures implementations are correct, not just complete.*
