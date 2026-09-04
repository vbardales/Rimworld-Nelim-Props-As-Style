# Journal des modifications

Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).
Ce fichier sert au dépôt et à rédiger les notes de version Steam ; RimWorld ne l'affiche pas en jeu.

## [1.0.0] — non publié

Première version. RimWorld 1.6. Aucun code, aucun fichier d'autrui : uniquement des styles et
des patchs.

### Styles d'idéologie

- **Outer Rim — Furniture and Decor** : trois catégories, `corellien`, `coruscanti`,
  `tatooinien`, huit pièces chacune — lit, lit double, chaise, tabouret, commode, table de
  chevet, table 2x2, porte automatique. 24 styles.
- **Ponpeco Furnitures : Kids' Room** : deux catégories, 16 styles. Ensemble de chambre d'enfant
  complet, du couchage au lit royal.
- **Rabbie The Moonrabbit race** : deux catégories, 20 styles. Ajoute `Shelf`, `PlantPot`,
  `BookcaseSmall` et `Door` aux cibles couvertes.

Deux catégories par ensemble dès qu'un mod propose plusieurs variantes de la même pièce : un
`thingDef` ne reçoit qu'un `styleDef` par catégorie.

### Textures alternatives

- **Alpha Props — Parks and Gardens** : quinze apparences de plus pour `PlantPot`, cinq pour
  `StandingLamp`, via `VEF.Buildings.CompProperties_RandomBuildingGraphic`. La texture vanilla
  reste la première entrée du tirage.

### Correctifs vanilla nécessaires

Neuf cibles ne sont pas stylables d'origine : `Bed`, `DoubleBed`, `Dresser`, `EndTable`,
`Bedroll`, `RoyalBed`, `AnimalBed`, `Armchair`, `Door`. Elles reçoivent
`CompProperties_Styleable` par patch défensif. Contrairement à ce qu'on suppose, aucune base
abstraite vanilla ne le porte : ni `FurnitureBase`, ni `TableBase`, ni `BedBase`.

`Wall` est écarté : les murs utilisent un `Graphic_Linked` qui se raccorde aux voisins.
