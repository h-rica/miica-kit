# miica-architecture

## Role

Requirements-to-architecture command for settled software work.

## Use when

- the user wants a technical architecture document
- a requirements doc exists and implementation should not start yet
- the system design, component boundaries, or repository structure need to be made explicit

## Goal

Produce a buildable architecture that ties major technical decisions back to the stated requirements.

## Best-available effort

Read the requirements first.
Inspect the existing repository, architecture notes, and conventions when they materially affect the design.
Surface unresolved questions when they would change component boundaries, data flow, storage, security, or deployment decisions.

## Internal routing

- read the requirements or settled brief
- identify materially unresolved questions
- make reasonable decisions only when the gap is tolerable, and mark them `[ASSUMED]`
- design the major components, interfaces, data flow, and file structure
- include testing strategy, assumptions, and open questions

## Outputs

- architecture overview tied to requirements
- system design with major components
- data flow
- key technical decisions and tradeoffs
- proposed file and folder structure
- testing strategy
- assumptions
- open questions

## Guardrails

- do not over-engineer beyond the requirements
- flag conflicting or ambiguous requirements explicitly
- every major architectural decision should trace back to a requirement when possible
- stop after the architecture unless the same user message explicitly asks to continue
