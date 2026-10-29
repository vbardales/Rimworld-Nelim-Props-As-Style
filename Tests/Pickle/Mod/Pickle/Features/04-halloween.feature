# Pass: -DepMap wsl-deps.halloween.map, filter 04-halloween. Needs the source mod staged by that map. Not played.
# The vanilla targets come from the StyleCategoryDef, the textures from the source mod: the offline test cannot read either mod's textures.
@requires:nelim.halloweenmonstermash @requires:nelim.pickletools.deffields @requires:nelim.pickletools.loadaudit
Feature: Halloween styles

  Background:
    Given Nelim's Pickle Tools: the game has finished starting

  Scenario: the load is clean with the source mod present
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean

  Scenario: the category PAS_Halloween is loaded
    Then Nelim's Pickle Tools: the def "PAS_Halloween" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_Halloween gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_Halloween" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | SculptureSmall | PAS_Halloween_SculptureSmall |
      | TorchLamp | PAS_Halloween_TorchLamp |
      | Campfire | PAS_Halloween_Campfire |
      | Brazier | PAS_Halloween_Brazier |

  Scenario Outline: PAS_Halloween styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | SculptureSmall | PAS_Halloween_SculptureSmall |
      | TorchLamp | PAS_Halloween_TorchLamp |
      | Campfire | PAS_Halloween_Campfire |
      | Brazier | PAS_Halloween_Brazier |

  Scenario: the active language recorded no load error
    Then Nelim's Pickle Tools: the active language recorded no load error
