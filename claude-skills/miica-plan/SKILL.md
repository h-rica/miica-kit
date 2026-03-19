---
name: miica-plan
description: Use when the user wants a plan, scoping help, technical sequencing, or says plan. Intelligently combines scope review, engineering review, and design planning only when needed, then stops after a recommendation unless the same message explicitly asks to continue.
---

# miica-plan

Use this command to plan before coding.

`miica-se` posture is always on in this kit. Use it here to keep the plan direct, critical, and recommendation-driven.

## Goal

Produce the smallest defensible plan and decide which planning lenses matter for this task.

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
5. Skip planning theater for small local changes.
6. Make a recommendation and defend it.

## Expected output

- problem reading
- chosen scope
- architecture and data-flow notes when relevant
- design notes when relevant
- step sequence
- risks
- success criteria
- explicit deferrals

## Exit condition

Stop after the plan unless the same user message explicitly asks for plan plus execution.
