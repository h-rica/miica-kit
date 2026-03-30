---
name: miica-execute-plan
description: Use when the user wants to execute an existing development plan step-by-step. Maintains backlog, in-progress, and completed plan files and only mutates them when implementation actually happens.
---

# miica-execute-plan

Use this command to implement from an existing tracked development plan.

`miica-se` posture is always on in this kit. Keep the plan state truthful and the implementation scoped to the in-progress step.

## Goal

Execute the next or current in-progress step of a tracked plan without losing plan state or mutating plan files speculatively.

## Plan files

When this workflow is active, keep these plan files together in the same plan directory:

- `plan-backlog.md`
- `plan-in-progress.md`
- `plan-completed.md`

If the user points to a rules file or plan directory, use that directory for all three files.

## Core rules

- `miica-plan` owns plan creation and high-level planning. Use this command only when a tracked plan already exists and the user wants to follow it.
- Do not update plan files if no implementation was performed, except when the user explicitly asks to add a note to the in-progress step.
- Only move a backlog step to in-progress while implementing that same step in the same response.
- Never move a backlog step directly to completed.
- Keep `plan-in-progress.md` as a real mirror of the in-progress implementation, not as a placeholder for future work.
- If work is blocked by missing information or missing files, explain the blocker and do not mutate the plan files.

## Execution flow

### When the user says `do next step`

1. Read the current plan files.
2. If an in-progress step exists:
   - finalize it and move it to completed with `status: done`
   - if a next backlog step exists, activate the top backlog step and implement it in the same response
   - if there is no remaining backlog step, do not leave a stale in-progress step behind; report that everything is complete
3. If no in-progress step exists:
   - activate the top backlog step and implement it immediately in the same response
4. If there is no backlog step and no in-progress step, tell the user there are no more plan items to execute.

### When the user says `continue to work on active step`

1. Read `plan-in-progress.md`.
2. Implement against the in-progress step.
3. Append sub-step notes or implementation considerations only when they materially help track the work.

### When the user reports a bug or addition on the in-progress step

1. Fix or extend the in-progress step.
2. Add a sub-step entry to the in-progress step describing:
   - the user ask
   - what was done
   - any implementation considerations that matter

### When the user asks a question about the in-progress step

Answer the question and add the relevant note to the in-progress step only when that note helps preserve implementation context.

## Plan file formatting rules

- Backlog steps use `## Step - short title for the work` with `status: not_started`.
- In-progress contains exactly one `status: active` step while implementation is in progress.
- Completed contains only steps that were previously active, listed oldest to newest.
- Preserve original step content when moving from backlog to in-progress.
- When moving from in-progress to completed, keep or consolidate content according to what preserves the needed downstream context.
- If a step primarily defines or specifies something, keep it verbatim in completed so later steps can reference it safely.

## Guardrails

- create `plan-in-progress.md` only when implementation begins
- do not create or keep an empty in-progress step during planning-only phases
- if the user asks to update the plan rather than implement it, route back to `miica-plan`
