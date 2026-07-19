---
name: acta-audit
description: Read-only check that the docs still match the code — drift, dead links, stale TBDs, brain/registry; reports findings (--fix: safe mechanical fixes only). Trigger on /acta-audit, "audit the docs", "check doc drift".
---

# acta-audit

The **trust check.** Acta's whole value is a trustworthy engineering memory — this verifies the docs haven't drifted
from reality. **Read-only by default:** it reports; it fixes only mechanical things when asked (`--fix`), and it
**never fabricates content or guesses**.

Shared resources at `~/.claude/acta/`: `doc-catalog.md` (the contract), `disciplines.md`, `project-types.md`,
`principles.md`.

## Language
Write findings and any persisted items in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. See `~/.claude/acta/principles.md`.

## Pre-condition

Read `.claude/acta.md` (registry) and `~/.claude/acta/doc-catalog.md`. If there is no registry, this project isn't
set up with Acta yet → suggest `/acta-build` (greenfield) or `/acta-adopt` (existing code). Don't guess a doc set without them.

## Checks

Run these read-only checks and collect findings. Rank each **🔴 broken · 🟡 drift/stale · 🔵 hygiene**.

1. **Brain & index integrity** — `CLAUDE.md` has the `<!-- acta:index:start/end -->` block and its links resolve;
   `docs/README.md` lists exactly the docs on disk (no missing, no orphan); registry rows match the filesystem.
2. **Broken links** — every relative link inside `docs/**` (and the brain) points to an existing file.
3. **Doc ↔ code drift** — compare docs against the code and flag mismatches:
   - stack in `arch-overview` / registry vs `package.json` / `pyproject.toml` / `go.mod` / etc.
   - endpoints in `api.md` vs routes; env-var **names** in `env-vars.md` vs `.env.example` (the committed template only —
     never open a real `.env`/`.env.local`; compare names, never values); `project-structure` tree vs the
     actual top-level folders; tables in `database-design` vs schema/migrations.
   - "doc says X, code says Y" → report both sides.
4. **Stale / empty** — docs still mostly `TBD`; `updated:` far behind recent code changes; scaffolds never filled.
5. **Contradictions** — best-effort scan for conflicting statements across docs (e.g. PRD "no backend" vs
   architecture "REST API"). Flag them; **never resolve by guessing.**
6. **Conventions** — filename casing (root meta UPPERCASE, `docs/**` lowercase kebab-case); docs living outside the
   catalog's paths; disciplines/packs in the registry vs what's actually on disk. **Do not flag** the skill-owned
   areas `docs/design/`, `docs/business/`, `docs/legal/` as orphans — they are valid (see the catalog's "Skill-owned
   areas" note).
7. **Anti-bloat** — `in-place` docs that have grown append-only (e.g. `PROGRESS.md` accumulating dated log lines
   instead of a snapshot); oversized docs that should be consolidated per their growth policy.
8. **Design consistency** (only if `docs/design/` exists) — the code's real styling vs `design-system.md`: rogue
   colors / spacing / fonts used in code but not in the tokens; components or variants in code missing from
   `components.md`; a drifted styling approach; broken design-system pointers in the brain. Flag them → the fixer is
   `/acta-design-track`.
9. **Business consistency** (only if `docs/business/` exists) — a price / plan / tier in the code or config (e.g. a
   Stripe price, a plans table) that disagrees with `pricing.md`; a monetization model in code not reflected in
   `business-model.md`. Flag the drift → the fixer is `/acta-business`. (Read-only; never rewrite pricing.)
10. **Legal consistency** (only if `docs/legal/` exists) — legal-relevant reality in the code not reflected in the
    briefs: cookies / analytics / trackers with no `consent.md` entry; a data field or vendor / sub-processor absent
    from `data-processing.md`; a market/region served that the briefs' regimes don't cover; open **"⚠️ needs lawyer
    re-review"** items. Flag them → the fixer is `/acta-legal-track`. (Never write binding legal text or give legal advice.)

## Output

Print a concise report — **do not create a bloated audit file**:

```
Acta audit — <project>
🔴 Broken (N)      : <one line each>
🟡 Drift/stale (N) : <one line each>
🔵 Hygiene (N)     : <one line each>
Clean              : <areas with no findings>
→ Fix: run /acta-track to re-sync current-state docs; <specific doc> needs <the manual bit only a human can supply>.
```

If everything passes, say so plainly. **By default the audit writes nothing** — the report is printed; no file is
created and no file grows.

## Not losing findings (opt-in, never bloats)

Because the report is ephemeral, offer two ways to keep the findings — the user chooses; **nothing is written without
consent:**

1. **Just re-run `/acta-audit`** next session — it's cheap and reflects the *current* reality, so a real issue is never
   missed (nothing to forget). This is the default.
2. **Record open items into the living memory** (only if the user wants persistence): one concise line per unresolved
   finding into an **existing** doc — never a separate audit file:
   - blocking / do-next → `docs/progress.md` **Blocked** / **Next Up**
   - deferred quality or debt → `docs/project/tech-debt.md` (`TD-N`)
   - a doc's own unknown → that doc's **Open Questions**

   These are **bounded, self-cleaning** docs (a snapshot / an open-debt list) linked from the `CLAUDE.md` brain:
   `acta-track` removes each item once it's fixed, so they track the *current* open set and **shrink as you resolve
   them — never grow without bound.** Anti-bloat: one line per item, dedupe, no audit files.

## Fixing — only with `--fix`, only the safe mechanical set

- Regenerate the `CLAUDE.md` brain block, `docs/README.md` index, and `.claude/acta.md` registry from the current
  filesystem (idempotent, marker-scoped).
- Remove or correct broken internal links.
- Refresh `updated:` dates only on docs you actually changed.
- **NEVER** fabricate content, resolve a contradiction, or fill a `TBD` — those are always reported for the human or
  for `/acta-track`, never invented.

## Rules

- Read-only by default; `--fix` performs only the mechanical set above.
- Never fabricate; unknown / contradiction / gap → **report**, don't invent.
- Idempotent. Content in the project's documentation language. Operate by `~/.claude/acta/principles.md`.
