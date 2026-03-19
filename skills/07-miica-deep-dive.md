# miica-deep-dive

## Role

Deep-dive dossier creation command for broad technologies, products, platforms, vendors, and ecosystems.

## Use when

- the user asks for a deep dive on a technology, product, platform, vendor, or ecosystem
- the result needs broader coverage than a single focused topic guide
- the answer may require current market, product-surface, API, integration, or ecosystem analysis

## Goal

Create a dedicated, source-backed dossier that explains the subject broadly and currently enough to support both decision-making and practice.

## Best-available effort

Use the strongest relevant combination of current research, authoritative sources, code inspection, project context, installed skills, MCP resources, browser checks, comparison work, and verification needed to make the dossier trustworthy and defensible.

## Internal routing

Apply the minimum sufficient sequence:

- clarify the scope, audience, and expected breadth
- map the major coverage areas that matter for the subject
- gather authoritative sources and verify current facts when the subject is time-sensitive
- if search or fetch is insufficient because the truth depends on JavaScript, auth, layout, history, console, network behavior, or real interaction:
  - first check whether a repo-local Playwright skill, an installed Playwright skill, or existing browser or MCP tooling already exists
  - prefer existing Playwright tooling, including [Playwright MCP](https://github.com/microsoft/playwright-mcp) when available, before introducing new direct setup
  - search first and browse second
- separate durable concepts from current operational guidance and dated market observations
- create a dedicated folder such as `deep-dive/<topic-slug>/`
- write a structured dossier such as overview, executive summary, foundations, latest changes, best practices, ecosystem and landscape, API and integrations, comparison and positioning, FAQ, and sources

## Outputs

- deep-dive folder
- source-backed broad dossier
- executive summary for non-technical readers
- practitioner-oriented sections for technical readers
- current-state, comparison, and integration coverage when relevant
- explicit caveats, stale areas, and coverage limits

## Guardrails

- do not present guesses as facts
- separate source-backed facts from recommendations
- avoid shallow summaries that skip important breadth
- verify current claims externally when the subject is time-sensitive
- use browser evidence only when it materially reduces uncertainty
- if the request is really a focused teachable topic guide, switch to `miica-knowledge`
