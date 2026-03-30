# miica kit

> I built this because AI coding sessions often feel fast, impressive, and slightly chaotic. `miica-kit` is my attempt to keep the speed, while putting back just enough discipline to ship work I can still defend the next day.

`miica-kit` is a small workflow layer for AI-assisted work.
It does not replace `Codex`, `Claude`, or your favorite agent.
It gives them a clearer operating model.

Published package name:
- `@hrica/miica-kit`

If you use AI for vibe coding, solo building, debugging, shipping side projects, or just getting unstuck, this kit gives you a simpler and more reliable way to drive the session.

This README uses `pnpm dlx` for pnpm examples because that is the documented pnpm command. If your local setup exposes `pnpx`, the intent is the same.

[!NOTE]
> You do **not** need to be highly technical to use this kit.
> In the simplest form, you install it and then ask your agent to use one of eleven commands:
> `miica-plan`, `miica-architecture`, `miica-fix-issue`, `miica-documentation`, `miica-knowledge`, `miica-deep-dive`, `miica-analyse`, `miica-review`, `miica-implementation`, `miica-git`, or `miica-execute-plan`.

## What It Does

Instead of exposing a long list of micro-modes, the kit reduces daily work to eleven commands:

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

Behind those eleven commands, the kit still keeps the useful discipline:
- challenge bad scope before coding
- debug before patching
- review for real risk, not style theater
- use browser evidence when UI behavior matters
- turn inspiration sites, screenshots, recordings, and Figma references into implementation-grade UI guides when the request is design-heavy but under-specified
- research and verify when the output teaches a topic
- sync docs when shipped reality changed
- inspect git state before branching, committing, or drafting PR content
- execute tracked plan steps without letting plan files drift from implementation reality

The goal is simple:
- **less prompt micromanagement**
- **better decisions**
- **more complete execution**

## Who It Is For

`miica-kit` is useful if you are:
- using `Claude`, `Codex`, or another agent for everyday software work
- vibe coding but tired of shallow answers and half-finished outputs
- a solo builder who wants a repeatable workflow
- a founder, PM, designer, or non-full-time developer who still wants the agent to behave like a serious engineer
- switching between multiple agent environments and wanting the same command vocabulary everywhere

## The Mental Model

Think of `miica-kit` as a compact operating system for your agent.

Your AI model stays the same.
The tools stay the same.
The codebase stays the same.

What changes is the behavior:
- the agent plans more cleanly
- it chooses the right level of effort
- it combines review, QA, browser checks, docs sync, research, and verification more intelligently
- it stops when a command is supposed to stay read-only or plan-only

## The Eleven Commands

| Command | In plain English | Use it when... | What it may combine |
|---|---|---|---|
| `miica-plan` | Think before building | the task is fuzzy, risky, needs sequencing, or needs an implementation-plan artifact from settled inputs | scope review, engineering review, design planning, implementation-plan creation, UI reference-guide extraction |
| `miica-architecture` | Turn requirements into a buildable design | requirements are settled and you need a technical architecture | requirements review, architecture design, data flow, repository structure, testing strategy |
| `miica-fix-issue` | Fix something broken | there is a bug, regression, failing flow, or broken test | debug, reproduction, implementation, review, QA |
| `miica-documentation` | Make the docs match reality | docs are missing, stale, or inconsistent | README, MEMORY, CHANGELOG, workflow docs |
| `miica-knowledge` | Build a teachable knowledge base | you want a primer, explainer, onboarding pack, or focused topic guide | research, source gathering, executive summary, practitioner guide, glossary, FAQ |
| `miica-deep-dive` | Go deep on a technology or product | you want a broad, current view of a technology, product, platform, vendor, or ecosystem | research, current verification, browser inspection, API and integration analysis, comparison, executive summary |
| `miica-analyse` | Investigate without changing code | you want diagnosis, comparison, or assessment | read-only analysis, architecture analysis, QA-only, browser evidence |
| `miica-review` | Review recent changes | you want a diff, commit, or focused code review | diff inspection, targeted context reading, project-specific review rules, findings-only reporting |
| `miica-implementation` | Build something end to end | the task is primarily feature delivery | light planning, UI reference-guide extraction, implementation, review, QA, docs sync |
| `miica-git` | Handle the git step | you want a branch, commit, or PR draft | git status and diff inspection, branch naming, selective staging by coherent small slices, conventional commit writing, PR drafting |
| `miica-execute-plan` | Work through a tracked plan | you want to do the next or in-progress step from an existing plan file set | plan-file state management, targeted implementation, in-progress step updates, completed-step archival |

[!TIP]
> If you forget which one to use:
> `plan` before deciding,
> `architecture` to turn settled requirements into system design,
> `fix-issue` when something is broken,
> `documentation` for docs,
> `knowledge` for a teachable topic guide,
> `deep-dive` for a broad technology or product dossier,
> `analyse` for read-only investigation,
> `review` for findings-only code review,
> `implementation` to build,
> `git` for branch, commit, or PR workflow,
> `execute-plan` to work through an existing tracked plan.

## What Makes It Different

There are two important defaults in this kit.

### 1. `miica-se` is always on

`miica-se` is not a public command.
It is the default posture behind every request.

That means the agent should:
- be direct and recommendation-driven
- distinguish facts, hypotheses, risks, and recommendations
- inspect local code, docs, and repository evidence before asking questions that can be answered directly
- verify current external standards only when the recommendation depends on moving targets such as active libraries, APIs, products, or policies
- challenge bad scope before writing code
- surface hidden assumptions, unresolved dependencies, edge cases, and fallback paths when they materially affect the outcome
- ask only the highest-leverage clarification questions and pace them instead of dumping a long checklist
- avoid shallow implementation theater
- close risky work with a short summary of resolved assumptions, open questions, and residual risk

`miica-se` is also grounded in the [Universal Sovereign Code Manifesto](./UNIVERSAL_SOVEREIGN_CODE_MANIFESTO.md).
Its seven pillars define the posture behind the posture:
- Ground: performance is product quality.
- Logic: predictable, reproducible systems beat manual setup.
- Insight: AI should remove mundane work without taking away control.
- Soul: tools should protect creative flow.
- Form: invisible implementation quality matters as much as the visible surface.
- Sovereignty: users own their data, provenance, and AI boundaries.
- Responsibility: efficiency and low waste are engineering requirements.

### 2. Best-available effort is the default

When you invoke a `miica-*` command, the agent should not stop at the first plausible answer.
It should use the strongest relevant combination of what is available in the current environment, for example:
- project instructions and memory
- code inspection
- shell tools
- tests, lint, typecheck, and build
- browser automation
- web research
- MCP resources
- installed skills
- verification and regression checks

The rule is **not** "use every tool".
The rule is: **use every relevant tool that materially reduces uncertainty or risk**.

## Quick Start

### Fastest path for one project

If you just want a better workflow inside the current repository:

```bash
npx @hrica/miica-kit install-kit --mode modular
```

Or with Bun:

```bash
bunx @hrica/miica-kit install-kit --mode modular
```

This installs the project-local kit and keeps your existing project docs safe by default.

### Fastest path for global skills

If you want the same `miica-*` skills available globally in your agent environment:

```bash
npx @hrica/miica-kit install-codex-skills
npx @hrica/miica-kit install-claude-skills
npx @hrica/miica-kit install-agent-skills
```

You can also install only the commands you care about:

```bash
npx @hrica/miica-kit install-codex-skills --skills miica-plan,miica-execute-plan,miica-git,miica-implementation
```

## Real-World Usage Examples

### Example 1: You are not sure what to build

Prompt:

```text
Use miica-plan for this request: I want to add an onboarding flow, but I'm not sure what the right scope is.
```

Expected behavior:
- the agent reframes the real problem
- it challenges scope if necessary
- it may combine product, engineering, and design planning
- it stops after the plan unless you also asked it to continue

### Example 1b: You have inspiration links instead of a clean design prompt

Prompt:

```text
Use miica-plan for this request: use linear.app and the attached Figma board as inspiration for our dashboard, extract a UI guide first, then stop.
```

Expected behavior:
- the agent inspects the references instead of relying on vague aesthetic prompting
- it uses browser and Figma evidence when available
- it writes a strict guide with clear observed facts, inferred details, and unknowns
- it stops after the planning and guide artifact unless you also asked it to continue

### Example 1c: You want an architecture doc from settled requirements

Prompt:

```text
Use miica-architecture with REQUIREMENTS.md ARCHITECTURE.md for the billing revamp.
```

Expected behavior:
- the agent reads the requirements first
- it surfaces open questions when they would materially change the design
- it writes `ARCHITECTURE.md` with components, data flow, structure, testing strategy, assumptions, and open questions
- it stops after the architecture unless you also asked it to continue

### Example 1d: You want an implementation-plan artifact from settled inputs

Prompt:

```text
Use miica-plan with REQUIREMENTS.md and ARCHITECTURE.md to generate a buildable implementation plan for the billing revamp.
```

Expected behavior:
- the agent reads the settled inputs first
- it verifies only the current standards that materially affect the plan
- it writes a phased implementation plan artifact under `docs/plans/`
- it stops after the plan artifact unless you also asked it to continue

### Example 2: Something is broken

Prompt:

```text
Use miica-fix-issue on this regression: the upload flow now fails after selecting a file.
```

Expected behavior:
- the agent reproduces the problem
- investigates before patching
- fixes the issue
- verifies the changed path
- adds regression protection when appropriate

### Example 3: You want a knowledge base that teaches the topic

Prompt:

```text
Use miica-knowledge to create a knowledge base on publishing an npm package with GitHub Actions for technical and non-technical readers.
```

Expected behavior:
- the agent researches current authoritative sources
- creates a dedicated `knowledge-base/<topic-slug>/` folder
- explains the topic for mixed audiences without drowning non-technical readers in jargon
- includes sources, caveats, and practical guidance
- see the canonical example in [`knowledge-base/npm-package-publishing-with-github-actions/`](./knowledge-base/npm-package-publishing-with-github-actions/README.md)

### Example 4: You want a broad deep dive on a product or technology

Prompt:

```text
Use miica-deep-dive to create a deep dive on Zoho CRM, including product surface, latest changes, API and integrations, market positioning, and practical recommendations.
```

Expected behavior:
- the agent researches authoritative current sources
- inspects dynamic product pages with browser tooling when simple fetch is not enough
- creates a dedicated `deep-dive/<topic-slug>/` folder
- separates durable product understanding from dated market or release observations
- delivers a structured dossier instead of a narrow explainer

### Example 5: You want a read-only review

Prompt:

```text
Use miica-analyse on the current diff and tell me the real risks.
```

Expected behavior:
- the agent stays read-only
- reviews for bugs, regressions, missing handling, coverage gaps, or architectural concerns
- does not silently continue into implementation unless you ask for that in the same message

### Example 5b: You want a findings-only code review

Prompt:

```text
Use miica-review on the current diff with a security focus.
```

Expected behavior:
- the agent stays read-only
- it reviews the changed code and the nearby context needed to judge it
- it reports findings grouped as must fix, should fix, and observations
- it says so explicitly if the review is clean

### Example 6: You want full implementation

Prompt:

```text
Use miica-implementation for this feature: add a settings page to manage export preferences.
```

Expected behavior:
- the agent does only the planning needed
- implements the feature
- reviews its own work
- runs QA / validation proportionate to the change
- updates docs if durable behavior changed

### Example 7: You want a git workflow step handled directly

Prompt:

```text
Use miica-git to draft pull request content for this branch against main.
```

Expected behavior:
- the agent inspects the current git status and branch diff first
- it infers that the request is a PR draft, not a branch or commit action
- it returns a title, summary, testing notes, and risk or open-question section
- if you instead ask for a branch or commit, it routes to that path automatically

### Example 8: You want to execute the next step from an existing tracked plan

Prompt:

```text
Use miica-execute-plan to do the next step from the current plan files.
```

Expected behavior:
- the agent reads the existing `plan-backlog.md`, `plan-in-progress.md`, and `plan-completed.md` files first
- it moves the top backlog step to in-progress only while implementing it in the same response
- it keeps plan state truthful as work moves from in-progress to completed
- if the next step is blocked, it explains why and does not mutate the plan files speculatively

## Installation Modes

You can use the kit in three ways.

### 1. Project-local kit

Use this when you want the current repository to have a local operating model.

Package runners:

```bash
npx @hrica/miica-kit install-kit --mode direct
npx @hrica/miica-kit install-kit --mode modular --skills miica-plan,miica-execute-plan,miica-git,miica-implementation
```

```bash
pnpm dlx @hrica/miica-kit install-kit --mode direct
pnpm dlx @hrica/miica-kit install-kit --mode modular --skills miica-plan,miica-execute-plan,miica-git,miica-implementation
```

```bash
bunx @hrica/miica-kit install-kit --mode direct
bunx @hrica/miica-kit install-kit --mode modular --skills miica-plan,miica-execute-plan,miica-git,miica-implementation
```

Native scripts from a local clone:

```powershell
./scripts/install-kit.ps1 -TargetPath <path> -Mode direct
./scripts/install-kit.ps1 -TargetPath <path> -Mode modular -Skills @('miica-plan','miica-execute-plan','miica-git','miica-implementation')
```

```bash
./scripts/install-kit.sh <path> direct
./scripts/install-kit.sh <path> modular miica-plan miica-execute-plan miica-git miica-implementation
```

#### Direct vs modular

- `direct`: install the root docs directly into the project
- `modular`: preserve the public project root and place the portable kit files under `.agent-kit/`

#### What gets installed

A project-local install may add:
- `AGENTS.md`
- `MEMORY.md`
- `CHANGELOG.md`
- `.agent-kit/ROLES.md`
- `.agent-kit/WORKFLOW.md`
- selected `.agent-kit/skills/`
- `.agent-kit/install-state.env`

#### Safety behavior

If the target project already has its own root docs, the installer preserves them by default and writes kit fallbacks under `.agent-kit/`.

### 2. Global Codex skills

Use this when you want the `miica-*` commands available in `Codex`.

```bash
npx @hrica/miica-kit install-codex-skills
pnpm dlx @hrica/miica-kit install-codex-skills --skills miica-plan,miica-architecture,miica-fix-issue,miica-documentation,miica-knowledge,miica-deep-dive,miica-analyse,miica-review,miica-implementation,miica-git,miica-execute-plan
bunx @hrica/miica-kit install-codex-skills
```

Native scripts:

```powershell
./scripts/install-codex-skills.ps1
./scripts/install-codex-skills.ps1 -Skills @('miica-plan','miica-architecture','miica-fix-issue','miica-documentation','miica-knowledge','miica-deep-dive','miica-analyse','miica-review','miica-implementation','miica-git','miica-execute-plan')
```

```bash
./scripts/install-codex-skills.sh
./scripts/install-codex-skills.sh "" miica-plan miica-architecture miica-fix-issue miica-documentation miica-knowledge miica-deep-dive miica-analyse miica-review miica-implementation miica-git miica-execute-plan
```

Default install target:
- `~/.codex/skills`
- or `$CODEX_HOME/skills` if `CODEX_HOME` is set

### 3. Global Claude skills

Use this when you want the same command surface in `Claude`.

```bash
npx @hrica/miica-kit install-claude-skills
pnpm dlx @hrica/miica-kit install-claude-skills --skills miica-plan,miica-architecture,miica-fix-issue,miica-documentation,miica-knowledge,miica-deep-dive,miica-analyse,miica-review,miica-implementation,miica-git,miica-execute-plan
bunx @hrica/miica-kit install-claude-skills
```

Native scripts:

```powershell
./scripts/install-claude-skills.ps1
./scripts/install-claude-skills.ps1 -Skills @('miica-plan','miica-architecture','miica-fix-issue','miica-documentation','miica-knowledge','miica-deep-dive','miica-analyse','miica-review','miica-implementation','miica-git','miica-execute-plan')
```

```bash
./scripts/install-claude-skills.sh
./scripts/install-claude-skills.sh "" miica-plan miica-architecture miica-fix-issue miica-documentation miica-knowledge miica-deep-dive miica-analyse miica-review miica-implementation miica-git miica-execute-plan
```

Default install target:
- `~/.claude/skills`
- or `$CLAUDE_HOME/skills` if `CLAUDE_HOME` is set

### 4. Global `.agents` skills

Use this when you want the same commands in `.agents`-style environments.

```bash
npx @hrica/miica-kit install-agent-skills
pnpm dlx @hrica/miica-kit install-agent-skills --skills miica-plan,miica-architecture,miica-fix-issue,miica-documentation,miica-knowledge,miica-deep-dive,miica-analyse,miica-review,miica-implementation,miica-git,miica-execute-plan
bunx @hrica/miica-kit install-agent-skills
```

Native scripts:

```powershell
./scripts/install-agent-skills.ps1
./scripts/install-agent-skills.ps1 -Skills @('miica-plan','miica-architecture','miica-fix-issue','miica-documentation','miica-knowledge','miica-deep-dive','miica-analyse','miica-review','miica-implementation','miica-git','miica-execute-plan')
```

```bash
./scripts/install-agent-skills.sh
./scripts/install-agent-skills.sh "" miica-plan miica-architecture miica-fix-issue miica-documentation miica-knowledge miica-deep-dive miica-analyse miica-review miica-implementation miica-git miica-execute-plan
```

Default install target:
- `~/.agents/skills`
- or `$AGENTS_HOME/skills` if `AGENTS_HOME` is set

## Uninstall

The kit also includes symmetric uninstall commands.

### Project-local uninstall

```bash
npx @hrica/miica-kit uninstall-kit
pnpm dlx @hrica/miica-kit uninstall-kit
bunx @hrica/miica-kit uninstall-kit
```

Native scripts:

```powershell
./scripts/uninstall-kit.ps1 -TargetPath <path>
```

```bash
./scripts/uninstall-kit.sh <path>
```

Project uninstall removes **only kit-managed elements** and is conservative with root docs:
- if `AGENTS.md`, `MEMORY.md`, or `CHANGELOG.md` were installed by the kit and are still unchanged, they are removed
- if those files were overwritten by the kit and stayed unchanged, their pre-kit backups are restored
- if they changed after installation, they are left in place and `.agent-kit/` state is kept for manual cleanup
- if the project was installed before install-state tracking existed, root docs are left untouched and only known `.agent-kit/` kit files are removed

### Global skill uninstall

```bash
npx @hrica/miica-kit uninstall-codex-skills --skills miica-plan,miica-execute-plan
npx @hrica/miica-kit uninstall-claude-skills --skills miica-plan,miica-execute-plan
npx @hrica/miica-kit uninstall-agent-skills --skills miica-plan,miica-execute-plan
```

You can omit `--skills` to remove the whole `miica-*` surface from that target environment.

## How The Commands Behave

### `miica-plan`

Use it for planning, scoping, sequencing, design direction before coding, or a buildable implementation-plan artifact from settled requirements and architecture.

Important behavior:
- it is a hard phase boundary
- if the user has settled requirements and architecture and wants a buildable implementation plan, it should generate a phased artifact under `docs/plans/`
- if the design intent is being shown through websites, screenshots, recordings, or Figma links, it should extract a strict UI guide before recommending implementation
- it should stop after the plan or plan artifact unless the same message explicitly asks to continue

### `miica-architecture`

Use it when a technical architecture is the deliverable.

Important behavior:
- read settled requirements first
- surface open questions if they materially affect the design
- produce a buildable architecture with components, data flow, repository structure, testing strategy, assumptions, and open questions
- stop after the architecture unless the same message explicitly asks to continue

### `miica-fix-issue`

Use it for bugs, regressions, broken flows, or failing tests.

Important behavior:
- reproduce first
- investigate before patching
- verify the fix
- add regression protection when appropriate

### `miica-documentation`

Use it for docs creation, cleanup, syncing, or audits.

Important behavior:
- docs should reflect the real code and behavior
- README, MEMORY, CHANGELOG, workflow notes, and architecture docs may all be in scope

### `miica-knowledge`

Use it for knowledge bases, explainers, primers, and focused topic guides.

Important behavior:
- research and verify when the topic depends on current tools, policies, or platform behavior
- structure the output for mixed audiences instead of writing one giant wall of text
- separate facts, recommendations, and uncertainty
- use `miica-deep-dive` instead when the request is really a broad technology or product dossier

### `miica-deep-dive`

Use it for broad, current deep dives on technologies, products, platforms, vendors, and ecosystems.

Important behavior:
- gather broad source coverage, not just one narrow explanation
- use browser tooling when simple fetch is not enough because the page is dynamic or interaction-dependent
- check for existing Playwright skill or MCP/browser tooling before introducing direct setup
- separate durable understanding from dated release or market observations

### `miica-analyse`

Use it for read-only investigation, diagnosis, or comparison.

Important behavior:
- it is read-only by default
- it should not silently drift into implementation unless the same message asks it to continue

### `miica-review`

Use it for code review of the current diff, a recent commit, or a focused area.

Important behavior:
- it is findings-only and read-only by default
- it should review changed code and only the nearby context needed to judge it
- it should prioritize real bugs, security issues, fragility, and robustness problems over style
- it should say so explicitly when the review is clean

### `miica-implementation`

Use it for end-to-end feature work.

Important behavior:
- it should do only the planning the task actually needs
- if the UI direction is carried mainly by references, it should extract and follow a strict guide before coding
- then implementation, review, QA, verification, and docs sync when warranted

### `miica-git`

Use it for focused git workflow steps: branch creation, commit creation, or pull request drafting.

Important behavior:
- it should inspect the current git state before acting
- it should infer whether the user needs a branch, commit, or PR draft and route automatically
- it should prefer precise staging, split multi-part diffs into coherent small commit slices, and write a conventional commit message for each slice
- it should draft PR content from the real branch diff and only open an actual PR if the user explicitly asks and tooling allows it

### `miica-execute-plan`

Use it for working through an existing tracked plan file set step by step.

Important behavior:
- it should read the current `plan-backlog.md`, `plan-in-progress.md`, and `plan-completed.md` files before acting
- it should only move backlog to in-progress while implementing that step in the same response
- it should keep the in-progress step as a truthful mirror of in-progress work
- it should not mutate the plan files speculatively when the next step is blocked

## What Stayed From The Original Workflow

Internally, the workflow still preserves what actually matters:
- scope challenge before medium or large work
- engineering review before risky implementation
- design planning for user-facing work
- reference-driven UI guide extraction for website, screenshot, recording, or Figma-led design requests
- research and source verification for educational outputs
- debug before patch
- review for production risk
- browser QA as evidence
- docs sync as part of shipping

The difference is that you do not have to think in fifteen micro-modes every day.

## Repository Structure

- [`AGENTS.md`](./AGENTS.md): always-on `miica-se` posture plus the eleven-command model
- [`MEMORY.md`](./MEMORY.md): durable repo memory and installer invariants
- [`CHANGELOG.md`](./CHANGELOG.md): notable kit changes
- [`ROLES.md`](./ROLES.md): extracted internal roles from the original workflow
- [`WORKFLOW.md`](./WORKFLOW.md): public workflow and command-routing rules
- [`knowledge-base/npm-package-publishing-with-github-actions/`](./knowledge-base/npm-package-publishing-with-github-actions/README.md): canonical `miica-knowledge` example for npm package publishing with GitHub Actions
- [`skills/`](./skills): eleven portable public commands
- [`codex-skills/`](./codex-skills): eleven installable skill folders for Codex and `.agents`
- [`claude-skills/`](./claude-skills): eleven installable skill folders for Claude
- [`templates/UI_REFERENCE_GUIDE_TEMPLATE.md`](./templates/UI_REFERENCE_GUIDE_TEMPLATE.md): markdown template for reference-driven UI guide artifacts
- [`templates/UI_REFERENCE_GUIDE_SCHEMA.json`](./templates/UI_REFERENCE_GUIDE_SCHEMA.json): strict machine-readable schema for `guide.json` outputs
- [`templates/PROJECT_AGENT_INSTRUCTIONS.md`](./templates/PROJECT_AGENT_INSTRUCTIONS.md): base project instruction template
- [`templates/PROJECT_MEMORY.md`](./templates/PROJECT_MEMORY.md): durable project memory template
- [`templates/PROJECT_CHANGELOG.md`](./templates/PROJECT_CHANGELOG.md): project changelog template
- [`scripts/install-kit.ps1`](./scripts/install-kit.ps1): PowerShell installer for project-local setup
- [`scripts/uninstall-kit.ps1`](./scripts/uninstall-kit.ps1): PowerShell uninstaller for project-local setup
- [`scripts/install-kit.sh`](./scripts/install-kit.sh): shell installer for project-local setup
- [`scripts/uninstall-kit.sh`](./scripts/uninstall-kit.sh): shell uninstaller for project-local setup
- [`scripts/install-codex-skills.ps1`](./scripts/install-codex-skills.ps1): PowerShell installer for `~/.codex/skills`
- [`scripts/uninstall-codex-skills.ps1`](./scripts/uninstall-codex-skills.ps1): PowerShell uninstaller for `~/.codex/skills`
- [`scripts/install-codex-skills.sh`](./scripts/install-codex-skills.sh): shell installer for `~/.codex/skills`
- [`scripts/uninstall-codex-skills.sh`](./scripts/uninstall-codex-skills.sh): shell uninstaller for `~/.codex/skills`
- [`scripts/install-claude-skills.ps1`](./scripts/install-claude-skills.ps1): PowerShell installer for `~/.claude/skills`
- [`scripts/uninstall-claude-skills.ps1`](./scripts/uninstall-claude-skills.ps1): PowerShell uninstaller for `~/.claude/skills`
- [`scripts/install-claude-skills.sh`](./scripts/install-claude-skills.sh): shell installer for `~/.claude/skills`
- [`scripts/uninstall-claude-skills.sh`](./scripts/uninstall-claude-skills.sh): shell uninstaller for `~/.claude/skills`
- [`scripts/install-agent-skills.ps1`](./scripts/install-agent-skills.ps1): PowerShell installer for `~/.agents/skills`
- [`scripts/uninstall-agent-skills.ps1`](./scripts/uninstall-agent-skills.ps1): PowerShell uninstaller for `~/.agents/skills`
- [`scripts/install-agent-skills.sh`](./scripts/install-agent-skills.sh): shell installer for `~/.agents/skills`
- [`scripts/uninstall-agent-skills.sh`](./scripts/uninstall-agent-skills.sh): shell uninstaller for `~/.agents/skills`
- [`bin/miica-kit.mjs`](./bin/miica-kit.mjs): cross-platform CLI entrypoint
- [`PUBLISHING.md`](./PUBLISHING.md): maintainer guide for publishing to npm and testing `npx` / `bunx` / `pnpm dlx`

## Maintainer Note

If you want to publish this package so it can be used with `npx`, `bunx`, or `pnpm dlx` from anywhere, see [PUBLISHING.md](./PUBLISHING.md).
For release-worthy pull requests, squash-merge with a Conventional Commit title or edit the merge commit title before merging. Default `Merge pull request #...` subjects can cause `release-please` to skip release creation.

## License

This project is licensed under the MIT License. See [LICENSE](./LICENSE).

## Practical Rule

Do not treat this repo as a framework.
Treat it as a compact operating system for agentic software delivery.
