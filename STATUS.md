---
mod: Props as Style
packageId: nelim.propsasstyle
repo: Rimworld-Nelim-Props-As-Style
remote: https://github.com/vbardales/Rimworld-Nelim-Props-As-Style.git
visibility: public
detached: yes
workflow_stage: makeSources
licence: open
licence_at: "2026-10-28: MIT (LICENSE), nothing of anyone else shipped; Chinese textures removed, source mods only pointed at"
upstream_mod_remotes: N/A
settings_audit: unchecked
localization: unchecked
translation_en: unchecked
translation_fr: unchecked
dependencies: declared
workshop: none
published: no
tested_on: never
remaining:
  - "2026-10-28: unverified: never seen running; upstream Chinese mod has no v1.6 LoadFolders entry, texture and defName behaviour in 1.6 unknown"
  - "2026-10-28: defect: public release needs a clean history (local main holds the Chinese textures in 718fc69); origin/main has unrelated history, 8 commits"
  - "2026-10-28: unverified: licence of the Halloween source mod and of each source mod for public release"
  - "2026-10-28: defect: Mod/About/PublishedFileId.txt holds 3811383287 while workshop is none: clarify before any publication"
  - "2026-10-28: unverified: protocols changed since protocols_read_sha (AGENTS.md, docs/AUDIT-STATUS.md, scripts/LOCAL_SCRIPTS.md): re-read before the next stage change"
  - "2026-10-28: unverified: 2.a to 2.f makeSources sub-steps not yet replayed (icon source, derivatives, preview source)"
protocols_read_sha: 67838c25a6ef98a6bfc300da66b6b496eff10099
updated: 2026-10-28
---

# Props as Style: status

Current state only: the front matter above is the source of truth.

## Chinese branch, converted 2026-10-28

The private extraction of 2026-09-12 is gone: no Chinese texture is shipped any more. `Mod/Chinese/` holds only defs, the defensive styleable patch and the French label. It loads under `IfModActive="Dajian.ChiTeaditional.Expanded"` (Workshop 2877536640, listed in `loadAfter`, not a hard dependency) and its `texPath` values point at that mod's `Textures/` (all five checked on disk 2026-10-28). Textures stay in git history of the local `main` only (commit `718fc69` and the two after it): that history must never be pushed to a public repository.

Unverified: upstream declares 1.2 to 1.5 and has no `v1.6` entry in its `LoadFolders.xml`. Whether RimWorld 1.6 loads its root `Textures/` and its defs (the five style def names are kept from it, a duplicate `defName` is possible) needs a game run.

`Tests/Test-Chinese.ps1`: 32 assertions pass (XML, references, no shipped texture, load gate, patch replay twice against Core). Scenarios in `TESTING.md`.
