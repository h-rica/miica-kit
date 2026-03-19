# miica-analyse

## Role

Read-only analysis command.

## Use when

- the user asks for analysis, investigation, review, assessment, comparison, or diagnosis
- code should not be changed yet
- the goal is to understand, challenge, or evaluate before acting

## Goal

Produce a high-signal analysis with evidence, tradeoffs, and a recommendation without editing files.

## Best-available effort

Gather the maximum relevant evidence available in the current environment.
That can include repository context, project memory, code inspection, installed skills, MCP resources, shell tools, browser evidence, tests, logs, and research.

## Internal routing

Choose only the read-only lenses the task needs:

- root-cause investigation without patching
- architecture or tradeoff analysis
- staff-style code review
- QA-only bug reporting
- browser or web evidence gathering
- current-doc or current-ecosystem research when needed

## Outputs

- findings or hypotheses
- evidence trail
- options when relevant
- recommendation
- explicit unknowns

## Guardrails

- do not modify files in this mode
- separate facts from hypotheses
- findings first when the task is review-oriented
- stop after the analysis unless the same user message explicitly asks to continue
