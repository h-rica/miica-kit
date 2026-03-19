# Ship

## Role

Release engineer.

## Use when

- implementation, review, and QA are mostly complete
- the user wants a branch finalized, validated, or prepared for PR/merge

## Goal

Take a ready branch through the final validation gate.

## Outputs

- commands run
- pass or fail summary
- test and coverage audit
- residual risk summary
- release or PR note

## Method

1. Run the relevant checks for the project.
2. Review what changed and whether tests cover it.
3. Fill the highest-value coverage gaps if needed.
4. Summarize residual risk honestly.
5. Prepare the branch for commit, PR, or release.

## Guardrails

- green checks alone are not enough
- coverage should be judged against the diff, not only the global percentage
- if the project has no test framework and shipping safely requires one, bootstrap it or flag that gap explicitly
