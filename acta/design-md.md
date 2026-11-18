# DESIGN.md interop — the contract

`DESIGN.md` (project root) is the **agent-readable export** of the Acta design layer, in Google's open
[DESIGN.md format](https://github.com/google-labs-code/design.md) (status: alpha). Coding agents and design tools
(Stitch, impeccable, Claude Code, Cursor…) read it as the project's visual identity.

Used by `acta:design` (writes it), `acta:track` (keeps it in sync) and `acta:audit` (checks it). UI projects only —
a non-UI project (CLI, library, backend) gets no `DESIGN.md`.

## Source of truth

- **`docs/design/tokens.md` stays canonical** for Acta. `DESIGN.md` is **derived** from it plus `design-system.md`,
  `brand.md`, `design-principles.md` and `components.md`. Edit the docs, then regenerate — never the other way round
  without the user's say-so.
- Acta marks the file it generated with this line directly after the front matter:
  `<!-- acta:design-md — generated from docs/design/. Edit docs/design/tokens.md, then run /acta:track design. -->`
- **A `DESIGN.md` without that marker is foreign** (hand-written, or from another tool such as impeccable's
  `/impeccable document`). Never overwrite it silently. Ask (`AskUserQuestion`): **import** its tokens into
  `tokens.md` (then regenerate with the marker) · **regenerate** from `docs/design/` (replace) · **leave it** (Acta
  stops managing it; audit still compares it).
- Never touch tool-owned sidecars next to it (e.g. `.impeccable/design.json`).

## Mapping

| DESIGN.md | From |
|---|---|
| front matter `name`, `description` | project name; one-line positioning from `brand.md` |
| `colors.<name>` | color tokens in `tokens.md` — `#` + hex (sRGB) only. A non-hex canonical value (OKLCH, HSL) is written as its hex approximation and listed in the report as approximated. Include a `primary`. |
| `typography.<name>` | type tokens → `fontFamily`, `fontSize`, `fontWeight`, `lineHeight`, `letterSpacing` |
| `rounded.<level>` | radius tokens |
| `spacing.<level>` | spacing tokens |
| `components.<name>` | `components.md` variants that map onto the 8 allowed props (`backgroundColor`, `textColor`, `typography`, `rounded`, `padding`, `size`, `height`, `width`); always as token references (`"{colors.primary}"`). One entry per variant/state (`button-primary`, `button-primary-hover`). Anything else (shadow, focus ring, motion) stays in prose. |
| `## Overview` | `brand.md` (identity, mood) + `design-system.md` Approach |
| `## Colors` | roles of each color (`color.md` if present) |
| `## Typography` | `typography.md` if present, else the type tokens' usage |
| `## Layout` | `spacing-layout.md` (grid, breakpoints, density) |
| `## Elevation & Depth` | elevation tokens + their use |
| `## Shapes` | radius character |
| `## Components` | `components.md` usage rules |
| `## Do's and Don'ts` | `design-principles.md` Do / Don't |
| `## Motion` (extra section, last) | motion tokens + `motion.md` (durations, easing, reduced-motion) — not in the spec's schema, so prose only |

Rules: the eight standard sections, when present, stay in that order; no duplicate headings (the spec rejects the
file). Omit a section rather than fill it with `TBD`. Never invent a value: a token that is `TBD` in `tokens.md` is
left out of the front matter. Keep it tight — every token must be one the project actually uses.

## Validation

The official linter is `@google/design.md` (`design.md lint DESIGN.md` → JSON findings; exit 1 on errors).

- Run it **only if it is already installed** (project `node_modules/.bin/design.md`, or a global `design.md` on PATH).
  Do **not** run a bare `npx @google/design.md …` — it installs the package implicitly. If it is missing, say so once
  and suggest `npm i -D @google/design.md`; otherwise validate by hand against the rules above.
- Map findings: `error` (e.g. `broken-ref`) → 🔴 · `warning` (`contrast-ratio`, `missing-primary`, `section-order`,
  `orphaned-tokens`, `missing-typography`) → 🟡 · `info` → omit unless asked.
- `design.md export --format css-tailwind|json-tailwind|dtcg` can produce theme files; offer it, never write theme
  files into the code unasked (docs mirror the code, not the reverse).
