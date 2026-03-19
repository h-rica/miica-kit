# FAQ

## Do I really need GitHub Actions to publish an npm package?

No. You can publish from a developer machine. GitHub Actions matters because it makes the release path repeatable, reviewable, and less dependent on one laptop.

## Should I use `NPM_TOKEN` by default?

No. Current npm guidance recommends trusted publishing over tokens when GitHub-hosted runners are available. Use a token only when trusted publishing is unavailable or when you need authentication for a different npm operation.

## Why does a brand-new package often need one manual publish first?

Because the npm trust CLI requires the package to already exist on the registry. For scoped public packages, first publish is also where `--access public` matters. The practical result is simple: first release manually, then switch steady-state releases to trusted publishing.

## Why does the workflow need `id-token: write` if it is not writing to GitHub?

Because GitHub Actions needs that permission to request an OIDC token. This is about identity, not repository writes. It lets npm verify that the publish came from the workflow you approved.

## Can I use self-hosted runners?

Not for npm trusted publishing today. npm currently supports GitHub-hosted runners for GitHub Actions trusted publishing. If you must publish from a self-hosted runner, use the token-based fallback.

## Does trusted publishing also fix private dependency installs?

No. Trusted publishing applies to the publish operation. If `npm ci` needs to download private packages, you still need separate read access for that step.

## Why do some official examples still show `actions/setup-node@v4` and `NPM_TOKEN`?

Because official documentation is not perfectly synchronized across every page. GitHub's publish tutorial still shows a token-based example, while npm's newer trusted publishing guidance shows an OIDC-first model. The right move is not to average them. The right move is to standardize on one current pattern for your team.

## Do I need `--provenance`?

If you publish with trusted publishing, npm says provenance is generated automatically. If you publish with a token-based workflow, use `--provenance` when your setup supports it.

## Will provenance prove my package is safe?

No. Provenance proves where the package came from and how it was built. It does not prove the code is good, secure, or bug-free.

## Is `npm whoami` enough to validate trusted publishing?

No. `npm whoami` is useful for manual auth checks, but trusted publishing happens during the publish exchange itself. A green manual `npm whoami` does not prove your workflow metadata is configured correctly.

## What is the easiest stable policy to adopt?

Use this:

- trusted publishing for normal releases
- one manual first publish for a brand-new package
- granular token fallback only for unsupported cases

That is simple enough to remember and strong enough to defend.
