# Practitioner Guide

This guide is for the developer who has to make the workflow work, not just discuss it.

## Target Outcome

By the end, you should have:

- a package that is safe to publish
- one clear first-publish path
- one steady-state GitHub Actions publish workflow
- a fallback plan if trusted publishing is not available

## Facts You Should Anchor On

- npm recommends trusted publishing over access tokens for publishing from CI/CD when supported.
- Trusted publishing for GitHub Actions requires GitHub-hosted runners and `id-token: write`.
- The `npm trust` CLI requires `npm@11.10.0+`, account-level 2FA, and an already existing package on the npm registry.
- Scoped public packages need explicit public access on first publish.
- With trusted publishing, provenance is generated automatically. With token-based publishing, you use `--provenance` when your setup supports it.

## Recommended Path

### 1. Prepare The Package

Make sure `package.json` is publish-ready before you automate anything.

Minimum shape:

```json
{
  "name": "@acme/example-package",
  "version": "1.0.0",
  "publishConfig": {
    "access": "public"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/acme/example-package.git"
  },
  "files": [
    "dist",
    "README.md",
    "LICENSE"
  ]
}
```

Checks worth running locally:

```bash
npm whoami
npm pack --dry-run
npm test
npm run build --if-present
```

Why this matters:

- `npm pack --dry-run` tells you what will really ship.
- The `repository.url` must match the public source repository exactly if you want provenance to line up cleanly.

### 2. Handle The First Publish

If the package does not exist on npm yet, treat first publish as a separate step.

Recommended first-publish commands:

```bash
npm login
npm whoami
npm pack --dry-run
npm publish --access public
```

Notes:

- `--access public` matters on first publish for a scoped public package.
- This is the simplest point to discover naming, ownership, and packaging mistakes before CI hides them behind workflow noise.
- Recommendation based on npm CLI behavior: the `npm trust` command requires the package to already exist, so a brand-new package usually needs one initial publish before trusted publishing can be attached.

### 3. Configure Trusted Publishing On npm

After the package exists, add the trusted publisher relationship in npm.

You can do this in the npm website package settings, or by CLI.

Web fields for GitHub Actions:

- Organization or user: your GitHub owner
- Repository: your GitHub repository name
- Workflow filename: for example `publish.yml`
- Environment name: leave empty unless you intentionally use a protected GitHub environment

CLI example:

```bash
npm trust github @acme/example-package --repo acme/example-package --file publish.yml -y
```

Verification:

```bash
npm trust list @acme/example-package
```

### 4. Add The Publish Workflow

Use one publish workflow and keep it boring.

Recommended workflow:

```yaml
name: publish-package

on:
  push:
    tags:
      - "v*"

permissions:
  contents: read
  id-token: write

jobs:
  publish:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v5

      - uses: actions/setup-node@v6
        with:
          node-version: "24"
          registry-url: "https://registry.npmjs.org"
          cache: "npm"

      - run: npm ci
      - run: npm test --if-present
      - run: npm run build --if-present
      - run: npm pack --dry-run
      - run: npm publish
```

Why this version:

- It follows npm's current trusted publishing model.
- It uses `actions/setup-node@v6`, which matches the current action README instead of older docs examples.
- It does not require `NPM_TOKEN` for the publish step.
- It keeps `npm pack --dry-run` in the workflow so packaging drift is caught before publish.

### 5. Release It

One simple release flow:

1. Merge the change that should ship.
2. Create and push a version tag such as `v1.2.3`.
3. Wait for the publish workflow to finish.
4. Verify the published version:

```bash
npm view @acme/example-package version
```

5. Smoke test outside the repo:

For a library package:

```bash
mkdir tmp-publish-check
cd tmp-publish-check
npm init -y
npm install @acme/example-package
```

If the package exposes a CLI, you can also run:

```bash
npx @acme/example-package --help
```

Optional verification:

```bash
npm audit signatures
```

## Fallback Path: Token-Based Publishing

Use this only when trusted publishing is unavailable.

Typical reasons:

- you are on an unsupported CI/CD provider
- you must publish from a self-hosted runner
- organizational constraints block OIDC setup

Token rules:

- use a granular access token, not a legacy token
- give it the smallest write scope possible
- enable `Bypass 2FA` only when the workflow truly needs automated publish
- store it as a GitHub Actions secret such as `NPM_TOKEN`

Minimal workflow delta:

```yaml
permissions:
  contents: read

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5

      - uses: actions/setup-node@v6
        with:
          node-version: "24"
          registry-url: "https://registry.npmjs.org"

      - run: npm ci
      - run: npm publish --provenance
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

If this is the first publish of a scoped public package, use:

```bash
npm publish --provenance --access public
```

## Common Failure Modes

| Symptom | Likely cause | What to check |
| --- | --- | --- |
| `Unable to authenticate` during `npm publish` | trusted publisher metadata does not match reality | repository name, workflow filename, exact case, and `id-token: write` |
| Trusted publishing works nowhere except local manual publish | wrong runner type | confirm the job uses a GitHub-hosted runner |
| `npm whoami` does not prove the workflow can publish | expected behavior | OIDC authentication for trusted publishing applies to publish, not to every npm command |
| `npm ci` fails on private dependencies | missing install credentials | trusted publishing only covers publish; add a separate read-only token for installs |
| No provenance appears after publish | private repository or unsupported path | confirm the repo is public and the publish came from a supported cloud-hosted runner |
| Workflow copied from old docs includes `always-auth` | outdated example | remove `always-auth`; `setup-node@v6` no longer supports it |

## Recommendation Summary

### Facts

- Trusted publishing is the current npm recommendation.
- Token publishing still works, but it is now the fallback path.

### Recommendations

- Use one manual first publish for a brand-new package.
- Use one stable workflow filename for steady-state releases.
- Use GitHub-hosted runners for the publish job.

### Limits

- Trusted publishing does not replace all npm authentication use cases.
- Older official examples still exist, so teams need to standardize their own current pattern.
