# Pass: -DepMap wsl-deps.sans-royalty.map, filter 06-halloween-sans-royalty. The Halloween port staged, Royalty left out. Not played.
# Brazier is a Royalty def: the Halloween entry carries MayRequire and the root patch sits in a PatchOperationFindMod, so without the DLC
# the category keeps three entries and nothing is logged (the defect found by Tests/Test-Styles.ps1, 2026-10-29).
@requires:nelim.halloweenmonstermash @requires:nelim.pickletools.deffields @requires:nelim.pickletools.loadaudit
Feature: without Royalty the Halloween category loses only the brazier

  Background:
    Given Nelim's Pickle Tools: the game has finished starting

  Scenario: the load is clean without Royalty
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean

  Scenario: the Brazier def does not exist
    Then Nelim's Pickle Tools: the def "Brazier" of type "ThingDef" is not loaded

  Scenario: the category is still loaded
    Then Nelim's Pickle Tools: the def "PAS_Halloween" of type "StyleCategoryDef" is loaded

  Scenario Outline: the category still gives <thing> its style
    Then Nelim's Pickle Tools: the style category "PAS_Halloween" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | SculptureSmall | PAS_Halloween_SculptureSmall |
      | TorchLamp | PAS_Halloween_TorchLamp |
      | Campfire | PAS_Halloween_Campfire |
