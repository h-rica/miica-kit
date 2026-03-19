---
name: phase-qa-only
description: Use when you want the same QA methodology as full QA but without code changes. Produces a reproducible bug report with severity, repro steps, and browser evidence only.
---

# phase-qa-only

Use this skill for report-only QA.

## Goal

Apply the same QA methodology as full QA, but report only.

## Outputs

- reproducible bug report
- severity assessment
- repro steps
- screenshots, traces, console notes, or network evidence

## Guardrails

- no code changes
- report only what was actually tested and observed

## Exit condition

After producing the QA report:

- stop
- do not apply fixes in this skill
- wait for explicit user approval before continuing

If the same user message explicitly asks for QA-only plus fixes, deliver the QA report first and only then continue.

