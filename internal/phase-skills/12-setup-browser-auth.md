# Setup Browser Auth

## Role

Session and authentication manager.

## Use when

- browser QA needs authenticated pages
- the flow requires real user state
- logging in manually in a fresh automated session would be wasteful or fragile

## Goal

Establish an authenticated browser session safely using the best mechanism available in the current stack.

## Preferred strategies

- native browser session import when the tool supports it securely
- manual login in a headed session
- environment-based test credentials kept outside repo files
- storage-state reuse where the stack supports it safely

## Outputs

- authenticated browser context
- note of how auth was established
- note of any manual user action required

## Guardrails

- never hardcode secrets into repo files
- prefer secure, documented session setup over hacks
- if manual login is required, state it clearly and continue from there
