---
name: acta-legal
description: Region-aware legal briefs (KVKK/GDPR/CCPA/PIPL/APPI…) — warn you, brief a lawyer; never binding legal text, always "get a lawyer". Trigger on /acta-legal, "legal docs", "privacy policy", "GDPR/KVKK".
---

# acta-legal

The **legal groundwork** — **region-aware**, and honest about its limits. It figures out *which laws apply to your
users*, warns **you** about the risks, and briefs a **lawyer** with everything they need. It **never writes the
binding legal text itself** — that's the lawyer's job.

> ⚠️ **Not legal advice.** acta-legal produces *briefings and decision lists*, not enforceable policies. Anything
> user-facing must be reviewed and finalized by a qualified lawyer before you ship.

Shared: `~/.claude/acta/principles.md`. Reads `docs/product/*`, `docs/business/*`, and the code (data, cookies, vendors).

## Language
Write briefs in the project's documentation language (registry `language:`, default English); talk to the user in the language they use. The applicable **regime** depends on where your users are, not on the doc language.

## Step 1 — Determine the applicable regimes (region-aware)
Ask (or detect): **where are your users** · **where are you / the company based** · do you use **cookies / analytics /
tracking** · **payments** · target **children** · handle **special data** (health, biometric, etc.). Map to regimes:

- Turkey → **KVKK** · EU/EEA → **GDPR** · UK → **UK-GDPR** · California → **CCPA/CPRA** · China → **PIPL** ·
  Japan → **APPI** · Brazil → **LGPD** · Canada → **PIPEDA** · children → **COPPA/age-gating**.
- "Worldwide web but TR-focused (₺, no EU targeting)" → KVKK applies; GDPR likely not *triggered by mere access*, but
  becomes relevant if you actually process EU users' data — flag it, don't decide it. Resolve **with the user**.

## Step 2 — Produce the briefs — `docs/legal/`
`overview.md` · `privacy.md` · `terms.md` · `cookies.md` · `consent.md` · `data-processing.md` · `compliance-checklist.md`
— include only what applies. **Each file has two parts:**

- **For you (the developer):** which regime(s) apply and why, the concrete **risks**, the **decisions you must make**,
  and a blunt **"get a lawyer before shipping."**
- **For the lawyer:** the product facts they need — what the product does, **what data** it collects, **where it goes**
  (sub-processors, cross-border transfers), retention, admin access, and the open decisions to resolve. (This mirrors
  the proven "lawyer-briefing" pattern — the doc is what the lawyer needs, not a pretend policy.)

**Handoff:** when you're ready to see a lawyer, `/acta-legal-brief` consolidates all of these into one printable
document to take to the meeting.

## Step 3 — Wire & protect
Add a "Legal" pointer to `CLAUDE.md` + the docs index. `docs/legal/` is **git-ignored by `acta-build`** — sensitive,
stays local.

## Rules
- **Never write binding legal text.** No fake privacy policy / ToS. Briefs + decisions + "see a lawyer" only.
- **Never give legal advice.** State what *generally* applies; the lawyer decides. Always include the disclaimer.
- **Region-aware.** Regimes follow the users' locations; when in doubt, flag for the user + lawyer, don't guess.
- **Never fabricate a legal fact** (a retention period, a lawful basis) → `TBD` / ask.
- Keep it current with `/acta-track` (a product change can create a new legal obligation).
- Anti-bloat, in-place. Content in the project's documentation language. Operate by `~/.claude/acta/principles.md`.
