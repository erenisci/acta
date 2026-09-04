---
name: preview
description: Boot the project's app and show it in chat — a screenshot per viewport (mobile / tablet / laptop / desktop), taken from the project's real breakpoints. Read-only, writes nothing by default. Trigger on /acta:preview, "show me the app", "screenshot the viewports", "responsive check".
---

# acta:preview

The **eyes** of Acta. Every other skill reads and writes text; this one **shows you the running app** — one
screenshot per viewport, in order, straight into the chat (so it works over Remote Control too, where you have no
browser). Use it to see a change land, to check responsive behaviour before a commit, or to spot design drift the
docs can't show.

**Ephemeral and read-only:** it boots nothing permanent, writes no docs, and leaves the repo untouched unless you
ask (`--save`).

Shared: `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`. Reads `.claude/acta.md` (registry) and, when it exists,
`docs/design/spacing-layout.md` for the project's real breakpoints.

## Language
Talk to the user in the language they use; any persisted note goes in the project's documentation language
(registry `language:`, default English). See `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.

## Usage

```
/acta:preview                              # detected routes' entry (/) at every detected viewport
/acta:preview /pricing /login              # specific routes
/acta:preview --viewport mobile,desktop    # only these
/acta:preview --full-page                  # whole scrollable page, not just the fold
/acta:preview --theme dark                 # or light, or both
/acta:preview --url https://staging.x.dev  # an already-running app; skips the dev server entirely
/acta:preview --save                       # also keep the PNGs in docs/design/previews/
```

Default without flags: the app's entry route, above the fold, project theme, every viewport in the set below.

## Flow

1. **Pre-condition.** A frontend must exist. No UI in this project (CLI / library / pure backend) → say so and stop;
   don't invent a page. Registry is optional here — preview works without Acta docs, it just uses fewer inputs.

2. **Find the app.** Detect the framework and its dev command from `package.json` scripts (`dev` / `start`),
   lockfile (npm / pnpm / yarn / bun) and config (Next, Vite, CRA, Nuxt, Astro, SvelteKit, Remix, Angular). In a
   monorepo, pick the web app (`apps/web`, `apps/frontend`, `packages/*`) — if several, **ask which one**.
   With `--url`, skip this whole step.

3. **Reuse before you boot.** Probe the expected port(s) first — if the dev server is already running, use it and
   say so. Only otherwise start it in the background, capture the port from its output (never assume 3000), and
   **poll until it answers**, with a timeout. If it fails to boot, show the last lines of its output and stop —
   don't screenshot an error page as if it were the app.

4. **Resolve the viewports** — in this precedence, and **say which source you used**:
   1. `--viewport` values the user passed.
   2. `docs/design/spacing-layout.md` → **Breakpoints** (the design source of truth, when the design layer exists).
   3. The code: `tailwind.config.*` `theme.screens`, a UI-kit theme (MUI `breakpoints`), or the `@media` widths
      actually used in the stylesheets.
   4. Fallback defaults (only when 1–3 give nothing):

      | Name    | Size      | Emulation                          |
      | ------- | --------- | ---------------------------------- |
      | mobile  | 390×844   | touch, mobile UA, DPR 2            |
      | tablet  | 768×1024  | touch, DPR 2                       |
      | laptop  | 1280×800  | desktop, DPR 1                     |
      | desktop | 1920×1080 | desktop, DPR 1                     |

   Derived breakpoints become widths **just inside** each range (e.g. `md: 768px` → shoot at 768), so you see the
   layout that breakpoint actually serves.

5. **Shoot.** Headless Chromium, one shot per route × viewport × theme, in ascending width order:
   - Prefer **Playwright** if the project already has it; else **Puppeteer** if present; else the local
     **Chrome / Edge** headless binary. If none is available, **ask before installing anything** — never
     silently `npm i -g`.
   - Per shot: set viewport + device scale + touch/mobile flags, `prefers-color-scheme` for `--theme`, navigate,
     wait for the network to settle **and** for fonts/images, then capture PNG.
   - Write to a temp dir outside the repo (the session scratchpad), named `<route>-<viewport>[-<theme>].png` —
     stable names, no timestamps, overwritten on re-run.
   - **Never enter credentials.** A route that redirects to a login wall → skip it and report it; ask the user how
     they want it handled (a storage-state file, a seeded test user) instead of guessing.

6. **Show them in chat.** `Read` each PNG **in ascending viewport order**, one per shot, each with a one-line label
   (`mobile · 390×844 · /`). This is the deliverable — the images, not a summary of them.

7. **Report what you see** — short, factual, ranked. Real layout problems only, each tied to a viewport:
   overflow / horizontal scroll, overlapping or clipped text, a broken nav at a breakpoint, an unreadable contrast,
   an image that doesn't fit. Nothing wrong → say so plainly. **Don't invent design opinions** the docs didn't ask for.
   When the design layer exists, judge against `docs/design/` (tokens, `design-qa-checklist.md`) — not personal taste.

8. **Clean up.** Kill the dev server **only if this skill started it**; a server that was already running stays up.
   Say which happened.

9. **Suggest the next step** (per `principles.md`, never nagging): a real responsive bug → fix it, then re-run
   `/acta:preview`; the UI changed on purpose → `/acta:track` to sync the design docs; a deliberate,
   hard-to-reverse visual choice → a **DDR** under `docs/design/decisions/`.

## `--save` (opt-in, bounded)

Only with the flag: copy the PNGs to `docs/design/previews/` under the same stable names (overwrite, never
timestamped, never a growing gallery) and mention them from the relevant design doc. This folder is
**skill-owned assets, not docs** — `acta:audit` treats it as valid, and it is the only thing preview ever writes.

## Rules

- **Show, don't describe.** The screenshots are the output; the text is a caption.
- Read-only by default: no docs, no config, no repo files touched — `--save` is the single exception.
- Never leave a process behind, and never kill a server you didn't start.
- Never fabricate a screenshot, a breakpoint, or a passing check. Couldn't boot / couldn't shoot → **report it**.
- Never type credentials or open a real `.env`; an auth-gated route is skipped and reported.
- Ask before installing a browser or a driver the project doesn't already have.
- Right-size: a 3-viewport smoke check for a small app, not a 40-shot matrix. Domain-agnostic.
  Operate by `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.
