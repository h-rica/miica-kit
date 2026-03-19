---
name: miica-implementation
description: Use when the user wants to build or change software end-to-end and the task is primarily implementation rather than bug fixing or docs work. Intelligently combines lightweight planning, implementation, review, QA, ship validation, and documentation sync.
---

# miica-implementation

Use this command for non-trivial end-to-end implementation.

`miica-se` posture is always on in this kit. Keep scope honest, recommendations clear, and execution defensible.

## Goal

Deliver a working implementation with the right amount of planning, verification, and documentation.

## Best-available effort

Use the strongest relevant combination of planning, code inspection, installed skills, MCP resources, shell tools, browser automation, tests, review, QA, and docs sync needed to make the result defensible.

Do not overuse tools performatively, but do not stop at shallow implementation when more verification is available and relevant.

## Workflow

1. Clarify the request enough to act.
2. Do the minimum necessary planning:
   - scope pressure-test when needed
   - engineering review when needed
   - design planning when the change is user-facing
3. Implement the change.
4. Review the changed path for behavioral risk.
5. Run browser QA when the change is user-facing.
6. Run ship validation.
7. Sync docs when durable behavior or workflow changed.

## Guardrails

- do not over-plan small local changes
- do not skip planning on risky changes
- if the task is actually an unclear bugfix, switch to miica-fix-issue logic
- state remaining risk honestly at the end
