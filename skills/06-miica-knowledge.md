# miica-knowledge

## Role

Knowledge-base creation command for teachable topics.

## Use when

- the user asks for a knowledge base, explainer, primer, onboarding pack, or learning dossier
- the topic may be repo-specific, domain-specific, or ecosystem-specific
- the result should work for both non-technical and technical readers

## Goal

Create a dedicated knowledge base that teaches the topic clearly, accurately, and accessibly.

## Best-available effort

Use the strongest relevant combination of current research, authoritative sources, code inspection, project context, installed skills, MCP resources, browser checks, and verification needed to make the knowledge base trustworthy and easy to learn from.

## Internal routing

Apply the minimum sufficient sequence:

- clarify the subject and learning outcome enough to act
- gather authoritative sources and verify current facts when the topic is time-sensitive
- separate stable concepts from current operational guidance
- create a dedicated folder such as `knowledge-base/<topic-slug>/`
- write layered materials for mixed audiences: overview, executive summary, practitioner guide, glossary, FAQ, and sources
- explain jargon instead of assuming it

## Outputs

- knowledge-base folder
- source-backed topic guide
- executive summary for non-technical readers
- practitioner guide for technical readers
- glossary, FAQ, and sources list
- explicit caveats or stale areas when relevant

## Guardrails

- do not present guesses as facts
- separate source-backed facts from recommendations
- avoid unexplained jargon and insider shorthand
- prefer durable structure over long unstructured notes
- if the topic is current, policy-sensitive, or tool-version-sensitive, verify externally before writing
