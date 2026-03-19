# Glossary

## Core Terms

**npm registry**
The public service that stores and serves npm packages.

**package**
A versioned unit of code and metadata that can be installed from a registry.

**scoped package**
A package name with an owner prefix, such as `@acme/example-package`.

**public package**
A package that anyone can install from the registry.

**GitHub Actions**
GitHub's workflow system for CI/CD and automation.

**workflow**
A YAML file that tells GitHub Actions what to run and when to run it.

**runner**
The machine that executes a GitHub Actions job.

## Security Terms

**trusted publishing**
npm's model for letting a CI/CD workflow publish without storing a long-lived npm publish token.

**OIDC**
OpenID Connect. In this context, it lets GitHub Actions prove its identity to npm during publish.

**`id-token: write`**
A GitHub Actions permission that allows the workflow to request an OIDC token. It does not mean the workflow can edit your repository contents.

**2FA**
Two-factor authentication. An extra verification step on an account.

**granular access token**
An npm token with narrow, explicit permissions and an expiration window.

**Bypass 2FA**
An npm token capability that lets an automated workflow publish without waiting for a human one-time password. Use it only when trusted publishing is unavailable.

## Publish Terms

**first publish**
The first time a package name is published to npm. This is where naming, access, and packaging mistakes often show up.

**`publishConfig.access`**
A `package.json` setting that helps keep scoped public packages public.

**provenance**
Metadata that links a published package back to the build that produced it.

**`npm pack --dry-run`**
A command that shows what would go into the published tarball without actually publishing it.

**`NODE_AUTH_TOKEN`**
The environment variable npm reads for registry authentication in many CI workflows.
