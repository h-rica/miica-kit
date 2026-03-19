# Executive Summary

This topic is about one simple outcome: when you decide a package is ready, GitHub should publish it to npm in a repeatable and secure way.

## The Decision In One Paragraph

For most teams, the right default is to publish from GitHub Actions using npm trusted publishing with OIDC on GitHub-hosted runners. It is safer than storing a long-lived npm publish token, easier to audit, and easier to explain to stakeholders. For a brand-new package, you may still need one initial manual publish before you can attach the trusted publisher relationship. If your setup cannot use trusted publishing, use a granular token as a fallback and lock it down aggressively.

## Why This Matters To A CEO, PM, Or Client

- It reduces release risk by making publishing repeatable.
- It reduces secret-management risk by removing or shrinking the need for long-lived publish credentials.
- It creates a clearer audit trail around what was published, from where, and by which workflow.
- It lowers the chance that shipping depends on one developer's laptop state.

## Facts

- npm now recommends trusted publishing instead of access tokens for package publishing from CI/CD when a supported provider is available.
- GitHub-hosted runners are supported for npm trusted publishing. Self-hosted runners are not currently supported.
- Scoped public packages need explicit public access on first publish.
- Trusted publishing only solves the `publish` step. It does not automatically solve private dependency installs or every other npm command.
- npm provenance gives a verifiable link between a published package and the build that produced it, but it does not prove the package is safe or bug-free.

## Recommendations

- Choose trusted publishing as the normal release path.
- Standardize on one publish workflow file and keep its filename stable.
- Use a cloud-hosted runner for the publish job even if the rest of your CI is more custom.
- Keep the first release deliberately manual if the package does not exist yet.
- Add a simple smoke test after publish so success is measured by actual installability, not just a green workflow.

## Limits And Tradeoffs

- Trusted publishing is stricter than token publishing. Exact workflow name, repository, and runner type matter.
- If you publish from a private repository, npm provenance will not be generated.
- Some official examples still show older patterns with `NPM_TOKEN` and older `setup-node` versions. That does not make them wrong, but it does mean teams should choose one current standard instead of copy-pasting mixed examples.

## Practical Recommendation

If the team needs one policy sentence, use this:

> Publish npm packages from GitHub Actions with trusted publishing on GitHub-hosted runners. Use a granular token only when trusted publishing is unavailable.

That policy is easy to explain, defend, and operationalize.
