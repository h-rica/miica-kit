---
name: phase-ship
description: Use when implementation, review, and QA are mostly complete and a branch needs final validation before commit, PR, or merge. Runs the relevant checks, audits coverage against the diff, and summarizes remaining risk honestly.
---

# phase-ship

Use this skill for the final validation gate.

## Goal

Take a ready branch through the finish line.

## Workflow

1. Run the relevant checks for the project.
2. Review what changed and whether tests cover it.
3. Fill the highest-value coverage gaps if needed.
4. Summarize residual risk honestly.
5. Prepare the branch for commit, PR, or release.

## Guardrails

- green checks alone are not enough
- coverage should be judged against the diff, not only the global percentage
- if the project has no test framework and shipping safely requires one, bootstrap it or flag that gap explicitly

