# Props as Style: test protocol

Target: RimWorld 1.6. Static checks are not an in-game run: every scenario in the second table is **not executed**. `tested_on` stays `never` until one is played.

## Offline test

`powershell -NoProfile -ExecutionPolicy Bypass -File Tests/Test-Styles.ps1` (game data read from the Steam install, `-GameData` to point elsewhere). It checks, against Core, Ideology and every expansion present:

- every XML of `Mod/` parses, no assembly, no texture shipped outside `About/`;
- the five style branches (OuterRim, PonpecoKids, Rabbie, Halloween, Chinese): every `thingDef` target exists in vanilla, every `styleDef` exists, no orphan style, no duplicate category or style `defName`, every style has a `texPath`;
- the defensive styleable patches (root and Chinese) replayed twice against vanilla: valid XPath, no second `comps` node, no duplicated component, every target styleable afterwards;
- a target that lives outside Core and Ideology (Brazier, Royalty) is gated twice: its patch sits in a `PatchOperationFindMod`, its style entry carries `MayRequire`;
- each `LoadFolders.xml` gate points at the right folder;
- when the Chinese source mod is installed, each of its `texPath` resolves to a file.

Last run 2026-10-29: 496 assertions pass. Run against the commit before the Brazier gate it fails with `Patch on Brazier must sit in a PatchOperationFindMod for Royalty`, so the check does catch it. Not covered offline: the `texPath` of the four other source mods (no installed copy is read), `AlphaProps` random graphics, anything drawn on screen.

## Scenarios, not executed

Mod list in every row: Core, Ideology, Props as Style (plus what the row names). Style Change Anytime is added where a category must be used without an ideoligion.

| # | Scenario | Expected result |
|---|---|---|
| 1 | Core + Ideology + this mod, no source mod | No branch loaded, no error, no pink square, nothing in the log about this mod. |
| 2 | Same, without Royalty | No Brazier error: root patch skipped, Halloween category has three entries. |
| 3 | Add Outer Rim | Categories corellian, coruscant, tatooine each offer bed, double bed, dining chair, stool, dresser, end table, 2x2 table, autodoor. |
| 4 | Add Ponpeco Kids' Room | Categories "children's room" (12 styles) and "children's room, variants" (4). |
| 5 | Add Rabbie | Categories rabbie (13) and rabbie variants (7). |
| 6 | Add Halloween Monster Mash Renew (+ Royalty) | Category halloween offers small sculpture, torch lamp, campfire, brazier. |
| 7 | Add Chinese Traditional Cultural Things Expanded | Category "Chinese traditional"; no pink square; no duplicate `defName` error in the log. |
| 8 | Add Alpha Props + Vanilla Expanded Framework | Plant pot and standing lamp gain random looks; the vanilla texture stays in the draw. |
| 9 | In each branch, build every vanilla target in its category, every rotation | Occupied cells, vanilla cost, stats and behaviour unchanged. |
| 10 | Save, quit, reload with styled objects | Styles persist, no new log error. |
| 11 | French and English UI, category picker | Category labels read in both languages, no raw key. |

Record game build, mod list, date, scenario, result and log path.

## Pickle

No `Tests/Pickle/` yet. Scenarios 1 to 11 show what only a running game shows (styles drawn, pink squares, the picker), so they belong in Pickle. Writing them needs steps to read the loaded style categories and to place a building with a chosen style. Whether those steps exist is not known; if not, they are asked of NPT (PickleTools), never written locally. Each branch needs a map that mounts its source mod, declared by `@requires:<packageId>`.
