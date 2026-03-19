# Publishing

This file explains how to publish `@hrica/miica-kit` so people can run it directly with:
- `npx @hrica/miica-kit ...`
- `bunx @hrica/miica-kit ...`
- `pnpm dlx @hrica/miica-kit ...`

This guide uses `pnpm dlx`, because that is the documented pnpm command. If your machine exposes `pnpx`, it maps to the same idea.

## The Important Truth First

You only need to publish to the **npm registry** for all three of those commands to work.

- `npx` pulls from npm
- `bunx` runs packages from npm
- `pnpm dlx` also runs packages from npm

So there is no separate Bun registry or pnpm registry publish step for this package.

## Minimal Release Runbook

For normal releases, once `release-please` and trusted publishing are configured, use this flow:

1. Merge conventional commits into `main`.
2. Wait for the `Release Please` workflow to open or update the release PR.
3. Review and merge that release PR when you want to ship.
4. Verify the `Release Please` workflow succeeded and the new version is visible on `https://www.npmjs.com/package/@hrica/miica-kit`.
5. Smoke test from a folder outside this repo with `npx @hrica/miica-kit help`.

Important:
- `release-please` derives the next version from Conventional Commits, so `feat:` drives a minor bump, `fix:` drives a patch bump, and `!` drives a breaking bump.
- In this repo, `docs:` commits also trigger a patch release when they are the only releasable change type since the last tag.
- Chore-only changes do not usually open a release PR by themselves.
- `release-please` needs the repository-level GitHub Actions setting `Allow GitHub Actions to create and approve pull requests` enabled, or it will fail with `GitHub Actions is not permitted to create or approve pull requests`.
- Manual tag publishing is now a fallback path, not the normal path.

## Current Recommended Identity

The repo is prepared for this setup:
- GitHub repo: `h-rica/miica-kit`
- npm package: `@hrica/miica-kit`

If you publish under a different repo or package name, update [package.json](./package.json) first.

## Before You Publish

### 1. Confirm the package name is available

The current package name is:

```json
"name": "@hrica/miica-kit"
```

Check whether it already exists on npm:

```bash
npm view @hrica/miica-kit name
```

If the package does not exist yet, npm will return a not-found error. That is fine.

## 2. Review package metadata

Before publishing, review [package.json](./package.json).

The repo is already prepared with these publishing fields:
- `name`
- `version`
- `description`
- `bin`
- `files`
- `repository`
- `homepage`
- `bugs`
- `keywords`
- `publishConfig.access = public`

Licensing note:
- this repo now ships a top-level `LICENSE` file and `package.json` `license` field set to `MIT`
- keep those two in sync if the licensing decision ever changes

The main thing to verify is that the final GitHub repo URL really is:

```text
https://github.com/h-rica/miica-kit
```

If not, update those three fields:
- `repository.url`
- `homepage`
- `bugs.url`

## 3. Smoke test the CLI locally

Before publishing, make sure the CLI still works from the repo itself:

```bash
node ./bin/miica-kit.mjs help
```

If you use Bun locally, you can also check:

```bash
bun ./bin/miica-kit.mjs help
```

## 4. Review what will actually be published

Run:

```bash
npm pack --dry-run
```

This is the fastest sanity check before `npm publish`.
It shows which files are going into the package tarball.

For this repo, you should see the important runtime files included:
- `bin/`
- `scripts/`
- `skills/`
- `codex-skills/`
- `claude-skills/`
- `templates/`
- root docs and metadata files

If something important is missing, fix `package.json` `files` before publishing.

## Authenticate With npm

### 5. Log in with your npm account

If you are not already authenticated on this machine:

```bash
npm login
```

Then verify:

```bash
npm whoami
```

If `npm whoami` prints your npm username, authentication is working.

Important:
- `npm whoami` only proves that the local npm session is authenticated.
- It does **not** prove that the account currently satisfies npm's package publishing security requirements.

## Security Note

npm now requires one of these two conditions for package publishing:
- account-level 2FA enabled
- a granular access token with write access and `Bypass 2FA` enabled

For a manual publish from your own machine, the practical path is usually:
- enable 2FA on your npm account on npmjs.com
- use `npm login`
- publish from the CLI and enter the OTP when npm prompts you, or pass it explicitly with `npm publish --access public --otp=<code>`

If you prefer token-based publishing, use a granular access token scoped for this package with write access and `Bypass 2FA` enabled.

Long term, the better setup is **trusted publishing** from CI.

This repo now includes a GitHub Actions workflow at [`.github/workflows/publish.yml`](./.github/workflows/publish.yml).

## Publish The Package

### 6. Publish the first public release manually

Because this is a **scoped public package**, publish with:

```bash
npm publish --access public
```

The repo already includes this setting in `publishConfig`, but using `--access public` explicitly on the first publish is still the clearest path.

If npm returns this error:

```text
E403 403 Forbidden - Two-factor authentication or granular access token with bypass 2fa enabled is required to publish packages.
```

then the npm login session is valid, but the publishing credentials are still insufficient. Fix that by either enabling 2FA on the publishing account, or by switching to a granular token that has `Bypass 2FA` enabled.

## Configure Trusted Publishing On npmjs.com

### 7. Link npm to the GitHub Actions workflow

This step comes after the first successful manual publish. npm trusted publisher configuration requires the package to already exist on the registry.

Before running the trust command, make sure [`.github/workflows/publish.yml`](./.github/workflows/publish.yml) is committed and pushed to GitHub.

If your local npm is older than `11.10.0`, use `npx` to run a current npm temporarily:

```bash
npx npm@11.11.1 trust github @hrica/miica-kit --repo h-rica/miica-kit --file publish.yml -y
```

If your local npm is already recent enough, the equivalent command is:

```bash
npm trust github @hrica/miica-kit --repo h-rica/miica-kit --file publish.yml -y
```

During that command, npm will require a browser-based 2FA confirmation for the trust operation. Open the URL that npm prints, complete the confirmation on npmjs.com, then verify the relationship:

```bash
npx npm@11.11.1 trust list @hrica/miica-kit --json
```

Expected configuration:
- provider: GitHub Actions
- package: `@hrica/miica-kit`
- repository: `h-rica/miica-kit`
- workflow filename: `publish.yml`
- environment name: empty unless you later add a protected GitHub environment

You can also configure the same relationship from the npm website package settings for `@hrica/miica-kit` using:
- Organization or user: `h-rica`
- Repository: `miica-kit`
- Workflow filename: `publish.yml`
- Environment name: leave empty unless you later add a protected GitHub environment

Important details from npm's docs:
- the workflow filename must match exactly
- only the filename is entered, not `.github/workflows/publish.yml`
- the workflow file must exist in `.github/workflows/`

### 8. Keep publishing secure

After trusted publishing is confirmed to work, npm recommends restricting traditional token publishing access.

The secure end state is:
- trusted publishing enabled
- 2FA required
- token publishing disabled when you no longer need it

## Automatic Releases With Release Please

This repo now uses `.github/workflows/release-please.yml` as the normal release path.

Before expecting it to open release PRs, confirm these GitHub prerequisites:
- the workflow file keeps `contents: write`, `issues: write`, and `pull-requests: write`
- repository settings allow GitHub Actions to create and approve pull requests
- if the repository belongs to an organization or enterprise, no higher-level policy overrides that setting

That workflow:
1. runs on pushes to `main`
2. creates or updates the release PR from Conventional Commits
3. treats `docs:` commits as patch-release triggers when no `feat`, `fix`, or `deps` commits are present since the last tag
4. creates the GitHub release and tag when the release PR is merged
5. checks out the created tag in the same workflow run
6. smoke-tests the CLI, previews the tarball, and publishes to npm with trusted publishing

Publishing in the same workflow run matters because tags created by `release-please` via `GITHUB_TOKEN` do not trigger a second workflow run reliably enough for publication.

If you hit this exact error:

```text
release-please failed: GitHub Actions is not permitted to create or approve pull requests.
```

fix it in GitHub at:
- repository: `Settings -> Actions -> General -> Workflow permissions -> Allow GitHub Actions to create and approve pull requests`
- organization, if applicable: `Organization Settings -> Actions -> General -> Workflow permissions -> Allow GitHub Actions to create and approve pull requests`

If you intentionally do not want to enable that setting, the fallback is to give `release-please` a dedicated PAT secret and pass it with the action `token` input.

## Manual Tag Or Dispatch Fallback

This repo still keeps `.github/workflows/publish.yml` as a fallback path.

Fallback workflow details:
- workflow name: `Publish Package Fallback`
- trigger: Git tag push matching `v*`
- manual trigger: `workflow_dispatch`
- runner: `ubuntu-latest`
- OIDC permission: `id-token: write`

Use this fallback only when you intentionally want to publish from a manual tag push or from the Actions UI.

## Verify The Publish

### 9. Check the npm page

After publishing, verify the package page exists:

```text
https://www.npmjs.com/package/@hrica/miica-kit
```

### 10. Verify from a random folder

Open a folder outside this repo and run:

```bash
npx @hrica/miica-kit help
```

Then verify the Bun and pnpm runners:

```bash
bunx @hrica/miica-kit help
pnpm dlx @hrica/miica-kit help
```

If all three work, the publish is good.

## Publishing Updates Later
For normal releases after this setup:

1. keep merging Conventional Commits into `main`
2. review and merge the release PR opened by `release-please`
3. verify the GitHub release, npm package page, and one runner smoke test (`npx`, `bunx`, or `pnpm dlx`)

Manual fallback example:

```bash
git tag v0.1.2
git push origin v0.1.2
```

## Strongly Recommended After The First Manual Publish

Once the package exists on npm and the repo is on GitHub, set up **trusted publishing**.

Why:
- better security than long-lived npm tokens
- safer CI/CD publishing flow
- npm can generate provenance automatically when the conditions are met

If you plan to release from GitHub Actions, trusted publishing is the right long-term setup.

## Practical Release Checklist

Use this checklist each time:

1. Make sure the package name is correct in `package.json`.
2. Make sure release-worthy commits use Conventional Commits so `release-please` can infer the next version correctly.
3. Make sure the CLI still works with `node ./bin/miica-kit.mjs help`.
4. Run `npm pack --dry-run` when packaging behavior changed materially.
5. Make sure the license metadata stays aligned: the repo should keep a top-level `LICENSE` file plus a matching `package.json` `license` field.
6. If this is the first release in a fresh repo, publish manually with `npm publish --access public` after enabling 2FA or preparing a granular token with `Bypass 2FA`.
7. For ongoing releases here, merge the release PR opened by `.github/workflows/release-please.yml`.
8. Use `.github/workflows/publish.yml` only as a fallback path for a manual tag push or manual dispatch.
9. Verify `npx`, `bunx`, and `pnpm dlx` from outside the repo.

## Official References

- npm public package publishing: [Creating and publishing unscoped public packages](https://docs.npmjs.com/creating-and-publishing-unscoped-public-packages)
- npm publish command: [npm publish](https://docs.npmjs.com/cli/v11/commands/npm-publish)
- npm login: [npm login](https://docs.npmjs.com/cli/v11/commands/npm-login/)
- npm whoami: [npm whoami](https://docs.npmjs.com/cli/v11/commands/npm-whoami/)
- npm 2FA: [About two-factor authentication](https://docs.npmjs.com/about-two-factor-authentication/)
- npm access tokens: [About access tokens](https://docs.npmjs.com/about-access-tokens/)
- npm trusted publishing: [Trusted publishing for npm packages](https://docs.npmjs.com/trusted-publishers/)
- npm trusted publisher CLI: [npm trust](https://docs.npmjs.com/cli/v11/commands/npm-trust/)
- release-please action: [googleapis/release-please-action](https://github.com/googleapis/release-please-action)
- release-please manifest config: [manifest-releaser.md](https://github.com/googleapis/release-please/blob/main/docs/manifest-releaser.md)
- Bun package runner: [bunx](https://bun.sh/docs/pm/bunx)
- pnpm package runner: [pnpm dlx](https://pnpm.io/cli/dlx)
