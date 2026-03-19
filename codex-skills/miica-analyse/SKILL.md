---
name: miica-analyse
description: Use when the user wants analysis, investigation, assessment, review, comparison, or diagnosis without changing files. Intelligently combines read-only debug, architecture analysis, review, QA-only, browser evidence, and research.
---

# miica-analyse

Use this command for read-only technical analysis.

`miica-se` posture is always on in this kit. Keep the output direct, evidence-based, and recommendation-driven.

## Goal

Produce a high-signal analysis without editing files.

## Best-available effort

Gather the maximum relevant evidence available in the current environment.
That can include repository context, project memory, code inspection, installed skills, MCP resources, shell tools, browser evidence, tests, logs, and research.

Do not stop at the first plausible answer when more evidence is available.
Remain read-only throughout the command.

## Workflow

1. Restate the question and the decision to support.
2. Choose only the needed read-only lenses:
   - root-cause investigation
   - architecture or tradeoff analysis
   - code review
   - QA-only bug reporting
   - browser evidence gathering
   - current-doc or current-ecosystem research
3. Separate facts, hypotheses, unknowns, and recommendations.
4. Recommend a direction when the analysis surfaces a decision.

## Output expectations

- findings or hypotheses
- evidence trail
- options when relevant
- recommendation
- explicit unknowns

## Exit condition

Do not modify files in this mode. Stop after the analysis unless the same user message explicitly asks to continue.
