# Pass: -DepMap wsl-deps.chinese.map, filter 05-chinese. Needs the source mod staged by that map. Not played.
# The vanilla targets come from the StyleCategoryDef, the textures from the source mod: the offline test cannot read either mod's textures.
@requires:Dajian.ChiTeaditional.Expanded @requires:nelim.pickletools.deffields @requires:nelim.pickletools.loadaudit
Feature: Chinese traditional styles

  Background:
    Given Nelim's Pickle Tools: the game has finished starting

  Scenario: the load is clean with the source mod present
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean

  Scenario: the category PAS_ChineseTraditional is loaded
    Then Nelim's Pickle Tools: the def "PAS_ChineseTraditional" of type "StyleCategoryDef" is loaded

  Scenario Outline: PAS_ChineseTraditional gives each vanilla thing its style
    Then Nelim's Pickle Tools: the style category "PAS_ChineseTraditional" gives the thing "<thing>" the style "<style>"

    Examples:
      | thing | style |
      | EndTable | EndTableSZ_ChuangTouGui_New |
      | Dresser | SZ_ShuZhuangTai |
      | DiningChair | MaJiangYi_Short |
      | Table2x2c | ChiTableC |
      | Table3x3c | ChiTableD |

  Scenario Outline: PAS_ChineseTraditional styles draw a texture that resolves
    Then Nelim's Pickle Tools: the style "<style>" of the thing "<thing>" draws a texture that resolves

    Examples:
      | thing | style |
      | EndTable | EndTableSZ_ChuangTouGui_New |
      | Dresser | SZ_ShuZhuangTai |
      | DiningChair | MaJiangYi_Short |
      | Table2x2c | ChiTableC |
      | Table3x3c | ChiTableD |

  Scenario: the active language recorded no load error
    Then Nelim's Pickle Tools: the active language recorded no load error
