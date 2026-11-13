$data modify storage ito:visual card set from entity @s data.ito.history[$(index)]
$execute positioned ~$(x) ~1.055 ~$(z) summon minecraft:item_display run function ito:visual/entity with storage ito:visual card
