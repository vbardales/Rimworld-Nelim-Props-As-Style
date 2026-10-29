# Pass: no -DepMap (Core, DLCs, Harmony, Pickle, this mod), filter 00-bare. Needs none of the source mods. Not played.
# Every branch is gated by LoadFolders (IfModActive), so with no source mod none of the nine categories may exist and the log stays clean.
@requires:nelim.pickletools.deffields @requires:nelim.pickletools.loadaudit
Feature: with no source mod nothing of the mod loads

  Background:
    Given Nelim's Pickle Tools: the game has finished starting

  Scenario: the load is clean
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean

  Scenario Outline: the category <category> is not loaded without its source mod
    Then Nelim's Pickle Tools: the def "<category>" of type "StyleCategoryDef" is not loaded

    Examples:
      | category |
      | PAS_Corellian |
      | PAS_Coruscant |
      | PAS_Tatooine |
      | PAS_PonpecoKids |
      | PAS_PonpecoKidsB |
      | PAS_Rabbie |
      | PAS_RabbieB |
      | PAS_Halloween |
      | PAS_ChineseTraditional |

  Scenario: the active language recorded no load error
    Then Nelim's Pickle Tools: the active language recorded no load error
