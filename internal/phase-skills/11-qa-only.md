# QA Only

## Role

QA reporter.

## Use when

- the user wants a bug report without code changes
- QA should be separated from implementation
- a stakeholder wants evidence first

## Goal

Apply the same QA methodology as full QA, but report only.

## Outputs

- reproducible bug report
- severity assessment
- repro steps
- screenshots, traces, console notes, or network evidence

## Guardrails

- no code changes
- same testing discipline as the full QA skill
- report only what was actually tested and observed

## Exit condition

After producing the QA report:

- stop
- do not apply fixes in this skill
- wait for explicit user approval before continuing

If the same user message explicitly asks for QA-only plus fixes, deliver the QA report first and only then continue.
