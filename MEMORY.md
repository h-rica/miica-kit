# MEMORY

Durable memory for `miica-kit`.

## Mission-critical truths

- This repo is a portability layer for an existing phase-based operating model, not a runtime clone of any vendor-specific behavior.
- Keep the public command surface small enough for daily work.
- Preserve the richer internal phase model even when the public commands are fewer.
- `miica-se` is an always-on posture, not a separate public command.
- Every `miica-*` invocation should use best-available effort: the strongest relevant combination of tools and evidence in the current environment.
- Search first and browse second remains the default policy for web work.

## Installation defaults

- `AGENTS.md`, `MEMORY.md`, and `CHANGELOG.md` are first-class project documents.
- Target-project root files are user-owned and must be preserved by default.
- If a target project already has its own root docs, install fallback templates under `.agent-kit/` instead of overwriting them.
- Project-local installs must write `.agent-kit/install-state.env` plus install snapshots for kit-managed root docs.
- Project-local uninstall must remove only kit-managed files and restore pre-kit backups only when the current root files still match the last installed kit snapshot.
- If a project-local uninstall cannot safely restore or remove a root doc, it should leave the file in place and keep `.agent-kit/` state for manual cleanup.

## Naming defaults

- Portable public command names live in `skills/` and use the `miica-*` prefix.
- Installable global skills live in `codex-skills/` and `claude-skills/` and use the same `miica-*` names.
- Public command count should stay small unless there is a strong reason to expand it.

## Documentation defaults

- `README.md` is publish-facing and task-oriented.
- `CHANGELOG.md` tracks notable kit changes.
- `MEMORY.md` stores durable repo lessons and installer invariants, not release notes.

## Update rules

- Add to this file only when a lesson is likely to matter again.
- Prefer concrete operational rules over narrative history.
- Remove or revise entries when repo reality changes.
