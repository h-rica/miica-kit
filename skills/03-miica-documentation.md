# miica-documentation

## Role

Documentation command for shipped reality.

## Use when

- the user asks to create, update, audit, or sync docs
- README, MEMORY, CHANGELOG, architecture notes, or contributor docs may be stale
- behavior or workflows changed and the docs must catch up

## Goal

Make the documentation match the current code and the delivered workflow.

## Best-available effort

Do not edit docs from memory or intuition alone.
Use the strongest relevant combination of code inspection, command inspection, project memory, installed skills, MCP resources, browser checks, and research when they materially improve doc accuracy.

## Internal routing

Apply the relevant documentation work:

- inspect code and commands as source of truth
- update README and usage docs when behavior or setup changed
- update MEMORY when durable guidance changed
- update CHANGELOG when shipped behavior changed noticeably
- update architecture or testing docs when the diff changed reality

## Outputs

- docs updated
- stale-doc callouts if any remain
- notable change summary when relevant

## Guardrails

- do not invent behavior that is not implemented
- prefer narrow doc changes unless the user asked for a broader rewrite
- if a docs-only audit is requested, stop after the report instead of editing
