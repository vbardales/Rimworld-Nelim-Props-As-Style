# Pickle suite of Props as Style

Companion mod `nelim.propsasstyle.pickletests` (`Mod/`), development only, never published. No local step: every line comes from Pickle or PickleTools (`DefFieldSteps`, `LoadAudit`), checked offline with `scripts/Check-Steps.ps1 -Mod PropsAsStyle` (2026-10-29: 9 feature files, 225 step lines, each resolves to exactly one expression). Everything provable without the game is in `Tests/Test-Styles.ps1`, not here. **Nothing here has been played.** The steps of `DefFieldSteps` are new and compiled, not played either (NPT, 2026-10-29).

Each pass mounts the source mod and the two tools through its `wsl-deps.<name>.map`; the filter is the feature name. English and French: one run per language of each pass (`-Language English`, `-Language French`); the last scenario of each feature asserts the active language recorded no load error.

| Pass | `-DepMap` | Filter | What it establishes |
| --- | --- | --- | --- |
| bare | `wsl-deps.bare.map` | `00-bare` | no source mod: none of the nine categories exists, the load is clean |
| outerrim | `wsl-deps.outerrim.map` | `01-outer-rim` | three categories, each thing gets its style, each style draws a texture that resolves |
| ponpeco | `wsl-deps.ponpeco.map` | `02-ponpeco-kids` | two categories, same checks |
| rabbie | `wsl-deps.rabbie.map` | `03-rabbie` | two categories, same checks |
| halloween | `wsl-deps.halloween.map` | `04-halloween` | one category, four styles, Brazier included (Royalty present). The port may need Vanilla Cooking Expanded: confirm at first staging |
| chinese | `wsl-deps.chinese.map` | `05-chinese` | one category, five styles, textures resolve in the source mod |
| rabbie-placed | `wsl-deps.rabbie-placed.map` | `07-rabbie-placement` | on `test-colony`: five Rabbie styles placed (StageDecor), each has its style and draws a texture that resolves, then save, reload, the styles persist, the load is clean (TESTING.md 9 and 10 for this source) |
| outerrim-placed | `wsl-deps.outerrim-placed.map` | `08-outer-rim-placement` | the same with four Outer Rim styles (one per category plus the 2x2 table) |
| sans-royalty | `wsl-deps.sans-royalty.map` | `06-halloween-sans-royalty` | the Halloween port without Royalty: no Brazier, category keeps three entries, nothing logged |

Features 01 to 05 are generated from the `Defs/Styles.xml` of their branch (a one-off, not kept): a change of a style list means regenerating the Examples tables by hand.

## What has no suite, and why (`TESTING.md` numbers)

- **8, Alpha Props random graphics:** no step reads the graphic list of `CompProperties_RandomBuildingGraphic`, and the Vanilla Expanded Framework Workshop id is not recorded in this repository. Left by hand until a step exists.
- **9 and 10 for Ponpeco, Halloween and Chinese, and footprint and cost for all:** placement exists since NPT's StageDecor steps (commit 67ad18a, compiled, not played) and is written for Rabbie and Outer Rim only. A style is forced on the thing, not checked against its category (features 01 to 05 do that). Occupied cells and vanilla cost are not asserted: no step compares them.
- **11, French and English category labels in the picker:** the label is read from the def, not from the screen. `the active language recorded no load error` covers the injection files only. No step reads a `StyleCategoryDef` label; the French is proofread by Virginie (`FRENCH_REVIEW.md`).
