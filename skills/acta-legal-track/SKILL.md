---
name: acta-legal-track
description: Keep the legal briefs current — when a product change creates a legal obligation (you add cookies/analytics, a new data field, a new vendor/sub-processor, a new market, or payments), update docs/legal/ and raise a "get this re-reviewed by a lawyer" flag. Trigger on /acta-legal-track, "sync legal", "legal review needed".
---

# acta-legal-track

The **legal watchdog.** Legal isn't static — a product change can quietly create a new legal obligation. You might
ship without cookies, then add analytics later; now you're tracking users, which means **consent**, which means the
briefs change and the **lawyer has to look again.** This catches that.

> ⚠️ **Not legal advice.** It updates briefings and flags "needs lawyer review" — it does not make you compliant.

Shared: `~/.claude/acta/principles.md`. Reads the code/config + `docs/legal/*`.

## Language
Update briefs in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. See `~/.claude/acta/principles.md`.

## Pre-condition
`docs/legal/` must exist. If not → run `/acta-legal` first.

## Flow
1. **Scan for legal-relevant changes** since the briefs were last synced:
   - new **data** collected (a new field, upload type, location, device id).
   - **cookies / analytics / tracking / pixels** added → triggers **consent** (ePrivacy / KVKK / GDPR).
   - a new **vendor / sub-processor** (a new API, storage, email, payment provider) → cross-border transfer + DPA.
   - a new **target market / region** → recompute applicable regimes (e.g. now serving EU → GDPR; California → CCPA).
   - **payments**, or now targeting **children** → new obligations.
2. **Update the affected briefs in place** (`data-processing`, `cookies`, `consent`, `privacy`, `compliance-checklist`)
   to match reality — and **remove** anything no longer true.
3. **Raise the re-review flag.** For every change that alters legal exposure, record a clear
   **"⚠️ needs lawyer re-review: <what changed>"** item in `docs/legal/compliance-checklist.md` (and surface it in
   `docs/progress.md` → Blocked, and the `CLAUDE.md` legal pointer) so it isn't forgotten before shipping.
4. **Refresh the handoff.** If `docs/legal/lawyer-brief.md` exists, regenerate it (or suggest `/acta-legal-brief`) so
   the consolidated lawyer document reflects the change and the new re-review item.

## Rules
- **Never write binding legal text, never give legal advice.** Update briefs + flag for the lawyer.
- **Always flag re-review** when exposure changes — silence is the dangerous failure here.
- Region-aware: a new market recomputes the regimes.
- Never fabricate a legal fact → `TBD` / ask. Anti-bloat, in-place. Content in the project's documentation language. Operate by `~/.claude/acta/principles.md`.
