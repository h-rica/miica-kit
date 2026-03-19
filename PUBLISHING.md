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

On npmjs.com, open the package settings for `@hrica/miica-kit` and configure a trusted publisher with:
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

## Publish With Git Tags Using GitHub Actions

Once trusted publishing is configured, the included workflow can publish automatically.

This repo uses:
- workflow file: `.github/workflows/publish.yml`
- trigger: Git tag push matching `v*`
- runner: `ubuntu-latest`
- OIDC permission: `id-token: write`

The workflow does this:
1. checks out the repo
2. sets up Node 24
3. upgrades npm to a version that supports trusted publishing
4. smoke-tests the CLI
5. runs `npm pack --dry-run`
6. publishes with `npm publish --access public --provenance`

To trigger a release publish:

```bash
git tag v0.1.0
git push origin v0.1.0
```

You can also trigger the workflow manually from GitHub because `workflow_dispatch` is enabled.

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
Every time you publish a new version:

1. update `package.json` `version`
2. review `npm pack --dry-run`
3. publish again

Example:

```bash
npm version patch
npm publish --access public
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
2. Make sure the version is bumped.
3. Make sure the CLI still works with `node ./bin/miica-kit.mjs help`.
4. Run `npm pack --dry-run`.
5. Run `npm whoami`.
6. If this is the first release, publish manually with `npm publish --access public` after enabling 2FA or preparing a granular token with `Bypass 2FA`.
7. For ongoing releases, push a `v*` tag to trigger `.github/workflows/publish.yml`.
8. Verify `npx`, `bunx`, and `pnpm dlx` from outside the repo.

## Official References

- npm public package publishing: [Creating and publishing unscoped public packages](https://docs.npmjs.com/creating-and-publishing-unscoped-public-packages)
- npm publish command: [npm publish](https://docs.npmjs.com/cli/v11/commands/npm-publish)
- npm login: [npm login](https://docs.npmjs.com/cli/v11/commands/npm-login/)
- npm whoami: [npm whoami](https://docs.npmjs.com/cli/v11/commands/npm-whoami/)
- npm 2FA: [About two-factor authentication](https://docs.npmjs.com/about-two-factor-authentication/)
- npm access tokens: [About access tokens](https://docs.npmjs.com/about-access-tokens/)
- npm trusted publishing: [Trusted publishing for npm packages](https://docs.npmjs.com/trusted-publishers/)
- npm trusted publisher CLI: [npm trust](https://docs.npmjs.com/cli/v11/commands/npm-trust/)
- Bun package runner: [bunx](https://bun.sh/docs/pm/bunx)
- pnpm package runner: [pnpm dlx](https://pnpm.io/cli/dlx)
