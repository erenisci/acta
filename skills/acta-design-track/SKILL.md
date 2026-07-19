---
name: acta-design-track
description: Sync docs/design/ when styling changes in code (a new color, variant, spacing) — in place, no bloat. Trigger on /acta-design-track, "sync the design", "update the design system".
---

# acta-design-track

The **design keeper** — `acta-track` for the design layer. When you change design **in code** (a new color, a new
button variant, different spacing, or you switch the styling approach) — including hand-edits after you didn't like
Claude Design's output — this brings `docs/design/` back in line with reality, **in place, without bloat.**

Shared: `~/.claude/acta/principles.md`. Reads the project's real styling.

## Language
English only.

## Pre-condition
`docs/design/` must exist. If not → run `/acta-design` first.

## Flow

1. **Gather what changed in the design layer.** Scan the real source of style: theme / token config, `tailwind.config.*`
   or equivalent, global CSS / style files, and component files. Compare against `design-system.md` + `components.md`.
2. **Map changes → update the docs in place:**
   - new/changed **token** (color / spacing / typography / radius) → update the tokens block in `design-system.md`.
   - new **component**, **variant**, or **state** → update `components.md`.
   - changed **styling approach** (e.g. CSS → Tailwind) → update the Approach section.
   - new recurring **copy** → reflect it in `messaging.md`.
   Edit in place; **remove entries no longer in the code** (docs mirror reality, they don't accumulate).
3. **Refresh the brain.** Update the `CLAUDE.md` Design-system pointer + `docs/README.md` + registry (idempotent).

## Rules

- **Docs mirror the code.** The design-system reflects what the code actually does now — not an aspiration, not history.
- **Anti-bloat.** In-place, consolidated; no `design-system-v2.md`, no append-only growth. Drop stale tokens/variants.
- Never fabricate values not present in the code → `TBD` / ask.
- Never touch code. Content in the project's documentation language. Operate by `~/.claude/acta/principles.md`.
