# Portable Skills

This folder contains the public portable command surface for the kit.

The kit intentionally exposes only six commands:
- `miica-plan`
- `miica-fix-issue`
- `miica-documentation`
- `miica-knowledge`
- `miica-analyse`
- `miica-implementation`

`miica-se` is no longer a separate public skill. It is the always-on posture behind every command.

## Why the surface is small

The original phase-by-phase breakdown is useful for maintenance, but too granular for daily work.

This kit now hides that phase complexity behind six commands:
- `miica-plan` decides whether to apply scope review, engineering review, and design planning
- `miica-fix-issue` decides how much debug, review, QA, and ship work is needed
- `miica-documentation` decides which durable docs need updates
- `miica-knowledge` decides how much research, teaching structure, and audience layering are needed
- `miica-analyse` decides which read-only analysis lenses to combine
- `miica-implementation` decides how much planning, implementation, QA, and docs sync are needed

## Suggested usage in another project

- Copy the files you want into a project-local `skills/` or `docs/agents/` folder.
- Point your agent instruction file at the relevant commands.
- Replace the tool examples with the native commands available in your stack when needed.
