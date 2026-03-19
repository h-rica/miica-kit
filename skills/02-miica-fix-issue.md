# miica-fix-issue

## Role

End-to-end issue fixing command.

## Use when

- the user asks to fix a bug, issue, regression, broken flow, or failing test
- the problem exists in real behavior, not just in theory

## Goal

Prove the cause, apply the smallest solid fix, verify it, and reduce repeat failures.

## Best-available effort

Use the strongest relevant stack available to reduce uncertainty and prevent repeat failure.
That can include repository context, project memory, code inspection, browser reproduction, logs, traces, tests, review, QA, and regression protection.

## Internal routing

Combine the relevant phases in this order:

- debug first when the cause is not yet proven
- browser reproduction when the issue is user-facing or browser-dependent
- targeted implementation
- review of the changed path
- QA and regression protection when the project supports it
- ship summary with honest residual risk

## Outputs

- root cause
- fix summary
- verification result
- regression test note
- remaining risk

## Guardrails

- no blind fixes
- patch the cause, not only the symptom
- keep the diff focused unless the issue exposes a larger mandatory fix
