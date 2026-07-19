---
name: acta-brief
description: Step 1 of the Acta pipeline — create <PROJECT>_BRIEF.md for the human to fill (sign language: plain text, "?" = suggest, "-" = skip). Generates no docs itself. Trigger on /acta-brief, "start a project", "create a project brief".
---

# acta-brief

The **entry point** for a new project. It produces one file — `<PROJECT>_BRIEF.md` — that captures the human's
intent as a starting point. It writes nothing else. Once filled, `/acta-build` turns it into real docs + a brain.

Shared resources live at `~/.claude/acta/` (sibling of the `skills/` folder). This skill reads
`~/.claude/acta/brief-template.md`.

## Language — two decisions start here

1. **Brief language.** If `/acta-brief` opens the conversation, or the user is writing in another language, **ask
   which language the brief should be written in** — propose the language they're already using, and confirm. Default
   English. Write the brief in that language and talk to the user in it.
2. **Documentation language.** The brief's **final question** (template section 11) asks what language the *generated
   docs* should be in — it may differ from the brief. You don't answer it; the user does, and `/acta-build` reads it.

Always English regardless of either choice: the `<PROJECT>_BRIEF.md` filename, `acta:` markers, and paths.
See `~/.claude/acta/principles.md`.

## Flow

1. **Determine the project name.**
   - Default: the basename of the current working directory.
   - If it's generic (`project`, `app`, `src`, `code`, `new`) or the user gave a name, prefer that.
   - The brief file is `<PROJECT>_BRIEF.md` at the project root: project token slugged (spaces → `-`), then
     the whole filename UPPERCASED, e.g. `HABIT-TRACKER_BRIEF.md`.

2. **Overwrite guard.** If a `*_BRIEF.md` already exists, do NOT clobber it. Ask once:
   `merge / overwrite / open existing / pick a different name`. Default to **open existing** (show its path).

3. **Write the brief.** Render `~/.claude/acta/brief-template.md` **in the chosen brief language** (translate the
   template's prompts/labels; keep the section numbers and the sign-language header), replacing `{{PROJECT_NAME}}`
   with the human project name. Write it to `<project>/<PROJECT>_BRIEF.md`. Do not fill any answers — the human does
   that, including section 11 (documentation language).

4. **Tell the user, briefly** (in the brief language), the moves and the next step:
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
