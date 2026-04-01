# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project aims to follow Semantic Versioning once versioned releases begin.

## [0.5.1](https://github.com/h-rica/miica-kit/compare/v0.5.0...v0.5.1) (2026-03-30)


### Bug Fixes

* guard release workflow ([d055e6f](https://github.com/h-rica/miica-kit/commit/d055e6ff2c3748c8bfda6e0eec462cf6a5f709c3))

## [0.5.0](https://github.com/h-rica/miica-kit/compare/v0.4.0...v0.5.0) (2026-03-30)


### Features

* expand public command surface ([e9bcdf4](https://github.com/h-rica/miica-kit/commit/e9bcdf4e5650e3c57a45526d71540bb47b98597c))
* expand public command surface ([de6b090](https://github.com/h-rica/miica-kit/commit/de6b09074282c852bf8d0bca8968c01eb39b1526))


### Bug Fixes

* enrich release pr descriptions ([d9ab396](https://github.com/h-rica/miica-kit/commit/d9ab3962a33ba2fdc942e94dfc32c3411bc3a6b4))

## [0.4.0](https://github.com/h-rica/miica-kit/compare/v0.3.0...v0.4.0) (2026-03-20)


### Features

* **internal:** add ui reference guide phase ([6914a56](https://github.com/h-rica/miica-kit/commit/6914a56a5beaf30eeecc59f475d1202b6041def6))

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
- Release maintenance now fails fast when `release-please` skips a releasable merge because `main` received a default GitHub merge-commit subject instead of a Conventional Commit.

### Added
- Eleven-command public skill surface: `miica-plan`, `miica-architecture`, `miica-fix-issue`, `miica-documentation`, `miica-knowledge`, `miica-deep-dive`, `miica-analyse`, `miica-review`, `miica-implementation`, `miica-git`, and `miica-execute-plan`.
- New `miica-architecture` portable and installable skill surfaces for turning settled requirements into buildable architecture documents.
- New `miica-review` portable and installable skill surfaces for findings-only code review of diffs, commits, and focused areas.
- New `miica-git` portable and installable skill surfaces for branch creation, commit creation, and pull request drafting from real git state.
- New `miica-execute-plan` portable and installable skill surfaces for step-by-step execution of tracked development plans.
- New `miica-knowledge` portable and installable skill surfaces for teachable, source-backed knowledge-base creation.
- New `miica-deep-dive` portable and installable skill surfaces for broad, current, dossier-style research on technologies, products, platforms, vendors, and ecosystems.
- New internal `phase-ui-reference-guide` maintenance skill plus shipped UI guide template and JSON schema for reference-driven design extraction from websites, screenshots, recordings, and Figma links.
- Canonical `knowledge-base/npm-package-publishing-with-github-actions/` example with layered outputs, dated sources, and a root README link so the repo now shows what `miica-knowledge` actually produces.
- Project and global installers now support the simplified `miica-*` command model.
- Symmetric uninstall commands for project-local installs, Codex skills, Claude skills, and `.agents` skills.
- Native `OpenCode` install and uninstall commands plus shell and PowerShell wrappers targeting `~/.config/opencode/skills` or `$OPENCODE_CONFIG_DIR/skills` while reusing the Codex-compatible skill surface.
- `install-kit` now supports `--mode full` and `--tools codex,claude,opencode` so one command can combine project-local setup with native global skill bootstrapping.
- A `claude-skills/` surface mirroring the installable `miica-*` skill folders for Claude.
- Project-local installs now write `.agent-kit/install-state.env` plus install snapshots so uninstall can safely remove kit-owned files or restore pre-kit backups.
- A `Conventional PR Title` workflow now blocks non-Conventional-Commit pull request titles before they can land on `main` with release-breaking merge metadata.

### Changed
- `miica-se` is now an always-on posture inside `AGENTS.md` and project templates instead of a separate public skill.
- The always-on `miica-se` posture now explicitly requires local-first evidence gathering, selective current-standard verification, assumption and dependency surfacing, paced clarification, and short closure summaries for risky work.
- The always-on `miica-se` posture is now explicitly grounded in the Universal Sovereign Code Manifesto and its seven pillars: Ground, Logic, Insight, Soul, Form, Sovereignty, and Responsibility.
- The old phase-by-phase internal skills are no longer the public install surface.
- README, workflow docs, and project instructions now route work through the eleven-command model.
- Architecture design and code review now have dedicated public commands instead of being folded into `miica-plan` and `miica-analyse`.
- Git workflow tasks now have a dedicated `miica-git` command that auto-routes among branch, commit, and PR drafting work.
- Tracked plan execution now uses `plan-backlog.md`, `plan-in-progress.md`, and `plan-completed.md` across the shipped docs and skill surfaces.
- Commit-generation guidance now expects coherent small commit slices instead of one broad commit when the diff spans multiple units of work.
- The release-please workflow now appends a short changelog brief to release PR bodies by summarizing the `CHANGELOG.md` section generated in the PR diff.
- `miica-plan` now supports implementation-plan creation from settled requirements and architecture, while `miica-execute-plan` owns tracked-plan execution.
- `miica-plan` and `miica-implementation` now treat reference-driven UI work as a first-class internal capability, requiring strict guide extraction before implementation when the user supplies inspiration links instead of clear prose specs.
- Public package and CLI naming now use `miica-kit`.
- Every `miica-*` command now encodes a best-available effort rule so agents are expected to use the strongest relevant combination of tools, evidence, and verification available in their environment.
- Project uninstall is now conservative with root docs: unchanged kit-managed files are removed or restored, changed files are left in place with manual follow-up guidance.
- The `release-please` workflow now treats `docs:` commits as patch-release triggers when no `feat`, `fix`, or `deps` commits are present since the last tag.

### Preserved
- The internal planning, debug, review, QA, and ship discipline from the original workflow remains the decision engine behind the new commands.
