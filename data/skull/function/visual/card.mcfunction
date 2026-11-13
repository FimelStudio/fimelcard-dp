$data modify storage skull:visual model set from entity @s data.skull.seats.s$(seat).visible[$(index)].model
$execute if data storage skull:visual {model:"card:skull/back"} run data modify storage skull:visual model set value "card:skull/set$(seat)/back"
$execute positioned ~$(x) ~$(y) ~$(z) summon minecraft:item_display run function skull:visual/entity {yaw:$(yaw)}
