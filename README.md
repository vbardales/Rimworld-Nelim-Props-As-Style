# Props as Style

*Turns furniture from other mods into alternative appearances for the vanilla things you already
build.*

This mod creates **no building**. It declares `ThingStyleDef` and `StyleCategoryDef`: a vanilla
piece of furniture keeps its function, its stats, its cost and its behaviour — only its
appearance changes, and you pick which one at build time or at the styling station.

It is the third part, after *Props as Deco* — colonists place the knick-knacks themselves — and
*Props in Use* — props receive a function.

---

## The criterion

**Many objects, one coherent look → an ideoligion style.**
**One object, many looks → an alternative texture** (`CompProperties_RandomBuildingGraphic`).

This is not a matter of taste, it is arithmetic: a `thingDef` can receive only **one** `styleDef`
per category. Fifteen planters all aiming at `PlantPot` would mean fifteen categories —
unusable. Three furniture sets each covering eight different pieces are three categories.

## Outer Rim — Furniture and Decor

Three themed sets, eight pieces each, footprints checked one by one:

| Outer Rim piece | Footprint | Vanilla target |
|---|---|---|
| bed | 1x2 | `Bed` |
| double bed | 2x2 | `DoubleBed` |
| dining chair | 1x1 | `DiningChair` |
| stool | 1x1 | `Stool` |
| dresser | 2x1 | `Dresser` |
| end table | 1x1 | `EndTable` |
| table | 2x2 | `Table2x2c` |
| autodoor | 1x1 | `Autodoor` |

**Not taken:** the 1x1 tables, vanilla has none; the 2x1 tables, because vanilla's `Table1x2c` is
1x2 — the other way round, the texture would be rotated; the wide 2x1 doors, no equivalent; and
the Dathomirian lamps, which would need a fourth category of their own.

## Ponpeco Furnitures: Kids' Room

A complete, already functional child's bedroom set. **Two categories, sixteen styles.** Four of
its defs already carry `CompProperties_Styleable` — the stool, the chair, the child chair and the
fairy lights: the author had the same intention.

Targets covered: `Bedroll`, `Bed`, `DoubleBed`, `RoyalBed`, `AnimalBed`, `Stool`, `DiningChair`,
`Armchair`, `EndTable`, `Table2x2c`, `Dresser`, `StandingLamp`.

## Rabbie The Moonrabbit race

A race mod carrying a furniture set unrelated to the race itself. **Two categories, twenty
styles** — the broadest of the three. Adds `Shelf`, `PlantPot`, `BookcaseSmall` and `Door` to the
targets covered.

**Not taken:** the production benches; the laptop, which is a `Building_WorkTable`, and its
printer facility; the storage cartons; the window and the wall lamp, which are wall pieces; and
the wall itself.

## Why two categories per set

A `thingDef` receives only one `styleDef` per category. Ponpeco offers two beds, two animal beds,
two chairs and four lamps; Rabbie two sofas, two chairs, two stools, two floor lamps, two pots
and two bookcases. The variants go into a second category rather than being thrown away.

## Alpha Props — alternative textures

Fifteen extra looks for the vanilla `PlantPot`, five for `StandingLamp`. Not styles: a
`VEF.Buildings.CompProperties_RandomBuildingGraphic` drawing at random on construction. The pot
keeps its cost, its function, and still grows a flower.

**The vanilla texture is always the first entry**, otherwise it would drop out of the draw.

### The double-add trap

One single `PatchOperationConditional` per target, two mutually exclusive branches. Creating the
component in one operation and then filling its lists in another would mean the second finds the
freshly created component and adds the same entries **a second time** — patches apply in
sequence.

### Two lists, two operations

`randomGraphics` and `optionalNames` are filled by separate operations, never grouped. That is
the lesson of the *Ponpeco Furnitures: School Desk* patch: if another mod has already filled both
lists, a grouped add would desynchronise them and every texture would end up with someone else's
name. And `optionalNames` sits under a conditional with no `nomatch` — if a mod placed the
component without names, we do nothing rather than log an error.

### Three targets dropped after checking

| Target | Why |
|---|---|
| `SculptureSmall` for topiaries and rocks | already `Graphic_Random` over its own art textures, and each sculpture carries a generated name and description |
| `Barricade` for bollards | a **linked** texture (`linkType Basic`, `linkFlags Barricades`) that joins its neighbours |
| `Column` for bollards | `drawSize (0.5,1.25)` and a `drawOffset` belonging to a narrow pillar: a squat bollard would be stretched |

Two of the seven street lights are dropped as well: `LamplightL` and `LamplightT` are
`Graphic_Multi` while `StandingLamp` is `Graphic_Single`.

## Two implementation points that needed checking

### The vanilla bases are not styleable

Contrary to what one would assume, `CompProperties_Styleable` is **not** carried by the abstract
bases. Checked def by def: not `FurnitureBase`, not `FurnitureWithQualityBase`, not `TableBase`,
not `BedBase`, not `BasicBedBase`. Only `ShelfBase` does, plus a few concrete defs in their own
right — `PlantPot`, `StandingLamp`, `TorchLamp`, `DiningChair`, `Stool`, `Table2x2c`, `Autodoor`,
`ShelfSmall`, `BookcaseSmall` — and the art bases.

Of the **seventeen targets** this mod touches, eight already have it and nine do not. The
component is therefore added to `Bed`, `DoubleBed`, `Dresser`, `EndTable`, `Bedroll`, `RoyalBed`,
`AnimalBed`, `Armchair` and `Door`, using the **defensive pattern** borrowed from *Ponpeco
Furnitures: School Desk*: one conditional creates the `comps` node if missing, a second adds the
component only if it is not already there.

That patch lives **at the root**, not in a conditional folder: several sets aim at the same
targets, so it cannot depend on a single source mod. Adding the component to a vanilla def costs
nothing even if no style aims at it.

`Wall` is left out: walls use a `Graphic_Linked` that joins its neighbours, and a flat style
texture does not substitute for it cleanly.

### The textures live in an AssetBundle

In 1.6 Outer Rim no longer ships loose PNGs: they are packed into `Common/AssetBundles/`.
`Common_Old/Textures` is the file-based version, kept for 1.4 and 1.5 only. The paths are
therefore **not verifiable on disk**.

Every `<graphicData>` is consequently **copied verbatim from the 1.6 source def** — path,
`graphicClass`, `drawSize` and `shaderType`. That is the only way to guarantee the style renders
exactly like the original piece.

## Requirements

**Ideology** for the style system itself. **Style Change Anytime** is strongly recommended:
without it, a style category has to be attached to an ideoligion before it can be used.

Each set sits behind an `IfModActive` branch. Without the source mod no style is declared —
otherwise you would get pink squares on appearances you cannot select anyway.

## License and attribution

MIT. The mod contains no file belonging to anyone else; see [ATTRIBUTION.md](ATTRIBUTION.md).
