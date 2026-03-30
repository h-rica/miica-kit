# Portable Skills

This folder contains the public portable command surface for the kit.

The kit intentionally exposes only eleven commands:
- `miica-plan`
- `miica-architecture`
- `miica-fix-issue`
- `miica-documentation`
- `miica-knowledge`
- `miica-deep-dive`
- `miica-analyse`
- `miica-review`
- `miica-implementation`
- `miica-git`
- `miica-execute-plan`

`miica-se` is no longer a separate public skill. It is the always-on posture behind every command.

## Why the surface is small

The original phase-by-phase breakdown is useful for maintenance, but too granular for daily work.

This kit now hides that phase complexity behind eleven commands:
- `miica-plan` decides whether to apply scope review, engineering review, design planning, reference-driven UI guide extraction, and implementation-plan creation
- `miica-architecture` decides how much requirement analysis, architecture design, data-flow definition, and structural planning are needed
- `miica-fix-issue` decides how much debug, review, QA, and ship work is needed
- `miica-documentation` decides which durable docs need updates
- `miica-knowledge` decides how much research, teaching structure, and audience layering are needed for a focused topic
- `miica-deep-dive` decides how much broad research, current verification, browser inspection, and dossier structure are needed
- `miica-analyse` decides which read-only analysis lenses to combine
- `miica-review` decides how much diff inspection and findings-only review work is needed
- `miica-implementation` decides how much planning, reference-driven UI extraction, implementation, QA, and docs sync are needed
- `miica-git` decides how much git-state inspection, branch creation, small-slice commit creation, and PR drafting work is needed
- `miica-execute-plan` decides how to move through existing tracked plan files while implementing the next or in-progress step

## Suggested usage in another project

- Copy the files you want into a project-local `skills/` or `docs/agents/` folder.
- Point your agent instruction file at the relevant commands.
- Replace the tool examples with the native commands available in your stack when needed.
