---
name: acta-brief
description: Step 1 of the acta solo-engineering doc pipeline. Creates a <PROJECT>_BRIEF.md intake file at the project root for the human to fill in, using a simple sign language (plain text = I know this; "?" = suggest one for me; "-" = skip/unknown). Does NOT generate any docs — that's acta-build. Trigger on /acta-brief, "start a project", "create a project brief".
---

# acta-brief

The **entry point** for a new project. It produces one file — `<PROJECT>_BRIEF.md` — that captures the human's
intent as a starting point. It writes nothing else. Once filled, `/acta-build` turns it into real docs + a brain.

Shared resources live at `~/.claude/acta/` (sibling of the `skills/` folder). This skill reads
`~/.claude/acta/brief-template.md`.

## Language

All output is **English** (file content and your messages). This holds even if the user is chatting in another language.

## Flow

1. **Determine the project name.**
   - Default: the basename of the current working directory.
   - If it's generic (`project`, `app`, `src`, `code`, `new`) or the user gave a name, prefer that.
   - The brief file is `<PROJECT>_BRIEF.md` at the project root: project token slugged (spaces → `-`), then
     the whole filename UPPERCASED, e.g. `HABIT-TRACKER_BRIEF.md`.

2. **Overwrite guard.** If a `*_BRIEF.md` already exists, do NOT clobber it. Ask once:
   `merge / overwrite / open existing / pick a different name`. Default to **open existing** (show its path).

3. **Write the brief.** Render `~/.claude/acta/brief-template.md`, replacing `{{PROJECT_NAME}}` with the human
   project name. Write it to `<project>/<PROJECT>_BRIEF.md`. Do not fill any answers — the human does that. Keep
   the sign-language header intact.

4. **Tell the user, briefly** (English), the moves and the next step:
   ```
   Created <PROJECT>_BRIEF.md. Fill in what you know; for any field you can instead put:
     ?  → suggest one for me
     -  → skip / unknown / not applicable
   Leave blanks for anything you want me to ask about. When ready, run /acta-build.
   ```

## Rules

- Create **only** the brief file. No `docs/`, no `CLAUDE.md`, no registry — those belong to `/acta-build`.
- Never invent answers. The template ships empty. The sign language is explained once, at the top of the file —
  do not repeat symbol hints inside individual fields.
- Idempotent by guard: re-running never silently overwrites an existing brief.
- If the project already has substantial code (detect `package.json`, `pyproject.toml`, `src/`, `.git`), mention
  that `/acta-adopt` may fit better (it reverse-engineers docs from code), but still create the brief if asked —
  the "why/product" side is worth capturing even for existing code.
