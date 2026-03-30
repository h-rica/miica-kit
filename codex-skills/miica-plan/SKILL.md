---
name: miica-plan
description: Use when the user wants a plan, scoping help, technical sequencing, or a buildable implementation-plan artifact from settled requirements and architecture. Intelligently combines scope review, engineering review, design planning, and implementation-plan creation only when needed, then stops after the plan unless the same message explicitly asks to continue.
---

# miica-plan

Use this command to plan before coding.

`miica-se` posture is always on in this kit. Use it here to keep the plan direct, critical, and recommendation-driven.

## Goal

Produce the smallest defensible plan and decide which planning lenses matter for this task, including when the right output is a buildable implementation-plan artifact.

## Best-available effort

Do not stop at the first acceptable outline.
Use the strongest relevant combination of repository context, project memory, codebase inspection, installed skills, MCP resources, browser evidence, and research when they materially improve the plan.

Push planning effort until one of these is true:
- the plan is strong enough to guide execution
- remaining uncertainty cannot be reduced with available tools
- additional analysis would not materially change the recommendation

## Internal decision tree

1. Restate the real problem.
2. Decide whether scope pressure-testing is needed.
   - Use it for product-facing asks, vague asks, or suspiciously narrow requests.
3. Decide whether engineering review is needed.
   - Use it for non-trivial changes, risky refactors, cross-layer work, data-flow changes, or unclear failure modes.
4. Decide whether design planning is needed.
   - Use it when users will directly see or feel the result.
5. Decide whether reference-driven UI extraction is needed.
   - Use it when the user provides inspiration sites, screenshots, recordings, or Figma links and the design intent would otherwise stay ambiguous.
6. Decide whether implementation-plan creation is needed.
   - Use it when the user has settled requirements and architecture and wants an execution-ready plan artifact rather than only a high-level recommendation.
   - Verify only the current standards that materially affect the implementation choices.
   - Phase by working software, map the files that will change, and write atomic TDD-driven tasks with self-contained context and no placeholders.
   - Save the implementation plan under `docs/plans/YYYY-MM-DD-<feature-name>.md` when the request is document-producing.
7. Skip planning theater for small local changes.
8. Make a recommendation and defend it.

## Expected output

- problem reading
- chosen scope
- architecture and data-flow notes when relevant
- design notes when relevant
- implementation plan artifact and path when relevant
- UI reference guide or extraction brief when relevant
- step sequence
- risks
- success criteria
- explicit deferrals

## Exit condition

Stop after the plan or plan artifact unless the same user message explicitly asks for plan plus execution.
