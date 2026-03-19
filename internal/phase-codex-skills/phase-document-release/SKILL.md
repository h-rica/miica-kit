---
name: phase-document-release
description: Use after meaningful changes when README, architecture docs, testing docs, workflow docs, or release notes may be stale. Cross-checks documentation against the diff and updates what changed.
---

# phase-document-release

Use this skill to sync docs with shipped reality.

## Goal

Bring documentation back into alignment with the actual change set.

## Workflow

1. Compare the diff against user-facing and contributor-facing docs.
2. Update command lists, file trees, workflows, examples, and notes that changed.
3. Leave explicit notes where documentation changes are subjective or uncertain.

## Guardrails

- do not leave stale docs after behavior changes
- check README, architecture docs, testing docs, workflow docs, and release notes as applicable
- prefer concise, accurate docs over decorative prose

