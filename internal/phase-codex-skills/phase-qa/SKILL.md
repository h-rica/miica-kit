---
name: phase-qa
description: Use after implementing user-facing work when you want end-to-end QA that tests changed flows, fixes real bugs, verifies the fixes, and adds regression coverage when the project supports it.
---

# phase-qa

Use this skill for end-to-end QA with fixes.

## Goal

Test the changed behavior, fix real bugs, verify the fixes, and leave regression protection behind.

## Workflow

1. Start with the flows affected by the diff.
2. Expand to nearby regressions.
3. Use a real browser for execution and evidence.
4. Patch discovered bugs in small, understandable changes.
5. Verify each fix.
6. Add regression coverage.

## Minimum coverage

- happy path
- bad input
- empty states
- repeated actions
- loading states
- responsive behavior when relevant
- auth boundaries when relevant

## Guardrails

- do not claim a fix without re-testing it
- regression tests are the default after a real bug fix

