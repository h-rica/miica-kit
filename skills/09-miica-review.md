# miica-review

## Role

Dedicated code-review command for recent changes.

## Use when

- the user wants a review of the current diff or recent commit
- the user wants a review focused on a file path or concern area such as security
- the task is findings-only and should not turn into implementation

## Goal

Surface real ship risks in changed code without drifting into style policing or speculative concerns.

## Best-available effort

Inspect the current diff, staged changes, and recent commit history as needed.
If the repository has a `REVIEW.md`, apply those project-specific concerns alongside core review criteria.
Use the strongest relevant evidence available, but stay read-only.

## Internal routing

- identify the review target: current diff, last commit, file path, or focus area
- review only changed code and the nearby context needed to judge it
- evaluate correctness, security, simplicity, and robustness
- group findings by severity and say explicitly when the review is clean

## Outputs

- must-fix findings
- should-fix findings
- observations
- explicit clean-review outcome when no real findings exist

## Guardrails

- findings only; do not silently fix code
- stay read-only unless the same user message explicitly asks to continue
- do not flag style nits, formatting, or comment preferences
- do not speculate without pointing to affected code
