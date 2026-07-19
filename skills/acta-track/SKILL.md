---
name: acta-track
description: After finishing work, bring every affected doc to the current state — engineering docs, and the design + legal layers when they exist — in place, no bloat. Trigger on /acta-track, "update the docs", "sync progress", "track".
---

# acta-track

The **keeper**. One command reconciles the whole doc set with reality after you've built something — so you never
have to say "update PRD, then CHANGELOG, then the design-system, then the legal briefs…". Its prime directive is
**anti-bloat**: docs reflect the truth at their current size; they are not append-only journals.

Shared: `${CLAUDE_PLUGIN_ROOT}/acta/doc-catalog.md` defines each doc's **growth policy** — obey it strictly.

## Language
Update content in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. See `${CLAUDE_PLUGIN_ROOT}/acta/principles.md`.

## Scope
By default, track syncs **everything that exists** in the project: the engineering docs, and — if the folders are
present — the **design** layer (`docs/design/`) and the **legal** layer (`docs/legal/`). The user can narrow it:
`/acta-track docs` · `/acta-track design` · `/acta-track legal`.

## Pre-condition
Read `.claude/acta.md` (the registry). If absent, this project isn't set up with Acta yet → suggest `/acta-build`
(greenfield) or `/acta-adopt` (existing code). Don't guess a doc set without the registry/catalog.

## Flow

1. **Gather what changed.** In priority order:
   - If a git repo: `git log`/`git diff` since the registry's last-updated (new files, deps, endpoints, migrations, styling, vendors).
   - Recently modified source files and config.
   - Ask the user one open question if intent is unclear: _"What did you finish since last track?"_ (≤1 question).

2. **Map changes → docs** via the catalog. Only touch docs that are actually affected. Typical mappings:
   - progress → always. changelog → if user-visible change shipped.
   - new dependency / stack change → `arch-overview`, `structure`, `env-vars`.
   - new endpoints → `api`. schema/migration → `db-design`, `erd`.
   - a real architectural/tech decision → **new ADR** (per-item) + adr index.
   - scope/feature change → `prd`, `roadmap`, `feature-specs`.
   - pricing / cost / monetization change → note it and suggest `/acta-business` (iterative + sensitive; don't rewrite pricing here).

3. **Apply updates by growth policy** (from the catalog):
   - **in-place** (progress, roadmap, prd, standards, api, structure, …): **edit/merge in place.** Replace stale
     content; update the section that changed; refresh the `updated:` date. **Never append a duplicate section.**
   - **append-log** (changelog, ai-decision-log): add ONE new structured entry at the top of the log
     (CHANGELOG → under `[Unreleased]`; on release promote `[Unreleased]` to a version). Never rewrite history.
   - **per-item** (adr, rfc): create a NEW numbered file for a NEW decision; existing items change only their
     Status. Update the folder's `README.md` index.
   - **regenerate** (docs-index, brain, registry): rebuild from current state.

4. **PROGRESS discipline (the classic bloat trap).** PROGRESS.md is a **snapshot, not a diary**:
   - Update `Current Status`, `In Progress`, `Next Up`, `Blocked` to reflect _now_.
   - Keep `Done (recent)` to the last ~10 items; older completed work lives in CHANGELOG, not here.

5. **Design sync** — only if `docs/design/` exists (skip otherwise). Bring `docs/design/` back in line with the real
   styling, **in place, no bloat** (docs mirror the code, not history):
   - new/changed **token** (color / spacing / typography / radius) → update the tokens block in `design-system.md`.
   - new **component / variant / state** → update `components.md`. Changed **approach** (e.g. CSS → Tailwind) → the Approach section.
   - new recurring **copy** → `messaging.md`. **Remove entries no longer in the code.** Refresh the design pointer in the brain.

6. **Legal sync** — only if `docs/legal/` exists (skip otherwise). Scan for **legal-relevant** changes and update the
   briefs in place — **never write binding legal text or give legal advice:**
   - new **data** collected, **cookies/analytics/trackers**, a new **vendor/sub-processor**, a new **market/region**,
     **payments**, or targeting **children** → update `data-processing` / `cookies` / `consent` / `privacy` / `compliance-checklist`.
   - For every change that alters legal exposure, raise a **"⚠️ needs lawyer re-review: <what changed>"** item in
     `compliance-checklist.md`, and surface it in `docs/progress.md` → Blocked and the `CLAUDE.md` legal pointer.
   - If `docs/legal/lawyer-brief.md` exists, refresh it (or suggest `/acta-legal-brief`) so the handoff stays current.

7. **Refresh the brain.** Re-inject the `CLAUDE.md` index block (marker-scoped, idempotent), update `docs/README.md`,
   and update the registry rows/dates. Add rows for any docs newly created this run. If a whole new area appeared,
   offer to generate its missing docs (or point to `/acta-build`).

8. **Summary.** List exactly which docs were updated and how (edited / appended / new item), and any raised legal
   re-review flags. If nothing changed in a doc, leave it untouched and say so — no churn.

## Rules (anti-bloat is non-negotiable)

- Prefer editing over adding. Refresh `updated:` only on docs you actually changed.
- No unbounded growth: in-place docs stay the size of the truth; logs get one concise entry; caps enforced (PROGRESS window).
- Idempotent: running twice with no new work produces no changes.
- **Never write binding legal text or give legal advice** in the legal sync — update briefs + flag for a lawyer only.
- **Never touch code** in the design sync — docs mirror the code, not the reverse.
- Never fabricate progress or values → `TBD` / ask. Never overwrite outside acta's scope; the brain block is marker-scoped.
