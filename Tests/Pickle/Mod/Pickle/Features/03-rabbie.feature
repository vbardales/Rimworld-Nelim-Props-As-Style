# Pass: -DepMap wsl-deps.rabbie.map, filter 03-rabbie. Needs the source mod staged by that map. Not played.
# The vanilla targets come from the StyleCategoryDef, the textures from the source mod: the offline test cannot read either mod's textures.
@requires:runnelatki.rabbieracemod @requires:nelim.pickletools.deffields @requires:nelim.pickletools.loadaudit
Feature: Rabbie styles

  Background:
    Given Nelim's Pickle Tools: the game has finished starting

  Scenario: the load is clean with the source mod present
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean

  Scenario: the category PAS_Rabbie is loaded
    Then Nelim's Pickle Tools: the def "PAS_Rabbie" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_Rabbie gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_Rabbie" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | Bed | PAS_Rabbie_Bed |
      | DoubleBed | PAS_Rabbie_DoubleBed |
      | Armchair | PAS_Rabbie_Armchair |
      | DiningChair | PAS_Rabbie_DiningChair |
      | Stool | PAS_Rabbie_Stool |
      | Dresser | PAS_Rabbie_Dresser |
      | EndTable | PAS_Rabbie_EndTable |
      | Table2x2c | PAS_Rabbie_Table2x2c |
      | Shelf | PAS_Rabbie_Shelf |
      | StandingLamp | PAS_Rabbie_StandingLamp |
      | PlantPot | PAS_Rabbie_PlantPot |
      | BookcaseSmall | PAS_Rabbie_BookcaseSmall |
      | Door | PAS_Rabbie_Door |

  Scenario Outline: PAS_Rabbie styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | Bed | PAS_Rabbie_Bed |
      | DoubleBed | PAS_Rabbie_DoubleBed |
      | Armchair | PAS_Rabbie_Armchair |
      | DiningChair | PAS_Rabbie_DiningChair |
      | Stool | PAS_Rabbie_Stool |
      | Dresser | PAS_Rabbie_Dresser |
      | EndTable | PAS_Rabbie_EndTable |
      | Table2x2c | PAS_Rabbie_Table2x2c |
      | Shelf | PAS_Rabbie_Shelf |
      | StandingLamp | PAS_Rabbie_StandingLamp |
      | PlantPot | PAS_Rabbie_PlantPot |
      | BookcaseSmall | PAS_Rabbie_BookcaseSmall |
      | Door | PAS_Rabbie_Door |

  Scenario: the category PAS_RabbieB is loaded
    Then Nelim's Pickle Tools: the def "PAS_RabbieB" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_RabbieB gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_RabbieB" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | Armchair | PAS_RabbieB_Armchair |
      | DiningChair | PAS_RabbieB_DiningChair |
      | Stool | PAS_RabbieB_Stool |
      | StandingLamp | PAS_RabbieB_StandingLamp |
      | PlantPot | PAS_RabbieB_PlantPot |
      | BookcaseSmall | PAS_RabbieB_BookcaseSmall |
      | Door | PAS_RabbieB_Door |

  Scenario Outline: PAS_RabbieB styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | Armchair | PAS_RabbieB_Armchair |
      | DiningChair | PAS_RabbieB_DiningChair |
      | Stool | PAS_RabbieB_Stool |
      | StandingLamp | PAS_RabbieB_StandingLamp |
      | PlantPot | PAS_RabbieB_PlantPot |
      | BookcaseSmall | PAS_RabbieB_BookcaseSmall |
      | Door | PAS_RabbieB_Door |

  Scenario: the active language recorded no load error
    Then Nelim's Pickle Tools: the active language recorded no load error
