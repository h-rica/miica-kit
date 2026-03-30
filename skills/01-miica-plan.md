# miica-plan

## Role

Planning and scope-routing command for software work.

## Use when

- the user asks for a plan
- scope, architecture, or sequencing is not settled yet
- the user has settled requirements and architecture and wants an implementation-plan artifact
- the task may need product, engineering, and design planning combined
- the user provides inspiration sites, screenshots, recordings, or Figma links and needs a UI guide before implementation

## Goal

Produce the smallest defensible plan, or a buildable implementation-plan artifact when the request is mature enough for execution planning.

## Best-available effort

Do not stop at the first acceptable outline.
Use the strongest relevant combination of repository context, project memory, codebase inspection, installed skills, MCP resources, browser evidence, and research when they materially improve the plan.

## Internal routing

Apply only the planning phases that the request needs:

- scope and user-value pressure test when the request is product-facing or suspiciously narrow
- engineering review when the change is non-trivial or risky
- design planning review when users will directly experience the result
- implementation-plan creation when the user has settled requirements and architecture and wants a phased execution plan under `docs/plans/`
- UI reference-guide extraction when the desired interface is being shown through references instead of specified clearly in prose
- skip unnecessary planning theater for small, local work

## Outputs

- problem restatement
- chosen scope
- architecture and data-flow notes when relevant
- design notes when relevant
- implementation plan artifact and path when relevant
- UI reference guide or extraction brief when relevant
- step sequence
- risks
- success criteria
- explicit deferrals

## Guardrails

- make a recommendation, not just a list of options
- when generating an implementation plan, phase by working software and write self-contained tasks with no placeholders
- keep plan output proportional to the task
- stop after the plan unless the same user message explicitly asks to continue
