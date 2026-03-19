# Sources

This file records the sources used for this knowledge base and how they were interpreted.

Access date for this source check: **March 19, 2026**.

## Primary Sources

### 1. npm Docs: Trusted publishing for npm packages

- URL: <https://docs.npmjs.com/trusted-publishers/>
- Type: primary vendor documentation
- Why it matters:
  - confirms GitHub Actions trusted publishing support
  - confirms GitHub-hosted runners are required
  - provides the current OIDC-based GitHub Actions example
  - documents current limitations such as self-hosted runner support and private-repo provenance limits
- Key points used:
  - trusted publishing supports GitHub Actions on GitHub-hosted runners
  - `id-token: write` is the critical GitHub Actions permission
  - a package can only have one trusted publisher configuration at a time
  - trusted publishing only covers publish, not every npm command
  - provenance is not generated for private repositories
- Verification note:
  - This is the strongest source for the recommended steady-state release path.

### 2. npm Docs: Using private packages in a CI/CD workflow

- URL: <https://docs.npmjs.com/using-private-packages-in-a-ci-cd-workflow/>
- Type: primary vendor documentation
- Last edited on page: December 10, 2025
- Why it matters:
  - states npm's current recommendation to prefer trusted publishing over access tokens
  - explains when token-based publishing is still needed
  - clarifies the security posture for granular tokens and `Bypass 2FA`
- Key points used:
  - use trusted publishing when available
  - use read-only tokens for installs when possible
  - use granular write tokens with `Bypass 2FA` only when automation truly needs them
  - legacy access tokens were removed in November 2025

### 3. npm Docs: About access tokens

- URL: <https://docs.npmjs.com/about-access-tokens/>
- Type: primary vendor documentation
- Last edited on page: December 9, 2025
- Why it matters:
  - confirms that only granular access tokens remain supported
  - documents `Bypass 2FA` behavior
- Key points used:
  - legacy access tokens are gone
  - granular tokens can carry write access and optional `Bypass 2FA`
  - `Bypass 2FA` should be treated as a high-risk capability

### 4. npm Docs: Generating provenance statements

- URL: <https://docs.npmjs.com/generating-provenance-statements/>
- Type: primary vendor documentation
- Last edited on page: August 4, 2025
- Why it matters:
  - explains what provenance does and does not prove
  - documents first-publish `--access public`
  - states that trusted publishing auto-generates provenance
- Key points used:
  - provenance improves traceability, not package correctness
  - `repository.url` needs to match the public source repository
  - use `--provenance --access public` for first publish in token-based workflows

### 5. npm Docs: npm trust

- URL: <https://docs.npmjs.com/cli/v11/commands/npm-trust/>
- Type: primary vendor CLI documentation
- Why it matters:
  - defines the hard prerequisites for CLI-based trust setup
- Key points used:
  - `npm@11.10.0+` is required
  - account-level 2FA is required
  - the package must already exist on the npm registry
  - only one trust relationship can be configured per package at a time

### 6. GitHub Docs: Publishing Node.js packages

- URL: <https://docs.github.com/en/actions/tutorials/publish-packages/publish-nodejs-packages>
- Type: primary vendor documentation
- Why it matters:
  - shows GitHub's official npm publish workflow shape
  - confirms the need for `registry-url: https://registry.npmjs.org`
  - confirms the `id-token: write` permission in GitHub's own example
- Key points used:
  - GitHub still documents a token-based npm example
  - the registry URL must be set correctly in `setup-node`
- Verification note:
  - This page is useful, but its example is older than npm's newer trusted-publishing guidance. It was used as a compatibility reference, not as the final recommendation source.

### 7. GitHub repository: actions/setup-node

- URL: <https://github.com/actions/setup-node>
- Type: primary action documentation
- Why it matters:
  - shows the current supported major version of the action
  - documents breaking changes relevant to copied older examples
- Key points used:
  - current README examples use `actions/setup-node@v6`
  - the `always-auth` input was removed in v6
- Verification note:
  - This source was used to modernize the workflow example away from older v4-era snippets.

## Local Repo Source

### 8. Repository guide: `PUBLISHING.md`

- URL: [PUBLISHING.md](../../PUBLISHING.md)
- Type: local repo documentation
- Why it matters:
  - keeps this example grounded in a real repository that already ships npm publishing guidance
- Key points used:
  - keep a distinct first-publish path
  - smoke test the published package after release
  - prefer `npm pack --dry-run` before publish

## Cross-Source Interpretation

### Facts

- npm's current direction is clear: trusted publishing is the preferred path for supported CI/CD platforms.
- Token publishing is still valid, but now clearly secondary.

### Recommendations

- The canonical workflow in this knowledge base uses `actions/setup-node@v6` plus OIDC and no publish token.
- The first publish remains a separate step for new packages.

### Limits

- GitHub's publishing tutorial and npm's newer trusted-publishing docs are not perfectly aligned.
- The recommendation to standardize on `setup-node@v6` with trusted publishing is an inference from multiple primary sources, not a single copy-paste example from one page.
