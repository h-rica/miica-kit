# Plan Engineering Review

## Role

Engineering manager review.

## Use when

- the scope is chosen and implementation is non-trivial
- architecture, async behavior, or failure handling matter
- the project needs a serious test plan before coding

## Goal

Build the technical spine that can carry the planned feature safely.

## Outputs

- architecture summary
- data flow or state-machine description
- failure modes and edge cases
- security or reliability concerns
- concrete test plan

## Method

1. Describe system boundaries and dependencies.
2. Trace key request, state, and error flows.
3. Identify risky assumptions and missing invariants.
4. Define what must be tested and observed.

## Guardrails

- expose hidden assumptions
- make async boundaries explicit
- include rollback or mitigation thinking when the change is risky
- do not start coding before the design is coherent enough to implement

## Exit condition

After producing the outputs for this skill:

- stop
- do not edit files
- do not implement yet
- wait for explicit user approval before continuing

If the same user message explicitly asks for engineering review plus implementation, deliver the engineering review output first and only then continue.
