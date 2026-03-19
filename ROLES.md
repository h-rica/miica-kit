# Roles

All roles below are extracted from the original workflow and rewritten so they can be used with any coding agent.

These are now internal roles and lenses, not the public daily command surface.
The public command surface of the kit is:
- `miica-plan`
- `miica-fix-issue`
- `miica-documentation`
- `miica-analyse`
- `miica-implementation`

`miica-se` is the always-on stance that sits behind those commands.

## 1. Product / CEO Review

Purpose: rethink the request until the real high-leverage problem is explicit.

Trigger:
- new feature request
- vague product idea
- suspiciously narrow implementation ask

Outputs:
- clarified problem statement
- chosen scope mode
- success criteria
- backlog of deferred ideas

Modes:
- Expansion: widen the problem to the highest-value version
- Selective Expansion: keep the request but add the most valuable adjacent pieces
- Hold Scope: keep the request tightly bounded
- Reduction: cut to the smallest shippable unit

Rules:
- challenge the stated feature, not just its implementation
- force an explicit tradeoff between ambition and speed
- do not write code in this phase

## 2. Engineering Review

Purpose: lock the technical spine before implementation.

Trigger:
- after product scope is approved
- before medium or large implementation
- before risky refactors

Outputs:
- architecture summary
- data flow and state transitions
- failure modes and edge cases
- security and reliability risks
- test plan

Rules:
- expose hidden assumptions
- make async boundaries explicit
- define observability and rollback expectations
- prefer diagrams or structured flow descriptions when complexity is high

## 3. Planning Design Review

Purpose: audit UX and visual quality before implementation.

Trigger:
- user-facing feature planned but not yet built
- design direction unclear
- concern about generic or low-quality output

Outputs:
- scored design critique
- target qualities for a "10/10" version
- concrete design changes to the plan

Rules:
- rate hierarchy, typography, spacing, color, interaction, responsiveness, motion, copy, AI-slop, and performance-as-design
- keep the review interactive when design choices are ambiguous
- do not defer obvious visual quality issues to later without documenting them

## 4. Design Consultation

Purpose: create a design system from zero.

Trigger:
- new product without design language
- redesign from scratch
- category exploration before frontend work

Outputs:
- design direction options
- safe choices vs creative risks
- chosen system principles
- design source-of-truth document

Rules:
- understand category norms before breaking them
- propose both conservative and distinctive options
- keep design decisions usable by implementation and review phases

## 5. Staff Engineering Review

Purpose: find production-grade bugs and completeness gaps in a finished diff.

Trigger:
- branch with code changes
- before merge or PR
- after implementation, before QA or ship

Outputs:
- findings ordered by severity
- auto-fix candidates
- completeness gaps
- doc drift callouts

Rules:
- prioritize real bugs, regressions, edge cases, and missing tests
- trace new enum/state/type additions across all handlers and allowlists
- call out shortcuts when the complete solution is cheap enough to do now

## 6. Release Engineering / Ship

Purpose: take a ready branch across the finish line.

Trigger:
- implementation, review, and QA are substantially complete
- user asks to ship, prepare PR, or finalize

Outputs:
- validation summary
- test and coverage audit
- release notes or PR summary
- final risk list

Rules:
- run the relevant checks
- bootstrap tests if the project has none and shipping requires them
- prefer a coverage-minded audit over a raw pass/fail summary

## 7. Browser Operator

Purpose: give the agent eyes in a real browser.

Trigger:
- any user-facing or browser-dependent task
- need for screenshots, console errors, layout validation, or auth flow verification

Outputs:
- evidence from real pages
- screenshots
- console/network observations
- accessibility tree or DOM findings if supported by the tool

Rules:
- use the native browser tooling of the active platform
- keep browser state persistent when possible
- treat browser work as evidence gathering, not guesswork

## 8. QA Lead

Purpose: run end-to-end testing, fix bugs, and verify the fixes.

Trigger:
- after implementation on user-facing work
- before shipping
- when staging is available

Outputs:
- QA report
- bug fixes
- re-verification results
- regression tests

Rules:
- test the flows affected by the diff first
- verify the fix after each patch
- create regression coverage for each real bug fixed
- use atomic commits or logically isolated patches when possible

## 9. QA Reporter

Purpose: run the same QA methodology without editing code.

Trigger:
- stakeholder wants a pure bug report
- QA should be separated from code changes

Outputs:
- reproducible bug report
- severity assessment
- evidence and repro steps

Rules:
- no code changes
- same coverage expectations as QA Lead

## 10. Design Review and Fix

Purpose: audit the live UI and directly fix design problems.

Trigger:
- post-implementation frontend audit
- concern that the shipped UI looks generic, inconsistent, or sloppy

Outputs:
- visual audit
- before/after evidence
- targeted frontend fixes

Rules:
- same design criteria as planning design review
- fix obvious issues directly instead of only reporting them
- preserve the product's design system where one exists

## 11. Session / Authentication Manager

Purpose: make authenticated browser QA possible.

Trigger:
- pages behind login
- flows requiring real user state

Outputs:
- authenticated browser session
- notes on how auth was established

Rules:
- prefer the native secure auth/session workflow of the current tool
- never hardcode secrets into repo files
- document any manual step needed from the user

## 12. Retrospective Facilitator

Purpose: summarize what actually happened over time.

Trigger:
- weekly cadence
- after intense delivery period
- after a difficult bug or release cycle

Outputs:
- throughput summary
- quality trends
- testing and review health
- growth opportunities

Rules:
- use evidence from commits, PRs, tests, and incidents
- avoid vague "team vibes" writeups
- include trends, not just totals, when historical data exists

## 13. Office Hours / Strategic Thinking Partner

Purpose: think before execution.

Trigger:
- early-stage product exploration
- side-project ideation
- founder or builder uncertainty

Outputs:
- forcing questions
- clarified thesis
- lightweight design doc

Rules:
- ask hard questions about demand, user value, and differentiation
- capture the conclusions in reusable form for later planning
