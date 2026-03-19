---
name: miica-knowledge
description: Use when the user wants a knowledge base, primer, explainer, onboarding pack, or learning dossier on a topic. Combines research, source gathering, explanation design, and audience-layered writing to create a dedicated knowledge-base folder.
---

# miica-knowledge

Use this command to create a knowledge base that teaches a topic well.

`miica-se` posture is always on in this kit. Keep the work accurate, teachable, and accessible to mixed audiences.

## Goal

Create a dedicated knowledge base that helps non-technical and technical readers understand the same topic at the right depth.

## Best-available effort

Use the strongest relevant combination of current research, authoritative sources, code inspection, project context, installed skills, MCP resources, browser checks, and verification needed to make the knowledge base trustworthy and useful.

Do not stop at a plausible summary when the topic needs better structure, fresher evidence, or clearer teaching.

## Workflow

1. Clarify the topic and learning goal enough to act.
2. Gather authoritative sources and verify current facts when the topic is time-sensitive.
3. Separate durable concepts from current operational guidance.
4. Create a dedicated folder such as `knowledge-base/<topic-slug>/`.
5. Write layered materials that work for mixed audiences:
   - `README.md`
   - `executive-summary.md`
   - `practitioner-guide.md`
   - `glossary.md`
   - `faq.md`
   - `sources.md`
6. Make the content teachable, not just complete.
7. State caveats, tradeoffs, and stale areas honestly.

## Guardrails

- do not present guesses as facts
- separate facts, recommendations, and uncertainty clearly
- avoid unexplained jargon
- prefer strong structure over long walls of text
- if the request is really about syncing shipped repo docs, switch to `miica-documentation`
