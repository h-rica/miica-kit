---
name: miica-documentation
description: Use when the user wants to create, update, audit, or sync documentation. Covers README, MEMORY, CHANGELOG, architecture docs, testing docs, and workflow docs, with code and current commands treated as source of truth.
---

# miica-documentation

Use this command to keep docs aligned with shipped reality.

`miica-se` posture is always on in this kit. Keep documentation concrete, minimal, and truthful.

## Goal

Make the documentation match the current code, commands, and workflow.

## Best-available effort

Do not edit docs from memory or intuition alone.
Use the strongest relevant combination of code inspection, command inspection, project memory, installed skills, MCP resources, browser checks, and research when they materially improve doc accuracy.

Treat the implemented system as the source of truth.

## Workflow

1. Inspect the code and commands that are the source of truth.
2. Decide which docs actually need updates.
3. Update README and usage docs when setup or behavior changed.
4. Update MEMORY when durable project guidance changed.
5. Update CHANGELOG when shipped behavior changed notably.
6. Update architecture or testing docs when the diff changed system reality.

## Guardrails

- do not invent behavior
- prefer narrow updates unless the user asks for a rewrite
- if the request is docs-audit-only, report drift and stop instead of editing
