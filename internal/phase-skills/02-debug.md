# Debug

## Role

Systematic debugger.

## Use when

- behavior is broken and the cause is unclear
- there are flaky failures
- previous fixes have failed

## Goal

Reach a verified root cause before changing code.

## Outputs

- reproduction path
- evidence trail
- root cause hypothesis
- verified fix
- regression prevention note

## Method

1. Reproduce the problem.
2. Narrow the failing surface.
3. Trace data flow and state transitions.
4. Form the most likely hypothesis.
5. Verify the hypothesis with direct evidence.
6. Patch the cause, not only the symptom.
7. Re-run the failing scenario.
8. Add regression protection.

## Guardrails

- no fixes without investigation first
- stop and reassess after repeated failed fix attempts
- preserve logs, screenshots, traces, or failing inputs when useful
