---
name: miica-git
description: "Handle focused git workflow requests. Automatically routes among branch creation, commit creation, and GitHub pull request drafting based on the user's request."
user-invocable: true
allowed-tools: Bash, Read, Glob, Grep
argument-hint: "[optional: request describing branch, commit, or PR work]"
---

# miica-git

Use this command for focused git workflow work.

`miica-se` posture is always on. Inspect the real git state before acting.

## Goal

Carry out the smallest correct git workflow step: create a branch, create one or more coherent small-slice commits, or draft pull request content.

## Intent routing

Infer the intent from the user's request.

- `branch`: create and checkout a new branch when the user wants to start work, split work, or move changes to a new branch
- `commit`: stage relevant changes and create one or more small, coherent commits when the user wants to save or commit work
- `pr`: draft GitHub pull request content when the user wants a PR title/body, review summary, or branch summary

If the request is ambiguous, ask one short clarifying question before acting.

## Shared checks

1. Run `git status --short --branch`.
2. Inspect the relevant diff:
   - `git diff` and `git diff --cached` for working tree changes
   - branch diff against the chosen base branch for PR drafting
3. Run `git log --oneline -10` when commit or PR wording should match repo history.
4. Never stage or include files that look like secrets, credentials, or unrelated changes.

## Branch mode

Follow this branch workflow:

1. Parse or infer the branch type and short description.
2. Map the type to the correct prefix:

| Type | Prefix |
|---|---|
| `feature`, `feat` | `feature/` |
| `fix`, `bug` | `fix/` |
| `hotfix` | `hotfix/` |
| `docs` | `docs/` |
| `refactor` | `refactor/` |
| `chore` | `chore/` |
| `ci` | `ci/` |
| `test` | `test/` |
| `perf` | `perf/` |

3. Format the description:
   - lowercase
   - replace spaces with hyphens
   - remove special characters
   - keep it concise, max 50 chars when possible
4. Construct the branch name as `<prefix><description>`.
5. Check that the branch does not already exist.
6. Create and checkout the branch from the current `HEAD`.
7. Print the branch name and what it was created from.

If the type is not recognized, show the supported types and ask the user to choose one.

## Commit mode

Use this commit workflow:

1. Run `git status`, `git diff`, and `git diff --cached`.
2. If there are no changes to commit, tell the user and stop.
3. Group the diff into coherent small slices. Separate unrelated work, broad refactors, and docs-only changes into different commits when possible.
4. Stage only the files for the current slice. Prefer explicit files over `git add -A`.
5. If the user provided a message and the work is one slice, use it. If the diff clearly spans multiple slices, derive a message per slice instead of forcing one broad commit.
6. Otherwise write a Conventional Commit message for the current slice:

```text
type(scope): short description

Optional body explaining why, not what.
```

Rules:
- subject under 72 characters
- imperative mood
- body explains why when useful
- no `Co-Authored-By` lines unless the user explicitly asks

7. Create the commit for that slice, then repeat for any remaining slices.
8. Re-run `git status` to confirm success.
9. Print the commit hash and message for each created commit.

## PR mode

Use this PR-drafting workflow:

1. Determine the base branch:
   - use an explicit user-provided base if available
   - otherwise prefer `origin/main`, then `main`, then `master`
2. Inspect the branch with:
   - `git diff --stat <base>...HEAD`
   - `git diff <base>...HEAD`
   - `git log --oneline <base>..HEAD`
3. Draft pull request content with:
   - title
   - summary
   - key changes
   - testing
   - risks or open questions
4. If the working tree is dirty, note that the draft may include uncommitted changes when relevant.
5. If there is no meaningful diff, tell the user and stop.

Only open an actual GitHub pull request if the user explicitly asks for that and the local tooling and auth make it possible. Otherwise return the PR content only.

## Guardrails

- do not use destructive git commands like reset, checkout of paths, or force delete unless the user explicitly asks
- keep the operation scoped to the git task the user requested
- do not silently amend existing commits
