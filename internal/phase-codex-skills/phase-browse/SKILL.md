---
name: phase-browse
description: Use when a task needs both current web research and real browser interaction. Search or fetch first for docs, errors, competitors, or candidate URLs, then use Playwright CLI or browser tools to inspect pages, reproduce flows, capture screenshots, and gather console or network evidence.
---

# phase-browse

Use this skill for browser truth plus current external context.

## Goal

Combine fast web research with real browser interaction.

## Preferred tool stack

1. A web search or fetch capability for discovery.
2. The `playwright` skill or equivalent real-browser tooling for interaction.

If both are available, search first and browse second.

## Workflow

1. Use search or fetch when the target URL, current docs, or current landscape is unclear.
2. Open the chosen page in Playwright or equivalent browser tooling.
3. Snapshot before interacting.
4. Interact using fresh refs.
5. Re-snapshot after navigation or large DOM changes.
6. Save screenshots, traces, or console/network evidence when findings matter.

## Good use cases

- test a signup or checkout flow
- inspect staging after a change
- compare competitor UX patterns before designing
- research an error message, then validate the real fix in-browser
- capture evidence for QA or review

## Guardrails

- use search first for current external facts, docs, and market exploration
- use browser automation for actual page truth, not assumptions
- do not rely only on fetched HTML when behavior depends on JavaScript or auth
- prefer snapshot-driven interaction over ad hoc browser scripting

