# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project aims to follow Semantic Versioning once versioned releases begin.

## [Unreleased]

### Fixed
- Publishing metadata now points to the actual GitHub repository `h-rica/miica-kit` instead of the old `miica-labs` path.
- Publishing instructions now document npm's current requirement for account 2FA or a granular token with `Bypass 2FA`, clarify that trusted publishing comes after the first successful manual publish, include the exact `npm trust github` setup and verification commands, add a minimal release runbook, document the GitHub Actions permission needed for `release-please` to open PRs, keep license metadata aligned with the chosen MIT license, and now describe the `release-please` based release flow.

### Added
- Six-command public skill surface: `miica-plan`, `miica-fix-issue`, `miica-documentation`, `miica-knowledge`, `miica-analyse`, and `miica-implementation`.
- New `miica-knowledge` portable and installable skill surfaces for teachable, source-backed knowledge-base creation.
- Canonical `knowledge-base/npm-package-publishing-with-github-actions/` example with layered outputs, dated sources, and a root README link so the repo now shows what `miica-knowledge` actually produces.
- Project and global installers now support the simplified `miica-*` command model.
- Symmetric uninstall commands for project-local installs, Codex skills, Claude skills, and `.agents` skills.
- A `claude-skills/` surface mirroring the installable `miica-*` skill folders for Claude.
- Project-local installs now write `.agent-kit/install-state.env` plus install snapshots so uninstall can safely remove kit-owned files or restore pre-kit backups.

### Changed
- `miica-se` is now an always-on posture inside `AGENTS.md` and project templates instead of a separate public skill.
- The old phase-by-phase internal skills are no longer the public install surface.
- README, workflow docs, and project instructions now route work through the six-command model.
- Public package and CLI naming now use `miica-kit`.
- Every `miica-*` command now encodes a best-available effort rule so agents are expected to use the strongest relevant combination of tools, evidence, and verification available in their environment.
- Project uninstall is now conservative with root docs: unchanged kit-managed files are removed or restored, changed files are left in place with manual follow-up guidance.

### Preserved
- The internal planning, debug, review, QA, and ship discipline from the original workflow remains the decision engine behind the new commands.
