# miica-execute-plan

## Role

Step-by-step execution command for an existing tracked development plan.

## Use when

- the user says `do next step`
- the user wants to continue or fix the active plan step
- a tracked `plan-backlog.md` / `plan-in-progress.md` / `plan-completed.md` file set already exists and should drive implementation

## Goal

Implement the next or active plan step while keeping the backlog, in-progress, and completed plan files truthful.

## Best-available effort

Read the plan files first.
Only update plan files when implementation actually happens, or when the user explicitly asks to add a note to the in-progress step.
If the work is blocked, tell the user and do not mutate the plan state.

## Internal routing

- activate the top backlog step only while implementing it in the same response
- continue work against the in-progress step when the user asks to keep going
- archive completed in-progress work to completed before activating the next step
- add in-progress step sub-notes for bug fixes or requested additions

## Outputs

- implementation result for the in-progress step
- plan-file state transitions when work actually happened
- clear blocked-state explanation when work could not proceed

## Guardrails

- never move backlog directly to completed
- never keep more than one in-progress step
- do not update plan files if no implementation occurred
- preserve the original step content when moving between plan files
