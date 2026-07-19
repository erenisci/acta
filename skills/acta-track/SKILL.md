---
name: acta-track
description: Bring all relevant Acta docs up to the current state after a chunk of work — updated in place, no bloat (progress, changelog, new ADRs, brain). Trigger on /acta-track, "update the docs", "sync progress", "track".
---

# acta-track

The **keeper**. One command reconciles the whole doc set with reality after you've built something —
so you never have to say "update PRD, then CHANGELOG, then…". Its prime directive is **anti-bloat**:
docs reflect the truth at their current size; they are not append-only journals.

Shared: `~/.claude/acta/doc-catalog.md` defines each doc's **growth policy** — obey it strictly.

## Language

Update content in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. See `~/.claude/acta/principles.md`.

## Pre-condition

Read `.claude/acta.md` (the registry). If absent, this project isn't set up with Acta yet → suggest `/acta-build`
(greenfield) or `/acta-adopt` (existing code). Don't guess a doc set without the registry/catalog.

## Flow

1. **Gather what changed.** In priority order:
   - If a git repo: `git log`/`git diff` since the registry's last-updated (new files, deps, endpoints, migrations).
   - Recently modified source files and config.
   - Ask the user one open question if intent is unclear: _"What did you finish since last track?"_ (≤1 question).

2. **Map changes → docs** via the catalog. Only touch docs that are actually affected. Typical mappings:
   - progress → always. changelog → if user-visible change shipped.
   - new dependency / stack change → `arch-overview`, `structure`, `env-vars`.
   - new endpoints → `api`. schema/migration → `db-design`, `erd`.
   - a real architectural/tech decision → **new ADR** (per-item) + adr index.
   - notable AI-made decision → `ai-decision-log` entry.
   - scope/feature change → `prd`, `roadmap`, `feature-specs`.
   - **skill-owned areas — flag, don't silently rewrite.** If `docs/design/` exists and styling changed → point to
     `/acta-design-track`. If a **pricing / plan / monetization** change landed and `docs/business/` exists → point to
     `/acta-business` (it's iterative + sensitive; don't rewrite pricing here). If a **legal-relevant** change landed
     (cookies/analytics, a new data field, a new vendor, a new market) and `docs/legal/` exists → point to
     `/acta-legal-track` and note it needs a lawyer re-review. Surface these as one-line pointers in the summary.

3. **Apply updates by growth policy** (from the catalog):
   - **in-place** (progress, roadmap, prd, standards, api, structure, …): **edit/merge in place.** Replace stale
     content; update the section that changed; refresh the `updated:` date. **Never append a new duplicate
     section.** If a list item is now done/changed, edit that item — don't add a second copy.
   - **append-log** (changelog, ai-decision-log): add ONE new structured entry at the top of the log
     (CHANGELOG → under `[Unreleased]`; on release promote `[Unreleased]` to a version). Never rewrite history.
   - **per-item** (adr, rfc): create a NEW numbered file for a NEW decision; existing items change only their
     Status (e.g. Superseded). Update the folder's `README.md` index.
   - **regenerate** (docs-index, brain, registry): rebuild from current state.

4. **PROGRESS discipline (the classic bloat trap).** PROGRESS.md is a **snapshot, not a diary**:
   - Update `Current Status`, `In Progress`, `Next Up`, `Blocked` to reflect _now_.
   - Keep `Done (recent)` to the last ~10 items; older completed work lives in CHANGELOG, not here.
   - Do not accumulate dated log lines in PROGRESS — that's what CHANGELOG is for.

5. **Refresh the brain.** Re-inject the `CLAUDE.md` index block (marker-scoped, idempotent), update
   `docs/README.md`, and update the registry rows/dates. Add rows for any docs newly created this run
   (e.g. a new ADR). If a whole new area appeared, offer to generate its missing docs (or point to `/acta-build`).

6. **Summary.** List exactly which docs were updated and how (edited / appended / new item). If nothing changed
   in a doc, leave it untouched and say so — no churn.

## Rules (anti-bloat is non-negotiable)

- Prefer editing over adding. Refresh `updated:` only on docs you actually changed.
- No unbounded growth: in-place docs stay the size of the truth; logs get one concise entry; caps are enforced (PROGRESS window, no repeated sections).
- Idempotent: running twice with no new work produces no changes.
- Never fabricate progress. If you can't tell what changed, ask — don't invent entries.
- Never overwrite outside acta's scope; the brain block is marker-scoped.
