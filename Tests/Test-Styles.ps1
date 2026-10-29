param(
 [string]$Project=(Split-Path $PSScriptRoot),
 [string]$GameData='C:\Program Files (x86)\Steam\steamapps\common\RimWorld\Data',
 [string]$ChineseSource='C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\2877536640'
)
$ErrorActionPreference='Stop'
$checks=0
function Assert($condition,$message){if(!$condition){throw $message};$script:checks++}

# Every XML of the mod parses.
Get-ChildItem "$Project\Mod" -Recurse -Filter *.xml|ForEach-Object{[xml]$null=Get-Content -LiteralPath $_.FullName;$checks++}
Assert (@(Get-ChildItem "$Project\Mod" -Recurse -Include *.dll).Count -eq 0) 'Unexpected assembly'

# Vanilla ThingDefs of the base game and every official expansion present, in one document, so the patches can be replayed against them.
# Only Ideology is a dependency of the mod: a target that lives in another expansion is reported below.
$core=New-Object xml
$core.AppendChild($core.CreateElement('Defs'))|Out-Null
$origin=@{}
foreach($dlc in 'Core','Ideology','Royalty','Biotech','Anomaly','Odyssey'){
 if(!(Test-Path "$GameData\$dlc\Defs")){continue}
 foreach($f in Get-ChildItem "$GameData\$dlc\Defs" -Recurse -Filter *.xml){
  [xml]$x=Get-Content -LiteralPath $f.FullName
  foreach($n in $x.SelectNodes('/Defs/ThingDef')){$core.DocumentElement.AppendChild($core.ImportNode($n,$true))|Out-Null;if($n.defName){$origin[$n.defName]=$dlc}}
 }
}
$byName=@{}
foreach($n in $core.SelectNodes('/Defs/ThingDef')){if($n.defName){$byName[$n.defName]=$n};if($n.GetAttribute('Name')){$byName[$n.GetAttribute('Name')]=$n}}

# Replay the defensive patches twice: catches invalid XPath, wrong component shape,
# a missing comps node and a non-idempotent insertion.
$patchFiles=@("$Project\Mod\Patches\Styleable.xml","$Project\Mod\Chinese\Patches\Styleable.xml")
$targets=@{}
foreach($pf in $patchFiles){
 [xml]$patch=Get-Content $pf
 $ops=@($patch.SelectNodes('//*[@Class="PatchOperationConditional"]'))
 Assert ($ops.Count % 2 -eq 0) "Conditional operations are not pairs: $pf"
 foreach($pass in 1..2){foreach($op in $ops){if(!$core.SelectSingleNode($op.xpath)){foreach($target in @($core.SelectNodes($op.nomatch.xpath))){foreach($child in $op.nomatch.value.ChildNodes){$target.AppendChild($core.ImportNode($child,$true))|Out-Null}}}}}
 foreach($op in $ops){
  if($op.xpath -match 'defName="([^"]+)"'){
   $name=$Matches[1];$targets[$name]=1
   # A target outside Core and Ideology must be gated on its own expansion, or the patch fails without it.
   if($origin[$name] -notin 'Core','Ideology'){
    $gate=$op.ParentNode;while($gate -is [System.Xml.XmlElement] -and $gate.GetAttribute('Class') -ne 'PatchOperationFindMod'){$gate=$gate.ParentNode}
    if($gate -isnot [System.Xml.XmlElement]){$gate=$null}
    Assert ($gate -and $gate.mods.li -contains $origin[$name]) "Patch on $name must sit in a PatchOperationFindMod for $($origin[$name])"
   }
  }
 }
}
Write-Output "Patched vanilla targets: $($targets.Count)"
foreach($t in $targets.Keys|Sort-Object){if($origin[$t] -notin 'Core','Ideology'){Write-Output "NOTE: patch target $t lives in '$($origin[$t])', not in Core or Ideology"}
 Assert ($core.SelectNodes("/Defs/ThingDef[defName='$t']").Count -eq 1) "Patch target missing or duplicated in vanilla: $t"
 Assert ($core.SelectNodes("/Defs/ThingDef[defName='$t']/comps/li[@Class='CompProperties_Styleable']").Count -eq 1) "Styleable patch not idempotent: $t"}

# A target is styleable when its own comps hold the component, or a parent's do.
function IsStyleable($node){
 while($node){
  if($node.SelectNodes("comps/li[@Class='CompProperties_Styleable']").Count -gt 0){return $true}
  $parent=$node.GetAttribute('ParentName')
  if(!$parent){return $false}
  $node=$byName[$parent]
 }
 return $false
}

# Every style branch: references resolve, no orphan, every target styleable, defNames unique.
$seenCategory=@{};$seenStyle=@{}
foreach($branch in 'OuterRim','PonpecoKids','Rabbie','Halloween','Chinese'){
 [xml]$styles=Get-Content "$Project\Mod\$branch\Defs\Styles.xml"
 Assert ($styles.SelectNodes('/Defs/ThingDef').Count -eq 0) "$branch declares a ThingDef"
 $styleDefs=@($styles.Defs.ThingStyleDef)
 $used=@{}
 foreach($cat in $styles.SelectNodes('/Defs/StyleCategoryDef')){
  Assert (!$seenCategory[$cat.defName]) "Duplicate category $($cat.defName)";$seenCategory[$cat.defName]=1
  Assert ($cat.label) "No label on $($cat.defName)"
  foreach($li in $cat.SelectNodes('thingDefStyles/li')){
   $target=$core.SelectSingleNode("/Defs/ThingDef[defName='$($li.thingDef)']")
   Assert ($null -ne $target) "$branch/$($cat.defName): missing vanilla target $($li.thingDef)"
   Assert (IsStyleable $target) "$branch/$($cat.defName): $($li.thingDef) is not styleable"
   if($origin[$li.thingDef] -notin 'Core','Ideology'){Assert ($li.GetAttribute('MayRequire') -eq "Ludeon.RimWorld.$($origin[$li.thingDef])") "$branch/$($cat.defName): $($li.thingDef) lives in $($origin[$li.thingDef]), its li needs MayRequire"}
   Assert ($null -ne $styles.SelectSingleNode("/Defs/ThingStyleDef[defName='$($li.styleDef)']")) "$branch/$($cat.defName): missing style $($li.styleDef)"
   $used[$li.styleDef]=1
  }
 }
 foreach($s in $styleDefs){
  Assert (!$seenStyle[$s.defName]) "Duplicate style $($s.defName)";$seenStyle[$s.defName]=1
  Assert $used[$s.defName] "${branch}: orphan style $($s.defName)"
  Assert ($s.graphicData.texPath) "${branch}/$($s.defName): no texPath"
 }
 Write-Output "$branch : $($styleDefs.Count) styles, $($seenCategory.Count) categories so far"
}

# Chinese branch ships no texture, and each texPath resolves in the source mod when it is installed.
Assert (@(Get-ChildItem "$Project\Mod" -Recurse -Include *.png,*.dds|Where-Object{$_.FullName -notmatch '\\About\\'}).Count -eq 0) 'Texture shipped: the branches must only point at the source mods'
[xml]$lf=Get-Content "$Project\Mod\LoadFolders.xml"
foreach($pair in @(('neronix17.outerrim.furnitureanddecor','OuterRim'),('ponpeco.pfkidsroom','PonpecoKids'),('runnelatki.rabbieracemod','Rabbie'),('sarg.alphapropsparks','AlphaProps'),('nelim.halloweenmonstermash','Halloween'),('Dajian.ChiTeaditional.Expanded','Chinese'))){
 Assert ($null -ne $lf.SelectSingleNode("/loadFolders/v1.6/li[@IfModActive='$($pair[0])' and text()='$($pair[1])']")) "Load gate lost or wrong: $($pair[1])"
}
if(Test-Path $ChineseSource){
 [xml]$cs=Get-Content "$Project\Mod\Chinese\Defs\Styles.xml"
 foreach($s in $cs.Defs.ThingStyleDef){$hit=@(Get-ChildItem "$ChineseSource\Textures\$($s.graphicData.texPath)*" -ErrorAction SilentlyContinue);Assert ($hit.Count -gt 0) "Chinese texture missing in source mod: $($s.graphicData.texPath)"}
}else{Write-Output "SKIP: Chinese source mod not installed, texPath not resolved"}
Write-Output "PASS: $checks assertions (XML, references, orphans, styleable targets, load gates, patch replay)."
