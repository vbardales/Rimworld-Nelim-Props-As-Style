# Vitrine : spécification et demande de reprise

Fichier de travail, à la racine du projet et non dans `Mod/` : il ne part pas sur le Workshop.

> **Demande adressée à la session qui gère les 54 vitrines du dépôt.**
> Refaire la vitrine de Props as Style avec un recadrage à **y=95** au lieu du centre.

---

## Pourquoi

Le recadrage centré coupe les têtes de lit et les oreillers. On voit trois sols et des pieds de
lit, et le panneau de gauche est à moitié vide. Or le propos du mod est **« le même lit, trois
finitions »** — si les lits ne sont pas entiers, l'image raconte trois planchers.

Sur `Art/Preview-source.png` (1254×1254), la bande 16:9 fait 1254×705. La prendre à **y=95** au
lieu de y=274.

Le contraste y gagne aussi : sous le bloc de texte, y=95 donne **17 % de pixels clairs contre
25 %** au centre.

## Props as Deco ne doit pas bouger

Vérifié de la même façon, et le verdict est inverse. Onze décalages testés ; la meilleure
alternative apparente était y=180, qui montre le colon accrochant le cadre **et** la table
entière. Rendue avec le texte gravé, elle est mauvaise : **le titre coupe le colon en deux**,
bras et cadre au-dessus, jambes en dessous. Le recadrage centré le laisse entier au-dessus du
titre.

Son contraste ne pose jamais problème non plus : entre 0,1 % et 0,8 % de pixels clairs sous le
texte, quel que soit le décalage.

## Avertissement sur la vitrine actuellement en ligne

**Elle est de moi, pas du pipeline.** J'ai reconstitué la typographie par mesure sur les
vitrines existantes :

| Élément | Valeur mesurée |
|---|---|
| Titre | Segoe UI Semibold **62** — largeur 381 px, exactement celle de l'original |
| Filet | `#d68f2c`, 56 × 3 px, à x=51 y=141 |
| Résumé | Segoe UI Regular **21**, deux lignes à y=165 et y=199 |
| Couleur du texte | `#f7efe2` |
| Marge gauche | 51 |

Les glyphes se superposent exactement à ceux du pipeline — vérifié en rendant Props as Deco au
même cadrage que la version publiée et en comparant pixel à pixel : écart de 4,5 hors zone de
texte, glyphes alignés.

**Mais il manque l'assombrissement localisé du coin haut-gauche.** Je ne l'avais pas vu au
premier examen parce que je l'avais cherché à droite de l'image, où il n'existe pas : le rapport
y est de 1,00. Il n'agit que sur la gauche et le haut. Je n'ai pas réussi à le modéliser — ombre
portée, contour, dégradés linéaires : aucun ne converge, les rapports mesurés ne suivent pas un
modèle simple.

La vitrine en ligne est donc **correcte et lisible, mais pas identique aux 53 autres**. Un rendu
par le pipeline la remplacera avantageusement.

## À pousser

Deux dépôts, pas un :

- `Rimworld-Props-As-Style`
- `Rimworld-Nelim-Props-As-Style`

Les deux portent la même image ; seul le `<name>` de l'About diffère.
