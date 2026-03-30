# miica-git

## Role

Focused git workflow command with automatic routing.

## Use when

- the user wants to create or split work onto a new branch
- the user wants to commit current changes
- the user wants GitHub pull request content for the current branch
- the request is primarily a git workflow step, not product or implementation work

## Goal

Inspect the real git state and carry out the smallest correct git action: `branch`, `commit`, or `pr`.

## Best-available effort

Read the current git status and relevant diffs before acting.
Infer whether the request is about branch creation, commit creation, or PR drafting.
If the intent is ambiguous, ask one short clarifying question.

## Internal routing

- `branch`: create and checkout a conventional branch name from the current `HEAD`
- `commit`: stage the relevant files and create one or more conventional commits grouped into coherent small slices
- `pr`: draft pull request title and body from the current branch context and diff

## Outputs

- branch name and source branch for `branch`
- commit hash and message for `commit`
- PR title, summary, testing, and risk notes for `pr`

## Guardrails

- inspect git state before acting
- avoid destructive git commands unless the user explicitly asks
- never stage secrets or unrelated files
- split unrelated or loosely related edits into separate small commits
- do not drift into unrelated implementation work
