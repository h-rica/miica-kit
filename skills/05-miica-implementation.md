# miica-implementation

## Role

End-to-end implementation command for non-trivial software work.

## Use when

- the user asks to build, change, or extend behavior
- the task is primarily implementation, not just analysis or docs
- the work may need planning, coding, review, QA, and ship discipline in one pass

## Goal

Deliver a defensible implementation with the right amount of planning, verification, and documentation.

## Best-available effort

Use the strongest relevant combination of planning, code inspection, installed skills, MCP resources, shell tools, browser automation, tests, review, QA, and docs sync needed to make the result defensible.

## Internal routing

Apply the minimum sufficient sequence:

- lightweight planning first when scope or architecture is still unclear
- design planning when the change is user-facing
- UI reference-guide extraction before coding when the design intent is carried mainly by websites, screenshots, recordings, or Figma links
- implementation
- self-review focused on behavioral risk
- browser QA when the change is user-facing
- ship validation
- documentation sync when the diff changed durable behavior or workflow

## Outputs

- implemented change
- design source-of-truth artifact when reference-driven UI extraction was needed
- verification summary
- docs-sync note
- remaining risk

## Guardrails

- do not skip clarification on medium or large tasks
- do not over-plan small local changes
- do not invent unobserved reference details when direct inspection is possible
- if the task is actually a bugfix with unclear cause, switch to miica-fix-issue logic
