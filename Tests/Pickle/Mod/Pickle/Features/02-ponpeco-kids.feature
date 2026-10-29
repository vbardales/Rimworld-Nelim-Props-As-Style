# Pass: -DepMap wsl-deps.ponpeco.map, filter 02-ponpeco-kids. Needs the source mod staged by that map. Not played.
# The vanilla targets come from the StyleCategoryDef, the textures from the source mod: the offline test cannot read either mod's textures.
@requires:ponpeco.pfkidsroom @requires:nelim.pickletools.deffields @requires:nelim.pickletools.loadaudit
Feature: Ponpeco Kids' Room styles

  Background:
    Given Nelim's Pickle Tools: the game has finished starting

  Scenario: the load is clean with the source mod present
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean

  Scenario: the category PAS_PonpecoKids is loaded
    Then Nelim's Pickle Tools: the def "PAS_PonpecoKids" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_PonpecoKids gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_PonpecoKids" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | Bedroll | PAS_PonpecoKids_Bedroll |
      | Bed | PAS_PonpecoKids_Bed |
      | DoubleBed | PAS_PonpecoKids_DoubleBed |
      | RoyalBed | PAS_PonpecoKids_RoyalBed |
      | AnimalBed | PAS_PonpecoKids_AnimalBed |
      | Stool | PAS_PonpecoKids_Stool |
      | DiningChair | PAS_PonpecoKids_DiningChair |
      | Armchair | PAS_PonpecoKids_Armchair |
      | EndTable | PAS_PonpecoKids_EndTable |
      | Table2x2c | PAS_PonpecoKids_Table2x2c |
      | Dresser | PAS_PonpecoKids_Dresser |
      | StandingLamp | PAS_PonpecoKids_StandingLamp |

  Scenario Outline: PAS_PonpecoKids styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | Bedroll | PAS_PonpecoKids_Bedroll |
      | Bed | PAS_PonpecoKids_Bed |
      | DoubleBed | PAS_PonpecoKids_DoubleBed |
      | RoyalBed | PAS_PonpecoKids_RoyalBed |
      | AnimalBed | PAS_PonpecoKids_AnimalBed |
      | Stool | PAS_PonpecoKids_Stool |
      | DiningChair | PAS_PonpecoKids_DiningChair |
      | Armchair | PAS_PonpecoKids_Armchair |
      | EndTable | PAS_PonpecoKids_EndTable |
      | Table2x2c | PAS_PonpecoKids_Table2x2c |
      | Dresser | PAS_PonpecoKids_Dresser |
      | StandingLamp | PAS_PonpecoKids_StandingLamp |

  Scenario: the category PAS_PonpecoKidsB is loaded
    Then Nelim's Pickle Tools: the def "PAS_PonpecoKidsB" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_PonpecoKidsB gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_PonpecoKidsB" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | Bed | PAS_PonpecoKidsB_Bed |
      | AnimalBed | PAS_PonpecoKidsB_AnimalBed |
      | DiningChair | PAS_PonpecoKidsB_DiningChair |
      | StandingLamp | PAS_PonpecoKidsB_StandingLamp |

  Scenario Outline: PAS_PonpecoKidsB styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | Bed | PAS_PonpecoKidsB_Bed |
      | AnimalBed | PAS_PonpecoKidsB_AnimalBed |
      | DiningChair | PAS_PonpecoKidsB_DiningChair |
      | StandingLamp | PAS_PonpecoKidsB_StandingLamp |

  Scenario: the active language recorded no load error
    Then Nelim's Pickle Tools: the active language recorded no load error
