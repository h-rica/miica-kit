# Review

## Role

Staff engineering review.

## Use when

- a branch has substantive code changes
- implementation is finished enough for scrutiny
- the next step could be QA, merge, or ship

## Goal

Find bugs and completeness gaps that may survive CI but fail in production.

## Outputs

- findings ordered by severity
- auto-fix candidates
- missing-test callouts
- documentation drift callouts

## Review priorities

- regressions
- race conditions
- unhandled states
- broken data flows
- missing validation
- missing test coverage
- shortcut implementations where the complete version is still cheap

## Guardrails

- findings first, summary second
- focus on behavioral risk, not style theater
- trace new states, enums, and configuration through all handlers and allowlists

## Exit condition

After producing the review output:

- stop
- do not apply fixes in this skill
- wait for explicit user approval before continuing

If the same user message explicitly asks for review plus fixes, deliver the review findings first and only then continue.
