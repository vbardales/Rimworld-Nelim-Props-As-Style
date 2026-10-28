# Chinese branch: test protocol

Target: RimWorld 1.6. Static validation is not an in-game run: every manual scenario below is **not executed**.

Run `pwsh -File Tests/Test-Chinese.ps1`. It parses all mod XML, checks that no texture or assembly is shipped in `Mod/Chinese/`, checks the five mappings against Core, checks the load gate, and replays the styleable patch twice against Core.

| Manual scenario | Expected result |
|---|---|
| Core + Ideology + this mod, source mod absent | `Mod/Chinese/` not loaded, no error. |
| Add Chinese Traditional Cultural Things Expanded (2877536640) | Category "Chinese traditional" available; no pink squares; no duplicate `defName` error in the log. |
| Build the five vanilla targets in the category, every rotation | Correct occupied cells, complete graphics, vanilla cost and stats. |
| Save, quit, reload with styled objects | Styles persist, no new log errors. |

Record game build, mod list, date, scenario, result and log path. `tested_on` stays `never` until actually played.
