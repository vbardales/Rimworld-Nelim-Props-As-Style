---
mod: Props as Style
packageId: nelim.propsasstyle
repo: Rimworld-Nelim-Props-As-Style
remote: https://github.com/vbardales/Rimworld-Nelim-Props-As-Style.git
visibility: public
detached: yes
workflow_stage: localize[1.0.0]
licence: open
licence_at: "2026-10-28: MIT (LICENSE), nothing of anyone else shipped; Chinese textures removed, source mods only pointed at"
upstream_mod_remotes: N/A
settings_audit: not_applicable
localization: complete
translation_en: complete
translation_fr: partial
dependencies: declared
workshop: none
published: no
tested_on: never
remaining:
  - "2026-10-28: unverified: never seen running; upstream Chinese mod has no v1.6 LoadFolders entry, texture and defName behaviour in 1.6 unknown"
  - "2026-10-28: defect: public release needs a clean history (local main holds the Chinese textures in 718fc69); origin/main has unrelated history, 8 commits"
  - "2026-10-28: unverified: licence of the Halloween source mod and of each source mod for public release"
  - "2026-10-28: defect: Mod/About/PublishedFileId.txt holds 3811383287 while workshop is none: clarify before any publication"
  - "2026-10-29: defect: Tests/Test-Chinese.ps1 has no justified row in scripts/LOCAL_SCRIPTS.md (Audit arbitrates, declare-local-script)"
  - "2026-10-29: unverified: settings_audit not_applicable checked in sources only; absence of a Mod options entry and of a MainButtons shortcut not seen in game (playTests)"
  - "2026-10-29: unverified: French review by Virginie (FRENCH_REVIEW.md); Virginie decided 2026-10-29 to keep coruscanti (English demonym) and tatooinien: no French source found for either, not official forms"
  - "2026-10-29: unverified: translated labels not seen in game (no raw key, no fallback, no clipping in the style picker); playTests"
protocols_read_sha: cc1f93006ee3756009054a0389731cff310d8784
updated: 2026-10-29
---

# Props as Style: status

Current state only: the front matter above is the source of truth.

## Chinese branch, converted 2026-10-28

The private extraction of 2026-09-12 is gone: no Chinese texture is shipped any more. `Mod/Chinese/` holds only defs, the defensive styleable patch and the French label. It loads under `IfModActive="Dajian.ChiTeaditional.Expanded"` (Workshop 2877536640, listed in `loadAfter`, not a hard dependency) and its `texPath` values point at that mod's `Textures/` (all five checked on disk 2026-10-28). Textures stay in git history of the local `main` only (commit `718fc69` and the two after it): that history must never be pushed to a public repository.

Unverified: upstream declares 1.2 to 1.5 and has no `v1.6` entry in its `LoadFolders.xml`. Whether RimWorld 1.6 loads its root `Textures/` and its defs (the five style def names are kept from it, a duplicate `defName` is possible) needs a game run.

`Tests/Test-Chinese.ps1`: 32 assertions pass (XML, references, no shipped texture, load gate, patch replay twice against Core). Scenarios in `TESTING.md`.

## Settings audit, 2026-10-29

Result: `not_applicable`. Revision: HEAD `7e1a8c2`, `Mod/` only. Inventory: the mod is XML only (no `Source/`, no `Assemblies/`, no `ModSettings` or `Mod` subclass possible). Parsed every non-About, non-Languages XML of `Mod/`: root children are only `StyleCategoryDef`, `ThingStyleDef`, `PatchOperationConditional` and the `LoadFolders` root. No `MainButtonDef`, no settings def. So no settings page under Mod options and no MainButtons shortcut exist. Nothing configurable that a player needs: a style is picked in the game's own style UI, gated by installed mods. Command: inline PowerShell XML walk of `git ls-files "Mod/*.xml"`. In-game check of the absence (no entry under Mod options, no MainButton) is left to `playTests`.

## Translation audit, 2026-10-29

Scope: `Mod/` of HEAD `b077f9e` plus the new French file. No C#, no Keyed: the only player-facing text is the `label` of the nine `StyleCategoryDef` (`ThingStyleDef` carry no label, nothing else is shown). English comes from the Def itself (no `Languages/English`). French lives in `Mod/Languages/French/DefInjected/StyleCategoryDef/Styles.xml` (seven labels: Corellian, Coruscant, Tatooine, PonpecoKids, PonpecoKidsB, Rabbie, RabbieB), `Mod/Chinese/Languages/French/.../Chinese.xml` (one) and, added today, `Mod/Halloween/Languages/French/.../Halloween.xml` (`PAS_Halloween.label`, missing before). Each French file sits in the folder its `LoadFolders` entry gates. No pawn text, so no gender agreement; no `tu` or `vous`.

Commands, all green: `Check-Translations.ps1` (9 source texts, French injections, no stale entry), `Check-ModBasics.ps1` (13 XML, 78 defs), `Check-DefInjected.ps1 -TransMod PropsAsStyle/Mod` (9 keys checked, 0 errors; 8 `MayRequire` notes saying the French is not in an Ideology-gated folder: Ideology is a hard dependency of the whole mod, so left as is). `FRENCH_REVIEW.md` generated with `Make-FrenchReview.ps1`; `french-review-flags.json` carries the doubts. French review by Virginie not done.

## Dependencies, 2026-10-29

Hard: Ideology (`Ludeon.RimWorld.Ideology`), the style system itself. Nothing else is required.
Optional, each gated by `LoadFolders.xml` and listed in `loadAfter`: Outer Rim (`neronix17.outerrim.furnitureanddecor`), Ponpeco Kids' Room (`ponpeco.pfkidsroom`), Rabbie (`runnelatki.rabbieracemod`), Alpha Props (`sarg.alphapropsparks`, needs Vanilla Expanded Framework `OskarPotocki.VanillaFactionsExpanded.Core`), Halloween Monster Mash Renew (`nelim.halloweenmonstermash`), Chinese Traditional Cultural Things Expanded (`Dajian.ChiTeaditional.Expanded`). Style Change Anytime (`Dra.StyleChangeAnytime`) is recommended, `loadAfter` only. No `MayRequire`, no incompatibility. The root patch only adds `CompProperties_Styleable` to vanilla defs, defensively. No animal added. `sort-load-order.py` not run (it needs a Pickle staging directory).

Fixed 2026-10-29: the Halloween gate used `nelim.halloweenmonstermashrenew`, but the port's packageId is `nelim.halloweenmonstermash`, so that branch never loaded. `LoadFolders.xml`, the Halloween def comment and `loadAfter` now use the real id; the description lists it.
