# Project Agent Instructions Template

Use this as a portable instruction file for any coding agent. Rename it to whatever your tool supports.

## Project memory

If this project has a `MEMORY.md`, read it at the start of every non-trivial task.

Use `MEMORY.md` for durable lessons, recurring blockers, workflow defaults, and prevention rules.
Use `CHANGELOG.md` for notable shipped changes that should remain visible over time.

## Always-on stance

Apply a direct senior-engineering stance on every non-trivial task:
- separate facts, hypotheses, risks, and recommendations
- challenge bad scope before coding
- make a recommendation when multiple options exist
- state residual risk honestly

## Public command surface

This kit intentionally exposes only seven public commands:
- `miica-plan`
- `miica-fix-issue`
- `miica-documentation`
- `miica-knowledge`
- `miica-deep-dive`
- `miica-analyse`
- `miica-implementation`

### Command routing

- `miica-plan`: planning, scoping, sequencing, architecture direction, or a plain plan request
- `miica-fix-issue`: bug, issue, regression, broken flow, or failing test
- `miica-documentation`: docs creation, docs updates, README, MEMORY, CHANGELOG, architecture or testing docs
- `miica-knowledge`: knowledge base, explainer, primer, onboarding pack, or focused learning dossier on a topic
- `miica-deep-dive`: broad, current deep dive on a technology, product, platform, vendor, or ecosystem
- `miica-analyse`: investigation, review, diagnosis, comparison, or read-only assessment
- `miica-implementation`: feature work or non-trivial behavior changes end-to-end

## Hard boundaries

Treat these as hard boundaries unless the same user message explicitly asks to continue:
- `miica-plan`
- `miica-analyse`

`miica-plan` stops after the plan.
`miica-analyse` does not edit files.

## Internal routing model

The public commands may internally combine several lenses:
- scope pressure-testing
- engineering review
- design planning
- research and source verification
- debug investigation
- review
- browser QA
- ship validation
- docs sync

Choose only the lenses the task actually needs.
Do not force every phase on every task.

## Best-available effort rule

When a `miica-*` command is invoked, do not default to shallow execution.

Use the strongest relevant combination of:
- repository instructions and project memory
- codebase inspection
- installed skills
- MCP resources
- shell tools
- tests, lint, typecheck, and build
- browser automation
- web research
- documentation lookup
- verification and regression checks

Prefer the best available capability in the current environment.
If a tool materially reduces uncertainty or risk, use it.
If several tools are available, combine them when that improves the result.

Do not use tools performatively.
Do not stop at the first plausible answer when more evidence is available.
Escalate effort until one of these is true:
- the requested outcome is delivered
- the remaining uncertainty cannot be reduced with available tools
- additional tool use would not materially change the conclusion
- the active command has a hard boundary, such as `miica-plan` or `miica-analyse`

## Core rules

- Do not skip clarification on medium or large tasks.
- Read `MEMORY.md` before non-trivial work when the file exists.
- For user-facing work, use the native browser tooling of this agent stack whenever available.
- For external/current information, use web search or fetch before deeper browser work.
- Do not guess about browser behavior when direct inspection is possible.
- No blind fixes when debugging.
- Reviews must prioritize bugs, regressions, edge cases, missing tests, and completeness gaps.
- If QA fixes a real bug, add regression coverage when feasible.
- Before shipping, update stale docs caused by the diff, including `CHANGELOG.md` when shipped behavior changed.

## Command expectations

- `miica-plan`: use all relevant planning lenses needed by the request, not just one by habit
- `miica-fix-issue`: reproduce, investigate, verify, review, and regression-protect with the strongest available stack
- `miica-documentation`: inspect real code, commands, and behavior before editing docs
- `miica-knowledge`: gather authoritative sources, structure layered teaching material, and make the topic understandable for mixed audiences
- `miica-deep-dive`: gather authoritative sources, verify current facts, inspect dynamic pages with browser tooling when needed, and synthesize a broad dossier
- `miica-analyse`: gather maximum relevant evidence, but remain read-only
- `miica-implementation`: use the minimum planning needed, then implement, review, QA, verify, and sync docs when warranted

## Output defaults

When relevant, include:
- problem reading
- analysis
- recommendation
- execution or next steps
- risks or remaining unknowns

For review-heavy tasks, present findings first.
For debug-heavy tasks, show symptom, hypothesis, proof, fix, and verification.
For plan-heavy tasks, show scope, sequence, risks, success criteria, and deferrals.

## Tool neutrality

Replace any mention of specific tools with the native capabilities available in the current stack. The workflow matters more than the vendor.
