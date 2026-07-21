---
name: design
description: Establish docs/design/ (brand, design-system, messaging) and generate real design — web, logo, deck, ads — from the product docs. Trigger on /acta:design, "set up brand", "design system", "generate landing/logo/deck".
---

# acta:design

The **design / brand / marketing** layer of Acta. It reads your **product docs** (and any existing code) as the
source of truth, establishes the project's **design source of truth** under `docs/design/`, and **generates real
design** (web pages, logo, deck, ads, og-image) that stays consistent with it. Doc-driven and domain-agnostic — the
design inherits the same truth as the code, not a generic look.

Shared: `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`. Reads the project's `docs/product/*` and any styling in the code.

## Language
Generate content in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. See `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.

## What it establishes — `docs/design/`

- `brand.md` — identity, positioning, voice/tone, mood (derived from `docs/product`: PRD, target users, positioning).
- `design-system.md` — the project's **actual** visual language, **not a fixed template**:
  - **Approach** — how styling is done here: **detected from the code** if it exists (Tailwind / CSS Modules /
    styled-components / vanilla CSS / a design language), or **decided with you** if greenfield. Never dictate Tailwind by default.
  - **Tokens** — color / typography / spacing / radius / elevation, in a fenced `text` token block (formatter-proof).
  - **Rules** — whatever THIS project needs to stay consistent (component reuse, states: hover/focus/disabled,
    variants, do/don't). **Captured, not prescribed.**
  - **Accessibility** — contrast, motion, focus.
- `messaging.md` — the **copy** source of truth: voice + a reusable copy library (taglines, value props, section /
  CTA / FAQ copy), grounded in the product.
- `components.md` — inventory of components with their variants and states (as they exist or are planned).

Create only what applies: a **non-UI** project (CLI, library, backend) gets brand + logo + messaging (and a light or
no design-system), skipping web/components.

## Flow

1. **Read the source of truth.** `docs/product/*` (PRD, target users, positioning), any existing brand, and **scan
   the code** for the real design language (styling approach, theme/tokens, component library) when code exists.
2. **Ask only what's missing** (≤4 via `AskUserQuestion`): mood/character, **reference sites or images to resemble**,
   brand decisions the docs don't cover. Recommend from the detected project type; the user confirms. (No separate
   design-brief — the intake is these few questions plus the product docs.)
3. **Write `docs/design/`** — detected values as-is, decided values from the answers, unknown → `TBD` (never
   fabricate a hex or font you weren't given or didn't confirm).
4. **Generate on request** (a mode): `brand` board · `web` (landing / pages) · `logo` · `deck` · `ads` · `og-image`.
   Produce a **real Artifact** (HTML / SVG) that uses the `design-system` tokens + rules and the `messaging` copy —
   not lorem-ipsum, not off-brand. Save the spec to `docs/design/<surface>.md`; the live preview is the Artifact.
5. **Wire the brain.** Add/refresh a **Design system** pointer in `CLAUDE.md` (→ `docs/design/design-system.md` +
   tokens), so when you or Claude write **code** it follows the project's visual language (use the tokens, reuse the
   components, keep the styling approach). Refresh `docs/README.md` + the registry.

## Rules

- **Consistency is the whole point.** Everything — generated design and code guidance — flows from
  `design-system.md` + `messaging.md`. No rogue colors / fonts / spacing outside the tokens.
- **Detect, don't dictate.** The design-system mirrors the project's real conventions; it never forces a stack.
- Never fabricate a brand asset, hex, or font the user didn't give or approve → `TBD`.
- Never overwrite existing design docs/code without consent. Anti-bloat: in-place, consolidated, no versioned files.
- Domain-agnostic. Content in the project's documentation language. Operate by `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.
- Turn the docs into Claude Design prompts with `/acta:design-prompt`; keep them in sync with `/acta:track`.
