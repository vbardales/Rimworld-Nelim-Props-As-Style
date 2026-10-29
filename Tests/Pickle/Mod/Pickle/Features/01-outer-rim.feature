# Pass: -DepMap wsl-deps.outerrim.map, filter 01-outer-rim. Needs the source mod staged by that map. Not played.
# The vanilla targets come from the StyleCategoryDef, the textures from the source mod: the offline test cannot read either mod's textures.
@requires:neronix17.outerrim.furnitureanddecor @requires:nelim.pickletools.deffields @requires:nelim.pickletools.loadaudit
Feature: Outer Rim styles

  Background:
    Given Nelim's Pickle Tools: the game has finished starting

  Scenario: the load is clean with the source mod present
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean

  Scenario: the category PAS_Corellian is loaded
    Then Nelim's Pickle Tools: the def "PAS_Corellian" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_Corellian gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_Corellian" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | Bed | PAS_Corellian_Bed |
      | DoubleBed | PAS_Corellian_DoubleBed |
      | DiningChair | PAS_Corellian_DiningChair |
      | Stool | PAS_Corellian_Stool |
      | Dresser | PAS_Corellian_Dresser |
      | EndTable | PAS_Corellian_EndTable |
      | Table2x2c | PAS_Corellian_Table2x2c |
      | Autodoor | PAS_Corellian_Autodoor |

  Scenario Outline: PAS_Corellian styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | Bed | PAS_Corellian_Bed |
      | DoubleBed | PAS_Corellian_DoubleBed |
      | DiningChair | PAS_Corellian_DiningChair |
      | Stool | PAS_Corellian_Stool |
      | Dresser | PAS_Corellian_Dresser |
      | EndTable | PAS_Corellian_EndTable |
      | Table2x2c | PAS_Corellian_Table2x2c |
      | Autodoor | PAS_Corellian_Autodoor |

  Scenario: the category PAS_Coruscant is loaded
    Then Nelim's Pickle Tools: the def "PAS_Coruscant" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_Coruscant gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_Coruscant" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | Bed | PAS_Coruscant_Bed |
      | DoubleBed | PAS_Coruscant_DoubleBed |
      | DiningChair | PAS_Coruscant_DiningChair |
      | Stool | PAS_Coruscant_Stool |
      | Dresser | PAS_Coruscant_Dresser |
      | EndTable | PAS_Coruscant_EndTable |
      | Table2x2c | PAS_Coruscant_Table2x2c |
      | Autodoor | PAS_Coruscant_Autodoor |

  Scenario Outline: PAS_Coruscant styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | Bed | PAS_Coruscant_Bed |
      | DoubleBed | PAS_Coruscant_DoubleBed |
      | DiningChair | PAS_Coruscant_DiningChair |
      | Stool | PAS_Coruscant_Stool |
      | Dresser | PAS_Coruscant_Dresser |
      | EndTable | PAS_Coruscant_EndTable |
      | Table2x2c | PAS_Coruscant_Table2x2c |
      | Autodoor | PAS_Coruscant_Autodoor |

  Scenario: the category PAS_Tatooine is loaded
    Then Nelim's Pickle Tools: the def "PAS_Tatooine" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_Tatooine gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_Tatooine" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | Bed | PAS_Tatooine_Bed |
      | DoubleBed | PAS_Tatooine_DoubleBed |
      | DiningChair | PAS_Tatooine_DiningChair |
      | Stool | PAS_Tatooine_Stool |
      | Dresser | PAS_Tatooine_Dresser |
      | EndTable | PAS_Tatooine_EndTable |
      | Table2x2c | PAS_Tatooine_Table2x2c |
      | Autodoor | PAS_Tatooine_Autodoor |

  Scenario Outline: PAS_Tatooine styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | Bed | PAS_Tatooine_Bed |
      | DoubleBed | PAS_Tatooine_DoubleBed |
      | DiningChair | PAS_Tatooine_DiningChair |
      | Stool | PAS_Tatooine_Stool |
      | Dresser | PAS_Tatooine_Dresser |
      | EndTable | PAS_Tatooine_EndTable |
      | Table2x2c | PAS_Tatooine_Table2x2c |
      | Autodoor | PAS_Tatooine_Autodoor |

  Scenario: the active language recorded no load error
    Then Nelim's Pickle Tools: the active language recorded no load error
