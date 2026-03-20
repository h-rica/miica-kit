---
name: phase-ui-reference-guide
description: Use when user-facing work is defined mainly by inspiration sites, screenshots, recordings, or Figma links. Extracts a strict UI implementation guide with explicit evidence, confidence, coverage, and unknowns instead of relying on vague prompting.
---

# phase-ui-reference-guide

Use this skill to turn reference material into an implementation-grade UI guide.

## Goal

Produce a strict guide that helps later planning or implementation follow the references without pretending uncertainty does not exist.

## Workflow

1. Normalize the inputs:
   - target pages or flows
   - website URLs
   - Figma links
   - screenshots or recordings
   - existing design-system constraints
2. Search or fetch first if the right pages, docs, or product surfaces are still unclear.
3. Use browser tooling for live websites when layout, interaction, or motion depends on real behavior.
4. Use Figma tooling when available for node context, variables, screenshots, and assets.
5. Walk a fixed coverage matrix across:
   - desktop, tablet, mobile
   - visible default, hover, focus, active, disabled, loading, empty, and error states
   - interaction and motion triggers such as load, hover, click, scroll, overlay open, and route change
6. Record every extracted detail with:
   - source
   - evidence level: `observed`, `inferred`, or `unknown`
   - confidence
   - coverage status
7. Write the guide using the shipped template and schema:
   - `templates/UI_REFERENCE_GUIDE_TEMPLATE.md`
   - `templates/UI_REFERENCE_GUIDE_SCHEMA.json`

## Outputs

- `ui-guides/<slug>/README.md`
- `ui-guides/<slug>/guide.json`
- source inventory
- visual system notes
- component and state inventory
- motion and interactivity notes
- responsive behavior notes
- implementation constraints and explicit unknowns

## Guardrails

- do not claim complete extraction when a state or motion detail was not proven
- use browser evidence for real behavior and Figma evidence for structured design truth when available
- if Figma access is degraded, fall back to screenshots or browser inspection instead of abandoning the guide
- prefer behavior notes over invented CSS or timing values when internals are uncertain

## Exit condition

If the parent command is plan-only, stop after the guide or plan artifact.

If the parent command includes implementation, treat the guide as the design source of truth and continue.
