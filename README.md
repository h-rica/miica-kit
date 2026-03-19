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
> In the simplest form, you install it and then ask your agent to use one of six commands:
> `miica-plan`, `miica-fix-issue`, `miica-documentation`, `miica-knowledge`, `miica-analyse`, or `miica-implementation`.

## What It Does

Instead of exposing a long list of micro-modes, the kit reduces daily work to six commands:

- `miica-plan`
- `miica-fix-issue`
- `miica-documentation`
- `miica-knowledge`
- `miica-analyse`
- `miica-implementation`

Behind those six commands, the kit still keeps the useful discipline:
- challenge bad scope before coding
- debug before patching
- review for real risk, not style theater
- use browser evidence when UI behavior matters
- research and verify when the output teaches a topic
- sync docs when shipped reality changed

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

## The Six Commands

| Command | In plain English | Use it when... | What it may combine |
|---|---|---|---|
| `miica-plan` | Think before building | the task is fuzzy, risky, or needs sequencing | scope review, engineering review, design planning |
| `miica-fix-issue` | Fix something broken | there is a bug, regression, failing flow, or broken test | debug, reproduction, implementation, review, QA |
| `miica-documentation` | Make the docs match reality | docs are missing, stale, or inconsistent | README, MEMORY, CHANGELOG, workflow docs |
| `miica-knowledge` | Build a teachable knowledge base | you want a primer, explainer, onboarding pack, or topic guide | research, source gathering, executive summary, practitioner guide, glossary, FAQ |
| `miica-analyse` | Investigate without changing code | you want diagnosis, review, comparison, or assessment | read-only review, architecture analysis, QA-only, browser evidence |
| `miica-implementation` | Build something end to end | the task is primarily feature delivery | light planning, implementation, review, QA, docs sync |

[!TIP]
> If you forget which one to use:
> `plan` before deciding,
> `fix-issue` when something is broken,
> `documentation` for docs,
> `knowledge` for a teachable topic guide,
> `analyse` for read-only investigation,
> `implementation` to build.

## What Makes It Different

There are two important defaults in this kit.

### 1. `miica-se` is always on

`miica-se` is not a public command.
It is the default posture behind every request.

That means the agent should:
- be direct and recommendation-driven
- distinguish facts, hypotheses, risks, and recommendations
- challenge bad scope before writing code
- avoid shallow implementation theater
- state residual risk honestly

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

The rule is **not** “use every tool”.
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
npx @hrica/miica-kit install-codex-skills --skills miica-plan,miica-knowledge,miica-implementation
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

### Example 4: You want a read-only review

Prompt:

```text
Use miica-analyse on the current diff and tell me the real risks.
```

Expected behavior:
- the agent stays read-only
- reviews for bugs, regressions, missing handling, coverage gaps, or architectural concerns
- does not silently continue into implementation unless you ask for that in the same message

### Example 5: You want full implementation

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

## Installation Modes

You can use the kit in three ways.

### 1. Project-local kit

Use this when you want the current repository to have a local operating model.

Package runners:

```bash
npx @hrica/miica-kit install-kit --mode direct
npx @hrica/miica-kit install-kit --mode modular --skills miica-plan,miica-knowledge,miica-implementation
```

```bash
pnpm dlx @hrica/miica-kit install-kit --mode direct
pnpm dlx @hrica/miica-kit install-kit --mode modular --skills miica-plan,miica-knowledge,miica-implementation
```

```bash
bunx @hrica/miica-kit install-kit --mode direct
bunx @hrica/miica-kit install-kit --mode modular --skills miica-plan,miica-knowledge,miica-implementation
```

Native scripts from a local clone:

```powershell
./scripts/install-kit.ps1 -TargetPath <path> -Mode direct
./scripts/install-kit.ps1 -TargetPath <path> -Mode modular -Skills @('miica-plan','miica-knowledge','miica-implementation')
```

```bash
./scripts/install-kit.sh <path> direct
./scripts/install-kit.sh <path> modular miica-plan miica-knowledge miica-implementation
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
pnpm dlx @hrica/miica-kit install-codex-skills --skills miica-plan,miica-fix-issue,miica-documentation,miica-knowledge,miica-analyse,miica-implementation
bunx @hrica/miica-kit install-codex-skills
```

Native scripts:

```powershell
./scripts/install-codex-skills.ps1
./scripts/install-codex-skills.ps1 -Skills @('miica-plan','miica-fix-issue','miica-documentation','miica-knowledge','miica-analyse','miica-implementation')
```

```bash
./scripts/install-codex-skills.sh
./scripts/install-codex-skills.sh "" miica-plan miica-fix-issue miica-documentation miica-knowledge miica-analyse miica-implementation
```

Default install target:
- `~/.codex/skills`
- or `$CODEX_HOME/skills` if `CODEX_HOME` is set

### 3. Global Claude skills

Use this when you want the same command surface in `Claude`.

```bash
npx @hrica/miica-kit install-claude-skills
pnpm dlx @hrica/miica-kit install-claude-skills --skills miica-plan,miica-fix-issue,miica-documentation,miica-knowledge,miica-analyse,miica-implementation
bunx @hrica/miica-kit install-claude-skills
```

Native scripts:

```powershell
./scripts/install-claude-skills.ps1
./scripts/install-claude-skills.ps1 -Skills @('miica-plan','miica-fix-issue','miica-documentation','miica-knowledge','miica-analyse','miica-implementation')
```

```bash
./scripts/install-claude-skills.sh
./scripts/install-claude-skills.sh "" miica-plan miica-fix-issue miica-documentation miica-knowledge miica-analyse miica-implementation
```

Default install target:
- `~/.claude/skills`
- or `$CLAUDE_HOME/skills` if `CLAUDE_HOME` is set

### 4. Global `.agents` skills

Use this when you want the same commands in `.agents`-style environments.

```bash
npx @hrica/miica-kit install-agent-skills
pnpm dlx @hrica/miica-kit install-agent-skills --skills miica-plan,miica-fix-issue,miica-documentation,miica-knowledge,miica-analyse,miica-implementation
bunx @hrica/miica-kit install-agent-skills
```

Native scripts:

```powershell
./scripts/install-agent-skills.ps1
./scripts/install-agent-skills.ps1 -Skills @('miica-plan','miica-fix-issue','miica-documentation','miica-knowledge','miica-analyse','miica-implementation')
```

```bash
./scripts/install-agent-skills.sh
./scripts/install-agent-skills.sh "" miica-plan miica-fix-issue miica-documentation miica-knowledge miica-analyse miica-implementation
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
npx @hrica/miica-kit uninstall-codex-skills --skills miica-plan,miica-fix-issue
npx @hrica/miica-kit uninstall-claude-skills --skills miica-plan,miica-fix-issue
npx @hrica/miica-kit uninstall-agent-skills --skills miica-plan,miica-fix-issue
```

You can omit `--skills` to remove the whole `miica-*` surface from that target environment.

## How The Commands Behave

### `miica-plan`

Use it for planning, scoping, sequencing, architecture direction, or design direction.

Important behavior:
- it is a hard phase boundary
- it should stop after the plan unless the same message explicitly asks to continue

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

Use it for knowledge bases, explainers, primers, and topic guides.

Important behavior:
- research and verify when the topic depends on current tools, policies, or platform behavior
- structure the output for mixed audiences instead of writing one giant wall of text
- separate facts, recommendations, and uncertainty

### `miica-analyse`

Use it for read-only investigation, review, diagnosis, or comparison.

Important behavior:
- it is read-only by default
- it should not silently drift into implementation unless the same message asks it to continue

### `miica-implementation`

Use it for end-to-end feature work.

Important behavior:
- it should do only the planning the task actually needs
- then implementation, review, QA, verification, and docs sync when warranted

## What Stayed From The Original Workflow

Internally, the workflow still preserves what actually matters:
- scope challenge before medium or large work
- engineering review before risky implementation
- design planning for user-facing work
- research and source verification for educational outputs
- debug before patch
- review for production risk
- browser QA as evidence
- docs sync as part of shipping

The difference is that you do not have to think in fifteen micro-modes every day.

## Repository Structure

- [`AGENTS.md`](./AGENTS.md): always-on `miica-se` posture plus the six-command model
- [`MEMORY.md`](./MEMORY.md): durable repo memory and installer invariants
- [`CHANGELOG.md`](./CHANGELOG.md): notable kit changes
- [`ROLES.md`](./ROLES.md): extracted internal roles from the original workflow
- [`WORKFLOW.md`](./WORKFLOW.md): public workflow and command-routing rules
- [`skills/`](./skills): six portable public commands
- [`codex-skills/`](./codex-skills): six installable skill folders for Codex and `.agents`
- [`claude-skills/`](./claude-skills): six installable skill folders for Claude
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

## License

This project is licensed under the MIT License. See [LICENSE](./LICENSE).

## Practical Rule

Do not treat this repo as a framework.
Treat it as a compact operating system for agentic software delivery.
