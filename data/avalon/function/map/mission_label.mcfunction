data modify storage avalon:map label set value {text:"",extra:[]}
$execute if data entity @s data.avalon.results[$(index)] run data modify storage avalon:map label.extra set from entity @s data.avalon.mission_teams.r$(round)
$execute unless data entity @s data.avalon.results[$(index)] store result storage avalon:map people int 1 run data get storage avalon:map needs[$(round)]
$execute unless data entity @s data.avalon.results[$(index)] run function avalon:map/label_need with storage avalon:map
$execute if data storage avalon:map label.extra[0] positioned ~$(x) ~1.34 ~$(z) summon minecraft:text_display run function avalon:map/label_display with storage avalon:map
