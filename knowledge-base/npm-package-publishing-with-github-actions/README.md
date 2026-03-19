# npm Package Publishing with GitHub Actions

This is a canonical `miica-knowledge` example.

It explains how to publish an npm package with GitHub Actions in a way that works for both non-technical and technical readers.

## What This Folder Proves

- `miica-knowledge` can produce a dedicated knowledge base instead of one long generic memo.
- The same topic can be explained at two levels without talking down to either audience.
- Current platform guidance can be turned into clear, defensible recommendations.

## Quick Answer

### Facts

- npm is the registry that package managers such as `npm`, `npx`, `bunx`, and `pnpm dlx` rely on for package distribution.
- GitHub Actions can automate npm publishing.
- As of March 19, 2026, npm recommends trusted publishing with OIDC for CI/CD publishing when GitHub-hosted runners are available.

### Recommendations

- Use trusted publishing for normal releases.
- Keep a separate first-publish path for a brand-new package.
- Treat long-lived publish tokens as a fallback, not the default.

### Limits

- Trusted publishing does not cover every npm command.
- Self-hosted runners are not supported for npm trusted publishing today.
- Provenance is not generated for packages published from private repositories.

## File Map

- [executive-summary.md](./executive-summary.md): the business and decision layer
- [practitioner-guide.md](./practitioner-guide.md): the build-and-ship layer
- [glossary.md](./glossary.md): plain-language definitions
- [faq.md](./faq.md): objections, mistakes, and recurring confusion
- [sources.md](./sources.md): dated sources and verification notes

## Recommended Reading Order

1. Start with [executive-summary.md](./executive-summary.md) if you need the decision in plain language.
2. Go to [practitioner-guide.md](./practitioner-guide.md) if you need to implement the workflow.
3. Use [glossary.md](./glossary.md) and [faq.md](./faq.md) when the topic gets stuck on vocabulary or edge cases.
4. Use [sources.md](./sources.md) when you need to defend the guidance in review.

## Scope Of This Example

This knowledge base covers:

- why a team would automate npm publishing
- the current recommended path
- the practical fallback path
- common failure modes
- the minimum source set needed to defend the guidance

This knowledge base does not cover:

- release-note automation in depth
- GitHub Packages as a registry target
- monorepo release orchestration
- semantic-release, changesets, or release-please setup details
