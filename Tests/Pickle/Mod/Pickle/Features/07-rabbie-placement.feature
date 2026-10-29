# Pass: -DepMap wsl-deps.rabbie-placed.map, filter 07-rabbie-placement. test-colony with the source mod mounted by the map; cells near the colony centre, a cell that is not free fails the step and names the cell. Not played.
# A thing placed before a reload belongs to the replaced game: place, save, reload, assert, nothing to clean (NPT, 2026-10-29). The style is forced on the thing, it is not checked against its category (the offline test and feature PlantPot|PAS_Rabbie_PlantPot|142|150 do that).
@requires:runnelatki.rabbieracemod @requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.savesteps @requires:nelim.pickletools.loadaudit
Feature: Rabbie styles are placed, drawn and saved

  Background:
    Given the save "test-colony" is loaded

  Scenario: styled things place, draw, and keep their style across a save and reload
    Given Nelim's Pickle Tools: I place the decor "Bed" with the style "PAS_Rabbie_Bed" at (130, 150)
    Given Nelim's Pickle Tools: I place the decor "DiningChair" with the style "PAS_Rabbie_DiningChair" at (134, 150)
    Given Nelim's Pickle Tools: I place the decor "StandingLamp" with the style "PAS_Rabbie_StandingLamp" at (138, 150)
    Given Nelim's Pickle Tools: I place the decor "PlantPot" with the style "PAS_Rabbie_PlantPot" at (142, 150)
    Given Nelim's Pickle Tools: I place the decor "Table2x2c" with the style "PAS_Rabbie_Table2x2c" at (146, 145)
    Then Nelim's Pickle Tools: the thing "Bed" at (130, 150) has the style "PAS_Rabbie_Bed"
    And Nelim's Pickle Tools: the thing "Bed" at (130, 150) draws a texture that resolves
    Then Nelim's Pickle Tools: the thing "DiningChair" at (134, 150) has the style "PAS_Rabbie_DiningChair"
    And Nelim's Pickle Tools: the thing "DiningChair" at (134, 150) draws a texture that resolves
    Then Nelim's Pickle Tools: the thing "StandingLamp" at (138, 150) has the style "PAS_Rabbie_StandingLamp"
    And Nelim's Pickle Tools: the thing "StandingLamp" at (138, 150) draws a texture that resolves
    Then Nelim's Pickle Tools: the thing "PlantPot" at (142, 150) has the style "PAS_Rabbie_PlantPot"
    And Nelim's Pickle Tools: the thing "PlantPot" at (142, 150) draws a texture that resolves
    Then Nelim's Pickle Tools: the thing "Table2x2c" at (146, 145) has the style "PAS_Rabbie_Table2x2c"
    And Nelim's Pickle Tools: the thing "Table2x2c" at (146, 145) draws a texture that resolves
    When Nelim's Pickle Tools: the game is saved as "pas-style"
    And the save "pas-style" is loaded
    Then Nelim's Pickle Tools: the thing "Bed" at (130, 150) has the style "PAS_Rabbie_Bed"
    Then Nelim's Pickle Tools: the thing "DiningChair" at (134, 150) has the style "PAS_Rabbie_DiningChair"
    Then Nelim's Pickle Tools: the thing "StandingLamp" at (138, 150) has the style "PAS_Rabbie_StandingLamp"
    Then Nelim's Pickle Tools: the thing "PlantPot" at (142, 150) has the style "PAS_Rabbie_PlantPot"
    Then Nelim's Pickle Tools: the thing "Table2x2c" at (146, 145) has the style "PAS_Rabbie_Table2x2c"
    And Nelim's Pickle Tools: the load of the mod "nelim.propsasstyle" is clean
