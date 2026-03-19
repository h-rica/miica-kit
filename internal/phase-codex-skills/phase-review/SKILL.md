---
name: phase-review
description: Use when a branch, diff, or change set needs a staff-engineer review before QA or merge. Prioritizes production bugs, regressions, unhandled states, race conditions, missing validation, and missing tests. Findings first, summary second.
---

# phase-review

Use this skill for production-risk review.

## Goal

Find bugs and completeness gaps that can survive CI but fail in production.

## Review priorities

- regressions
- race conditions
- unhandled states
- broken data flows
- missing validation
- missing or weak tests
- shortcuts where the complete version is still cheap enough to do now

## Output format

- findings first
- ordered by severity
- exact file references
- summary second

## Guardrails

- focus on behavioral risk, not style theater
- trace new states, enums, and config through all handlers and allowlists

## Exit condition

After producing the review output:

- stop
- do not apply fixes in this skill
- wait for explicit user approval before continuing

If the same user message explicitly asks for review plus fixes, deliver the review findings first and only then continue.

