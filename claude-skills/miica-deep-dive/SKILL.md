---
name: miica-deep-dive
description: Use when the user wants a deep dive on a technology, product, platform, vendor, or ecosystem. Combines broad research, current verification, browser-based inspection when needed, and structured synthesis into a comprehensive dossier.
---

# miica-deep-dive

Use this command to create a comprehensive deep-dive dossier.

`miica-se` posture is always on in this kit. Keep the work current, source-backed, broad enough to be useful, and explicit about uncertainty.

## Goal

Create a dedicated dossier that helps readers understand an entire technology, product, platform, vendor, or ecosystem, not just one narrow technical or functional case.

## Best-available effort

Use the strongest relevant combination of current research, authoritative sources, code inspection, project context, installed skills, MCP resources, browser checks, market and ecosystem comparison, and verification needed to make the dossier trustworthy and useful.

Do not stop at a plausible summary when the subject needs broader coverage, fresher evidence, better comparison, or real browser inspection of dynamic pages.

## Workflow

1. Clarify the scope, audience, and coverage breadth enough to act.
2. Map the major coverage areas that matter, such as foundations, current state, ecosystem or product surface, APIs and integrations, best practices, risks, and comparisons.
3. Gather authoritative sources and verify current facts when the subject is time-sensitive.
4. If simple search or fetch is insufficient because the truth depends on JavaScript, auth, layout, history, console, network behavior, or real interaction:
   - first check whether a repo-local Playwright skill, an installed Playwright skill, or existing browser or MCP tooling is already available
   - prefer existing Playwright tooling, including [Playwright MCP](https://github.com/microsoft/playwright-mcp) when available, before introducing new direct setup
   - search first and browse second
5. Separate durable concepts from current operational guidance and dated market observations.
6. Create a dedicated folder such as `deep-dive/<topic-slug>/`.
7. Write a structured dossier, for example:
   - `README.md`
   - `executive-summary.md`
   - `foundations.md`
   - `latest-changes.md`
   - `best-practices.md`
   - `ecosystem-and-landscape.md`
   - `api-and-integrations.md`
   - `comparison-and-positioning.md`
   - `faq.md`
   - `sources.md`
8. State caveats, tradeoffs, stale areas, and coverage limits honestly.

## Guardrails

- do not present guesses as facts
- separate facts, recommendations, and uncertainty clearly
- avoid shallow summaries that skip important breadth
- verify current claims externally when the subject is time-sensitive
- use browser evidence only when it materially reduces uncertainty
- if the request is really a focused teachable topic guide, switch to `miica-knowledge`
