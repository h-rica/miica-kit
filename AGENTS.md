# Miica Daily Driver AGENTS

Use this file as the personal operating system for daily agentic software work.

## Mission

Keep the public command surface small and the internal workflow rigorous.

The public commands in this kit are:
- `miica-plan`
- `miica-fix-issue`
- `miica-documentation`
- `miica-knowledge`
- `miica-deep-dive`
- `miica-analyse`
- `miica-implementation`

## Always-on miica-se posture

Apply this stance on every non-trivial request, even when the user does not name it:

- be direct and recommendation-driven
- separate facts, hypotheses, risks, and recommendations
- challenge bad scope before writing code
- prefer coherent local changes over theoretical elegance
- state uncertainty and residual risk clearly

`miica-se` is not a public command anymore. It is the default posture behind every command.

## Project memory and release docs

When a repository has `MEMORY.md`, read it at the start of every non-trivial task.

Use `MEMORY.md` for durable lessons such as recurring blockers, workflow defaults, source-of-truth notes, and prevention rules.
Do not use it for temporary task tracking.

Use `CHANGELOG.md` for notable shipped changes that should stay visible over time.

## Public command model

### 1. miica-plan

Use when the user wants planning, scoping, sequencing, architecture direction, or simply says plan.

The command should intelligently combine only the planning lenses that matter:
- scope and user-value pressure test when the request is product-facing, fuzzy, or suspiciously narrow
- engineering review when the change is non-trivial, risky, cross-layer, or architecturally unclear
- design planning review when users will directly experience the result

`miica-plan` is a hard phase boundary.
Stop after the plan unless the same user message explicitly asks to continue.

### 2. miica-fix-issue

Use when the user wants a bug, issue, regression, broken flow, or failing test fixed.

This command may combine:
- debug
- browser reproduction
- targeted implementation
- review of the changed path
- QA and regression protection
- ship validation

### 3. miica-documentation

Use when the user wants docs created, updated, audited, or synchronized with current behavior.

This command may touch:
- README
- MEMORY
- CHANGELOG
- architecture docs
- testing docs
- contributor or workflow docs

### 4. miica-knowledge

Use when the user wants a knowledge base, explainer, primer, onboarding pack, or learning dossier on a topic.

This command may combine:
- current research
- source gathering and verification
- topic structuring
- executive explanation for non-technical readers
- practitioner guidance for technical readers
- glossary, FAQ, and sources writing

### 5. miica-deep-dive

Use when the user wants a broad, current deep dive on a technology, product, platform, vendor, or ecosystem.

This command may combine:
- current research
- source gathering and verification
- browser-based inspection of dynamic pages when necessary
- product, API, integration, and ecosystem analysis
- market comparison and positioning
- executive synthesis plus practitioner-oriented guidance

### 6. miica-analyse

Use when the user wants investigation, review, diagnosis, assessment, or comparison without code changes.

This command may combine read-only:
- debug investigation
- architecture analysis
- code review
- QA-only reporting
- browser evidence gathering
- current research

`miica-analyse` is a hard phase boundary.
Do not modify files in this mode unless the same user message explicitly asks to continue.

### 7. miica-implementation

Use when the user wants software built or changed end-to-end and the task is primarily implementation rather than bug fixing or documentation.

This command may combine:
- lightweight planning when needed
- design planning when the work is user-facing
- implementation
- self-review
- browser QA
- ship validation
- docs sync

## Default inference rule

If the user does not name a command, infer the best one:
- fuzzy scope or architecture question: `miica-plan`
- bug or regression: `miica-fix-issue`
- docs work: `miica-documentation`
- knowledge base, explainer, primer, onboarding pack, or focused learning dossier: `miica-knowledge`
- broad, current deep dive on a technology, product, platform, vendor, or ecosystem: `miica-deep-dive`
- investigation or review request: `miica-analyse`
- feature or behavior change: `miica-implementation`

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

## Browser and research rule

For current external information or browser-dependent behavior:
- search or fetch first when discovery is the main problem
- use a real browser when the truth depends on JavaScript, auth, layout, history, console, network behavior, or user interaction

## Command-level effort expectations

- `miica-plan`: use all relevant planning lenses needed by the request, not just one by habit
- `miica-fix-issue`: reproduce, investigate, verify, review, and regression-protect with the strongest available stack
- `miica-documentation`: inspect real code, commands, and behavior before editing docs
- `miica-knowledge`: gather authoritative sources, structure layered teaching material, and make the topic understandable for mixed audiences
- `miica-deep-dive`: gather authoritative sources, verify current facts, inspect dynamic pages with browser tooling when needed, and synthesize a broad dossier
- `miica-analyse`: gather maximum relevant evidence, but remain read-only
- `miica-implementation`: use the minimum planning needed, then implement, review, QA, verify, and sync docs when warranted

## Verification rule

For implementation or issue-fixing work, do not declare done without proportionate verification.

Check what actually changed and verify the changed path.
If behavior changed durably, sync the docs.

## Completeness principle

If the complete version is only modestly more work than the shortcut version, prefer the complete version now.

Practical rule:
- finish the small lake
- document and defer the ocean

## Tool adaptation rule

Replace any tool-specific instruction with the native capability available in the current agent stack.

Preferred daily stack when available:
- web search or fetch for discovery and current information
- Playwright or equivalent real-browser tooling for browser truth
- local shell commands for tests, lint, typecheck, and build

The workflow matters more than the vendor.
