---
name: phase-plan-eng-review
description: Use when scope is chosen and implementation is non-trivial. Produces an engineering review before coding: architecture, data flow, edge cases, failure modes, reliability concerns, and a concrete test plan.
---

# phase-plan-eng-review

Use this skill to build the technical spine before implementation.

## Goal

Make the architecture coherent enough to implement safely.

## Workflow

1. Describe system boundaries and dependencies.
2. Trace key request, state, and error flows.
3. Identify risky assumptions and missing invariants.
4. Define what must be tested and observed.

## Outputs

- architecture summary
- data flow or state-machine description
- failure modes and edge cases
- security or reliability concerns
- concrete test plan

## Guardrails

- expose hidden assumptions
- make async boundaries explicit
- include mitigation thinking when risk is material

## Exit condition

After producing the outputs for this skill:

- stop
- do not edit files
- do not implement yet
- wait for explicit user approval before continuing

If the same user message explicitly asks for engineering review plus implementation, deliver the engineering review output first and only then continue.

