param([string]$Project=(Split-Path $PSScriptRoot),[string]$GameData='C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data')
$ErrorActionPreference='Stop'
$checks=0
function Assert($condition,$message){if(!$condition){throw $message};$script:checks++}
$branch="$Project\Mod\Chinese"
Get-ChildItem "$Project\Mod" -Recurse -Filter *.xml|ForEach-Object{[xml]$null=Get-Content -LiteralPath $_.FullName;$checks++}
[xml]$styles=Get-Content "$branch\Defs\Styles.xml"
Assert ($styles.SelectNodes('/Defs/ThingDef').Count -eq 0) 'ThingDef declared'
Assert (@($styles.Defs.ThingStyleDef).Count -eq 5) 'Style count'
Assert (@(Get-ChildItem $branch -Recurse -Filter *.dll).Count -eq 0) 'Unexpected assembly'
Assert (@(Get-ChildItem $branch -Recurse -Include *.png,*.dds).Count -eq 0) 'Texture shipped: the branch must only point at the source mod'
[xml]$lf=Get-Content "$Project\Mod\LoadFolders.xml"
Assert ($null -ne $lf.SelectSingleNode('/loadFolders/v1.6/li[@IfModActive="Dajian.ChiTeaditional.Expanded" and text()="Chinese"]')) 'Load gate lost'
[xml]$core=Get-Content "$GameData\Core\Defs\ThingDefs_Buildings\Buildings_Furniture.xml"
foreach($li in $styles.SelectNodes('/Defs/StyleCategoryDef/thingDefStyles/li')){
 Assert ($null -ne $core.SelectSingleNode("/Defs/ThingDef[defName='$($li.thingDef)']")) "Missing vanilla target $($li.thingDef)"
 Assert ($null -ne $styles.SelectSingleNode("/Defs/ThingStyleDef[defName='$($li.styleDef)']")) "Missing style $($li.styleDef)"
}
# Apply the defensive patch twice to Core XML: catches invalid XPath,
# wrong component shape, missing comps nodes and non-idempotent insertion.
[xml]$patch=Get-Content "$branch\Patches\Styleable.xml"
foreach($pass in 1..2){foreach($op in $patch.Patch.Operation){if(!$core.SelectSingleNode($op.xpath)){foreach($target in @($core.SelectNodes($op.nomatch.xpath))){foreach($child in $op.nomatch.value.ChildNodes){$target.AppendChild($core.ImportNode($child,$true))|Out-Null}}}}}
foreach($li in $styles.SelectNodes('/Defs/StyleCategoryDef/thingDefStyles/li')){Assert ($core.SelectNodes("/Defs/ThingDef[defName='$($li.thingDef)']/comps/li[@Class='CompProperties_Styleable']").Count -eq 1) 'Styleable patch not idempotent'}
Write-Output "PASS: $checks assertions (XML, references, no shipped texture, load gate, patch replay)."
