---
name: acta-design-prompt
description: Turn the design docs into paste-ready Claude Design prompts plus the real copy — scope-locked and on-brand. Trigger on /acta-design-prompt, "claude design prompt", "generate a design prompt".
---

# acta-design-prompt

Turns the project's design source of truth into **paste-ready Claude Design prompts** — and, crucially, the **real
content/copy** to fill them. Claude Design is great at visuals but weak at content and prone to inventing scope; this
skill fixes both: the prompt carries the **exact spec** and a hard **scope lock**, and the **real copy** from
`messaging.md`, so Claude Design builds *your* thing, not a generic guess.

Shared: `~/.claude/acta/principles.md`. Reads `docs/design/*` and, for web, `docs/product/*` (feature-specs, requirements).

## Language
Write copy and docs in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. See `~/.claude/acta/principles.md`.

## Pre-condition
`docs/design/design-system.md` + `messaging.md` must exist. If not → run `/acta-design` first (it establishes them).

## Flow

1. **Pick the surface** — arg or ask: `web` (landing / a specific page) · `logo` · `brand` board · `deck` · `ads` · `og-image`.
2. **Gather grounding** (all from the docs, nothing invented):
   - visual: tokens, approach, rules from `design-system.md`; mood/voice from `brand.md`.
   - copy: the real headlines, value props, section/CTA/FAQ text from `messaging.md`.
   - for `web`: the **actual** screens, sections, and **fields/features** from `docs/product/feature-specs.md` /
     `requirements-*` / PRD — so the prompt describes what really exists.
   - optional: a **reference** site/image the user wants to resemble.
3. **Build the prompt block** (fenced, copy-able) with these parts:
   - **Brand & visuals** — tokens (colors/type/spacing), mood, radius/elevation, motion.
   - **Structure & content** — the real sections/screens, and the **real copy** inline (no lorem-ipsum, no placeholders).
   - **Scope lock (hard rule):** "Build ONLY what is listed here. Do NOT add fields, sections, features, pages, or
     copy that aren't specified. Example: if a form asks for email + password, do not add a phone number or anything
     else." — keep Claude Design inside the spec.
   - **Reference (if given):** "Resemble `<reference>` in layout/feel, but use OUR tokens and OUR copy above — not theirs."
   - **Constraints:** accessibility (WCAG AA, reduced-motion), responsive, and the project's styling approach if it matters.
4. **Output** the paste-ready prompt + the copy. Optionally (on request) save it to `docs/design/<surface>.md` under a
   "Claude Design prompt" section — **print-first, save only if asked** (anti-bloat, no prompt-dump files).

## Rules

- **Scope lock, always.** Never let the prompt invite Claude Design to add anything beyond the spec.
- **Real copy, never lorem.** Pull from `messaging.md`; if a piece is missing, mark it `TBD` in the prompt (don't fabricate).
- **On-brand, always.** Every prompt uses the `design-system` tokens/rules; nothing off-token.
- **Consistent format** across every surface (web/logo/deck/ads/og-image) so the whole project's prompts feel like one system.
- Never fabricate. Content in the project's documentation language. Operate by `~/.claude/acta/principles.md`.
