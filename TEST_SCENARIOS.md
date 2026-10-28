# Chinese private styles — test protocol

Target: RimWorld 1.6. Static validation is not an in-game run. All manual scenarios below are **not executed**.

Run `pwsh -File Tests/Test-Chinese.ps1` from this project. It parses all mod XML, checks the five mappings against installed Core footprints, verifies texture hashes and orientations, and replays the new patches twice against Core to verify exactly one styleable component per target. The shared checkers under `../scripts` additionally check this branch's XML fields, references, classes and configuration rules. They do not execute Unity rendering or reproduce all game ConfigErrors.

| Manual scenario | Expected result |
|---|---|
| Core + Ideology + PropsAsStyle only, fresh map, upstream disabled | No Chinese XML/reference/texture errors; Chinese traditional category available in ideology setup. |
| Without Ideology | ChinesePrivate branch excluded; mod manager reports existing Ideology requirement. |
| Build all five vanilla targets in the category, every available rotation | Correct occupied cells, complete graphics without pink squares; no duplicate Chinese buildable ThingDefs. Inspect table/chair alignment at tile edges. |
| Build wood/metal/stone variants wherever vanilla permits, different qualities | Tint and masks remain readable; costs and statistics equal the corresponding unstyled vanilla target of same material/quality. |
| Put styled chevet/commode next to a vanilla bed | Vanilla comfort facility rules; no source rest/beauty bonuses or Chinese lantern dependency. |
| Seat pawns and eat at both tables | Normal vanilla sitting/eating; graphics do not obscure pawns unexpectedly. |
| Save, quit, reload with styled objects | Styles and materials persist, no new log errors. |
| Enable selected neighboring private furniture/joy/deco mods | Exactly one owner for each retained Chinese piece; no original ThingDef with these five names in those mods. |
| Enable existing optional style sources | Existing categories continue to load; inspect mod log for unrelated optional branch errors separately. |

Record game build, mod list, date, scenario, observed result and log path. Keep `tested_on` empty until actually played. No C# compilation applies: this extraction introduces no code or assembly.
