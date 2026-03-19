---
name: phase-setup-browser-auth
description: Use when browser QA needs authenticated pages and the session must be established safely. Helps choose the best authentication path available in the current stack, such as session import, headed login, storage state reuse, or test credentials.
---

# phase-setup-browser-auth

Use this skill to establish authenticated browser sessions safely.

## Goal

Make browser QA possible on authenticated pages.

## Preferred strategies

- native browser session import when supported securely
- manual login in a headed session
- environment-based test credentials kept outside repo files
- storage-state reuse where the stack supports it safely

## Guardrails

- never hardcode secrets into repo files
- prefer secure, documented session setup over hacks
- if manual login is required, state it clearly and continue from there

