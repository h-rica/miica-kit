# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project aims to follow Semantic Versioning once versioned releases begin.

## [0.3.0](https://github.com/h-rica/miica-kit/compare/v0.2.3...v0.3.0) (2026-03-19)


### Features

* add deep dive command ([64ca230](https://github.com/h-rica/miica-kit/commit/64ca2307669f1bbc5581eea72fae885fe99f4a19))

## [0.2.3](https://github.com/h-rica/miica-kit/compare/v0.2.2...v0.2.3) (2026-03-19)


### Bug Fixes

* update workflow checkout action ([f983141](https://github.com/h-rica/miica-kit/commit/f983141bfa471bac8685ffb370dd02cdc3be748d))

## [0.2.2](https://github.com/h-rica/miica-kit/compare/v0.2.1...v0.2.2) (2026-03-19)


### Bug Fixes

* align npm publish workflows ([c99bf3c](https://github.com/h-rica/miica-kit/commit/c99bf3cd3a5ec3cf58424e24d505e950264f8a64))

## [0.2.1](https://github.com/h-rica/miica-kit/compare/v0.2.0...v0.2.1) (2026-03-19)


### Bug Fixes

* repair docs release override ([1012672](https://github.com/h-rica/miica-kit/commit/101267217b048c080c0b30bd4abf1ce9f38b4590))
* trigger releases for docs changes ([ad5e393](https://github.com/h-rica/miica-kit/commit/ad5e393d1c763579081ab2d6023b6783b0f71f0a))

## [0.2.0](https://github.com/h-rica/miica-kit/compare/v0.1.1...v0.2.0) (2026-03-19)


### Features

* add knowledge skill ([6e41dde](https://github.com/h-rica/miica-kit/commit/6e41dde8c67172a99b405ba45a5cde7f7a4a0847))

## [Unreleased]

### Fixed
- Publishing metadata now points to the actual GitHub repository `h-rica/miica-kit` instead of the old `miica-labs` path.
- Publishing instructions now document npm's current requirement for account 2FA or a granular token with `Bypass 2FA`, clarify that trusted publishing comes after the first successful manual publish, include the exact `npm trust github` setup and verification commands, add a minimal release runbook, document the GitHub Actions permission needed for `release-please` to open PRs, keep license metadata aligned with the chosen MIT license, and now describe the `release-please` based release flow.
- The docs-only release override in `.github/workflows/release-please.yml` no longer uses bash regex parsing that fails under GitHub Actions.
- The release and fallback publish workflows now use `actions/setup-node@v6` so npm publish runs match the current action major version documented by the project.
- The release and fallback publish workflows now use `actions/checkout@v5` so the publish path no longer relies on the deprecated Node 20 checkout action.

### Added
- Seven-command public skill surface: `miica-plan`, `miica-fix-issue`, `miica-documentation`, `miica-knowledge`, `miica-deep-dive`, `miica-analyse`, and `miica-implementation`.
- New `miica-knowledge` portable and installable skill surfaces for teachable, source-backed knowledge-base creation.
- New `miica-deep-dive` portable and installable skill surfaces for broad, current, dossier-style research on technologies, products, platforms, vendors, and ecosystems.
- Canonical `knowledge-base/npm-package-publishing-with-github-actions/` example with layered outputs, dated sources, and a root README link so the repo now shows what `miica-knowledge` actually produces.
- Project and global installers now support the simplified `miica-*` command model.
- Symmetric uninstall commands for project-local installs, Codex skills, Claude skills, and `.agents` skills.
- A `claude-skills/` surface mirroring the installable `miica-*` skill folders for Claude.
- Project-local installs now write `.agent-kit/install-state.env` plus install snapshots so uninstall can safely remove kit-owned files or restore pre-kit backups.

### Changed
- `miica-se` is now an always-on posture inside `AGENTS.md` and project templates instead of a separate public skill.
- The old phase-by-phase internal skills are no longer the public install surface.
- README, workflow docs, and project instructions now route work through the seven-command model.
- Public package and CLI naming now use `miica-kit`.
- Every `miica-*` command now encodes a best-available effort rule so agents are expected to use the strongest relevant combination of tools, evidence, and verification available in their environment.
- Project uninstall is now conservative with root docs: unchanged kit-managed files are removed or restored, changed files are left in place with manual follow-up guidance.
- The `release-please` workflow now treats `docs:` commits as patch-release triggers when no `feat`, `fix`, or `deps` commits are present since the last tag.

### Preserved
- The internal planning, debug, review, QA, and ship discipline from the original workflow remains the decision engine behind the new commands.
