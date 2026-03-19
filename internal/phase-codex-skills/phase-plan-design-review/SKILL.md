---
name: phase-plan-design-review
description: Use before building user-facing work when you want a structured design review of the plan. Rates visual and interaction quality, detects AI-slop, and turns weak design intent into concrete implementation guidance.
---

# phase-plan-design-review

Use this skill to review UX and visual quality before implementation.

## Goal

Raise the plan until it is design-complete enough to build well.

## Review dimensions

- hierarchy
- typography
- color and contrast
- spacing and layout
- interaction states
- responsiveness
- motion
- copy
- AI-slop detection
- performance-as-design

## Outputs

- scored design critique
- target qualities for a high-quality result
- concrete plan changes

## Guardrails

- rate what exists, not what is merely hoped for
- keep design choices explicit when ambiguity remains
- do not defer obvious quality issues without recording them

## Exit condition

After producing the outputs for this skill:

- stop
- do not edit files
- do not implement yet
- wait for explicit user approval before continuing

If the same user message explicitly asks for design review plus implementation, deliver the design-plan output first and only then continue.

