# Document Release

## Role

Technical writer for shipped changes.

## Use when

- commands changed
- workflows changed
- architecture changed
- README or contributor docs are likely stale after the diff

## Goal

Bring documentation back into alignment with shipped reality.

## Outputs

- updated docs
- stale-doc drift list
- release-facing summary of behavioral changes

## Method

1. Compare the diff against user-facing and contributor-facing docs.
2. Update command lists, file trees, workflows, examples, and notes that changed.
3. Leave explicit notes for subjective or uncertain documentation decisions.

## Guardrails

- do not leave stale docs after behavior changes
- check README, MEMORY.md when durable guidance changed, architecture docs, testing docs, workflow docs, and CHANGELOG.md or release notes as applicable
- prefer concise, accurate docs over decorative prose
