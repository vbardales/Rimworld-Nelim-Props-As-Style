# Attribution

This mod contains **no file belonging to anyone else**: no texture, no sound, no building def. It
only declares `ThingStyleDef` and `StyleCategoryDef` whose `graphicData` **point at** the source
mods' textures, plus patches that make a few vanilla defs styleable.

Without the source mod, its `IfModActive` branch never loads and no style is declared. Nothing is
copied, nothing is redistributed.

The `<graphicData>` blocks are copied verbatim from the source defs — path, `graphicClass`,
`drawSize`, `shaderType`. This is deliberate: in 1.6 some of these mods ship their textures in a
Unity AssetBundle, so the paths cannot be verified on disk, and copying the source block is the
only way to guarantee the style renders exactly like the original piece.

---

## Outer Rim — Furniture and Decor

- **Author:** Neronix17
- **Steam Workshop:** [2919553599](https://steamcommunity.com/sharedfiles/filedetails/?id=2919553599)
- **Taken:** nothing. Three `StyleCategoryDef` and 24 `ThingStyleDef` pointing at its textures.
- **Its files:** none.

## Ponpeco Furnitures: Kids' Room

- **Author:** ponpeco
- **Steam Workshop:** [3367310887](https://steamcommunity.com/sharedfiles/filedetails/?id=3367310887)
- **Taken:** nothing. Two `StyleCategoryDef` and 16 `ThingStyleDef`.
- **Worth noting:** four of its defs already carry `CompProperties_Styleable`. The author had the
  same intention; this mod carries it further.

## Rabbie The Moonrabbit race

- **Author:** Runne Latki
- **Steam Workshop:** [1837246563](https://steamcommunity.com/sharedfiles/filedetails/?id=1837246563)
- **Taken:** nothing. Two `StyleCategoryDef` and 20 `ThingStyleDef`.

## Alpha Props — Parks and Gardens

- **Author:** Sarg Bjornson
- **Steam Workshop:** [3146268928](https://steamcommunity.com/sharedfiles/filedetails/?id=3146268928)
- **Taken:** nothing. Twenty texture paths added to the draw of two vanilla defs, through
  `VEF.Buildings.CompProperties_RandomBuildingGraphic`.

---

## Acknowledged debt

The defensive pattern that puts `CompProperties_Styleable` on vanilla defs is borrowed from
**Ponpeco Furnitures: School Desk** (ponpeco,
[3367534692](https://steamcommunity.com/sharedfiles/filedetails/?id=3367534692)), which solves the
same problem: create the `comps` node if it is missing, add the component only if it is absent.
The same mod taught this project that `randomGraphics` and `optionalNames` must never be filled
in a single grouped operation.

Not a line is copied from it; it is the method that is borrowed.
