# ACTA UNIVERSAL DOC FORMAT

Render every catalog document that has no dedicated .tmpl using this shape. Take the human title and the
section list from `doc-catalog.md`. Fill values from the brief / answers / code. Unknown → `TBD` (never invent).
Keep each section tight — a few sentences or a short list, not an essay. Prefer tables/bullets over prose.

---

title: {{HUMAN_TITLE}}
discipline: {{DISCIPLINE}}
status: {{draft|active}}
updated: {{YYYY-MM-DD}}

---

# {{HUMAN_TITLE}}

> **Purpose.** {{ONE_LINE_PURPOSE}}
> **Related.** {{LINKS_TO_RELATED_DOCS}} <!-- omit line if none -->

## {{SECTION_1}}

{{content or TBD}}

## {{SECTION_2}}

{{content or TBD}}

<!-- one H2 per section listed in the catalog, in order -->

RULES

- Every section appears even if its body is just `TBD` (so gaps are visible, not hidden).
- Use mermaid fenced blocks for diagrams/ERD.
- Never place secrets/credentials in any doc (env-vars, config, security). Use placeholders.
- Cross-link related docs with relative paths so the brain/index stays navigable — but ONLY docs generated in this
  build. Never link to a doc that doesn't exist; omit out-of-scope references (no `TBD — <tier>` link placeholders).
