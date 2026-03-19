---
name: phase-debug
description: Use when something is broken and the root cause is not yet proven. Focuses on reproducing the issue, tracing state and data flow, forming a concrete hypothesis, verifying it with evidence, and only then fixing it.
---

# phase-debug

Use this skill for root-cause debugging.

## Goal

Reach a verified explanation before editing code.

## Workflow

1. Reproduce the problem.
2. Narrow the failing surface.
3. Trace state and data flow.
4. Form the most likely hypothesis.
5. Verify it with direct evidence.
6. Patch the cause, not just the symptom.
7. Re-test.
8. Add regression protection.

## Outputs

- reproduction path
- evidence trail
- root cause hypothesis
- verified fix
- regression prevention note

## Guardrails

- no fixes without investigation first
- stop and reassess after repeated failed fix attempts
- keep logs, screenshots, traces, or failing inputs when useful

