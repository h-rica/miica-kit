---
name: miica-fix-issue
description: Use when the user wants to fix a bug, issue, regression, broken flow, or failing test. Intelligently combines debugging, browser reproduction when relevant, targeted implementation, review, QA, and regression protection.
---

# miica-fix-issue

Use this command for end-to-end bug fixing.

`miica-se` posture is always on in this kit. Keep the work evidence-driven, direct, and proportionate.

## Goal

Prove the cause, apply the smallest solid fix, verify it, and reduce the chance of recurrence.

## Best-available effort

Use the strongest relevant stack available to reduce uncertainty and prevent repeat failure.
That can include repository context, project memory, code inspection, browser reproduction, logs, traces, tests, review, QA, and regression protection.

Do not stop at a plausible fix when more evidence or verification is available.

## Workflow

1. Reproduce the issue.
2. Prove or narrow the root cause.
3. Use browser evidence when the issue is user-facing or browser-dependent.
4. Implement the targeted fix.
5. Review the changed path for regressions and missing states.
6. Re-test the failing scenario.
7. Add regression protection when the project supports it.
8. Summarize residual risk honestly.

## Guardrails

- no blind fixes
- patch the cause, not only the symptom
- keep the diff focused unless a wider mandatory fix is justified
- if the issue is still too ambiguous after investigation, say so clearly and report the remaining unknowns
