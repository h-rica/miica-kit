# Workflow

This is the public operating model for the kit.

## Public command surface

The kit intentionally exposes only eleven commands:

1. `miica-plan`
2. `miica-architecture`
3. `miica-fix-issue`
4. `miica-documentation`
5. `miica-knowledge`
6. `miica-deep-dive`
7. `miica-analyse`
8. `miica-review`
9. `miica-implementation`
10. `miica-git`
11. `miica-execute-plan`

`miica-se` is always on as the default stance behind every command.

## Internal phase model

The workflow still preserves the useful internal ideas:
- scope challenge when the request is fuzzy or product-facing
- engineering review when the change is risky or non-trivial
- design planning when users will directly experience the result
- implementation-plan creation when the user wants a buildable plan artifact from settled inputs
- reference-driven UI guide extraction when the user provides inspiration sites, screenshots, recordings, or Figma links
- research and source verification when the outcome is educational or dossier-driven
- debug before patch
- review for production risk, not style theater
- browser QA when behavior is user-facing
- documentation sync when shipped reality changed
- git state inspection before branching, committing, or drafting PR content, with commit slices grouped into coherent small units

The public commands decide which of these lenses to combine. Do not force every phase on every task.

## Routing rules

Use the smallest sufficient command:

- planning, scoping, or implementation-plan request from settled inputs: `miica-plan`
- architecture document or system design request: `miica-architecture`
- backend-only or frontend bug: `miica-fix-issue`
- docs-only change: `miica-documentation`
- knowledge base, explainer, primer, or focused learning dossier: `miica-knowledge`
- broad, current deep dive on a technology, product, platform, vendor, or ecosystem: `miica-deep-dive`
- investigation, diagnosis, or comparison request: `miica-analyse`
- code review or diff review request: `miica-review`
- feature or behavior change: `miica-implementation`
- git branch creation, commit creation, or pull request draft request: `miica-git`
- existing tracked plan or `do next step` / `continue active step` request: `miica-execute-plan`

## Hard boundaries

- `miica-plan` stops after the plan or plan artifact unless the same user message explicitly asks to continue.
- `miica-architecture` stops after the architecture unless the same user message explicitly asks to continue.
- `miica-analyse` is read-only unless the same user message explicitly asks to continue.
- `miica-review` is findings-only and read-only unless the same user message explicitly asks to continue.

## Essential invariants

### 1. Scope is part of engineering quality

Do not jump into code when the real problem, the right abstraction level, or the smallest shippable scope is still unclear.

### 2. The browser is evidence

For user-facing software, use a real browser whenever possible. Do not guess about layout, auth flows, redirects, empty states, or console failures if the tool can inspect them directly.

### 3. References are inputs, not decoration

When a user supplies websites, screenshots, recordings, or Figma links for UI work, inspect them and turn them into a strict guide before inventing details in prose.

### 4. Debug before patch

No blind fixes. Investigate first, prove the cause, then patch.

### 5. Review for production risk

Prioritize:
- regressions
- unhandled states
- race conditions
- missing validation
- broken data flows
- missing tests
- completeness gaps

### 6. QA fixes require regression coverage

If QA finds and fixes a real bug, add a regression test when the project supports it.

### 7. Shipping includes honest coverage judgment

A branch is not done just because commands are green. Audit what changed and whether validation actually covered it.

### 8. Docs are part of the release

README, MEMORY, CHANGELOG, architecture notes, and testing docs should match the shipped code.
