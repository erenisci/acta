---
name: design
description: Establish a tiered senior-designer doc-base in docs/design/ (brand, design-principles, design-system, tokens, messaging, components + standard/full docs and DDR decision records) and generate real design — web, logo, deck, ads — from the product docs. Trigger on /acta:design, "set up brand", "design system", "generate landing/logo/deck".
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

A **tiered senior-designer doc-base** (like the engineering disciplines: core / standard / full), not a flat four
files. The full catalog (paths, sections, growth) is in `${CLAUDE_PLUGIN_ROOT}/acta/doc-catalog.md` under
"SKILL-OWNED LAYER: design". Right-size the tier to the project — offer core pre-checked, standard when there's real
UI/deployment, full when the project is large/long-lived.

**Core** (every design project):
- `brand.md` — identity, positioning, voice/tone, mood, audience (derived from `docs/product`: PRD, target users, positioning).
- `design-principles.md` — the guiding design philosophy: principles, do/don't, and **what wins** when they conflict.
- `design-system.md` — the project's **actual** visual language, **not a fixed template**: the **Approach** (how
  styling is done here — **detected from the code** if it exists: Tailwind / CSS Modules / styled-components / vanilla
  CSS / a design language; **decided with you** if greenfield — never dictate Tailwind by default), **How To Use**,
  **Rules** (component reuse, states: hover/focus/disabled, variants, do/don't — **captured, not prescribed**), and an
  **index** pointing to the granular docs below.
- `tokens.md` — color / typography / spacing / radius / elevation / motion tokens in **one fenced `text` block**
  (formatter-proof: never reflowed by Prettier). This is the single source of truth every surface and every line of UI
  code pulls from.
- `messaging.md` — the **copy** source of truth: voice + a reusable copy library (taglines, value props, section /
  CTA / FAQ copy), grounded in the product.
- `components.md` — inventory of components with their variants and states (as they exist or are planned).
- `docs/design/README.md` — the folder index (regenerated), listing every design doc by tier.

**Standard** (real UI / deployment) — the granular expansions, each grounded in `tokens.md`, never off-token:
`typography.md`, `color.md`, `spacing-layout.md`, `iconography.md`, `imagery.md`, `motion.md`, `accessibility.md`
(contrast/focus/keyboard/reduced-motion/ARIA), `content-style-guide.md`, `ux-flows.md` (IA + key flows + empty/
loading/error states), and `references.md` (reference sites/images + **what to borrow — layout/feel only, not their
tokens/copy** — plus a moodboard and anti-references).

**Full** (large / long-lived):
- `docs/design/decisions/NNNN-*.md` — **Design Decision Records (DDR)**, the design parallel of ADRs: why this
  palette / typeface / spacing scale / motion character was chosen, alternatives, why-not, long-term impact. Per-item
  and immutable except Status; maintain `docs/design/decisions/README.md` as the index. Template: `templates/DDR.md.tmpl`.
- `design-qa-checklist.md` — pre-ship visual / interaction / responsive / accessibility / cross-surface checks.

Create only what applies: a **non-UI** project (CLI, library, backend) gets **brand + design-principles + messaging**
(and a light or no design-system/tokens), skipping the visual/UI docs and components.

## Flow

1. **Read the source of truth.** `docs/product/*` (PRD, target users, positioning), any existing brand, and **scan
   the code** for the real design language (styling approach, theme/tokens, component library) when code exists.
2. **Ask only what's missing** (≤4 via `AskUserQuestion`): mood/character, **reference sites or images to resemble**,
   brand decisions the docs don't cover. Recommend from the detected project type; the user confirms. (No separate
   design-brief — the intake is these few questions plus the product docs.)
3. **Write `docs/design/`** at the chosen tier — detected values as-is, decided values from the answers, unknown →
   `TBD` (never fabricate a hex or font you weren't given or didn't confirm). Every granular doc pulls from
   `tokens.md`; nothing off-token. When `full` is selected, seed `docs/design/decisions/` with a DDR for each
   significant choice made here (palette / typeface / spacing character), and its `README.md` index. Regenerate
   `docs/design/README.md`.
4. **Generate on request** (a mode): `brand` board · `web` (landing / pages) · `logo` · `deck` · `ads` · `og-image`.
   Produce a **real Artifact** (HTML / SVG) that uses the `tokens.md` values + `design-system` rules and the
   `messaging` copy — not lorem-ipsum, not off-brand. Save the spec to `docs/design/<surface>.md`; the live preview is
   the Artifact.
5. **Wire the brain.** Refresh the **`{{DESIGN_LINKS}}`** ("Design & brand") block in `CLAUDE.md` (marker-scoped) →
   `design-principles.md`, `design-system.md`, `tokens.md`, `messaging.md` — so when you or Claude write **code** it
   follows the project's visual language (use the tokens, reuse the components, keep the styling approach). Refresh
   `docs/README.md` + the registry.

## Rules

- **Consistency is the whole point.** Everything — generated design, the granular docs, and code guidance — flows
  from `tokens.md` + `design-system.md` + `messaging.md`. No rogue colors / fonts / spacing outside the tokens.
- **Record the why.** For a significant, hard-to-reverse choice, capture the value in the granular doc and the
  reasoning in a **DDR** (full tier) — mirrors how code decisions become ADRs.
- **Detect, don't dictate.** The design-system mirrors the project's real conventions; it never forces a stack.
- Never fabricate a brand asset, hex, or font the user didn't give or approve → `TBD`.
- Never overwrite existing design docs/code without consent. Anti-bloat: in-place, consolidated, no versioned files.
- Domain-agnostic. Content in the project's documentation language. Operate by `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.
- Turn the docs into Claude Design prompts with `/acta:design-prompt`; keep them in sync with `/acta:track`.
