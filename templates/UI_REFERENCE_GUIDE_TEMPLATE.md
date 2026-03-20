# UI Reference Guide: <title>

## Metadata

- slug: `<slug>`
- objective: `<what this guide is helping build>`
- primary surfaces:
  - `<page-or-flow-1>`
  - `<page-or-flow-2>`
- implementation context: `<existing design system / stack / constraints>`

## Coverage Summary

- high confidence:
  - `<layout / typography / colors / components>`
- medium confidence:
  - `<responsive behavior / hidden states>`
- low confidence:
  - `<motion internals / auth-gated flows / canvas or video effects>`

## Sources

| Source | Type | Purpose | Evidence | Notes |
|---|---|---|---|---|
| `<url-or-file>` | `website|figma|screenshot|recording` | `<why it matters>` | `observed|inferred|unknown` | `<access limits or caveats>` |

## Visual System

### Typography

- observed:
  - `<font families, hierarchy, weight, spacing>`
- inferred:
  - `<fallback assumptions>`
- unknown:
  - `<anything still blocked>`

### Color and Surfaces

- observed:
  - `<backgrounds, accents, borders, overlays, contrast behavior>`
- inferred:
  - `<fallback assumptions>`
- unknown:
  - `<anything still blocked>`

### Shape, Spacing, and Layout

- observed:
  - `<radius, density, grid behavior, section rhythm>`
- inferred:
  - `<fallback assumptions>`
- unknown:
  - `<anything still blocked>`

## Components and States

### <component-name>

- purpose: `<what it does>`
- source: `<reference>`
- states covered:
  - `<default>`
  - `<hover>`
  - `<focus>`
  - `<active>`
  - `<disabled>`
  - `<loading>`
  - `<empty>`
  - `<error>`
- notes:
  - observed: `<facts>`
  - inferred: `<assumptions>`
  - unknown: `<gaps>`

## Motion and Interactivity

### <interaction-name>

- trigger: `<load|hover|click|scroll|route-change|modal-open>`
- effect: `<fade|scale|slide|blur|stagger|sticky-shift>`
- timing estimate: `<fast|medium|slow|approx-ms>`
- sequence:
  1. `<step 1>`
  2. `<step 2>`
  3. `<step 3>`
- implementation certainty: `exact|approximate|behavior-only`
- notes:
  - observed: `<facts>`
  - inferred: `<assumptions>`
  - unknown: `<gaps>`

## Responsive Behavior

- desktop:
  - `<layout and density notes>`
- tablet:
  - `<layout and density notes>`
- mobile:
  - `<layout and density notes>`

## Implementation Constraints

- must preserve:
  - `<non-negotiable design traits>`
- acceptable adaptation:
  - `<areas where the implementation may translate rather than clone>`
- blocked details:
  - `<details not fully proven>`

## Open Questions

- `<question 1>`
- `<question 2>`
