function weiqi:visual/context
data modify storage weiqi:visual sq set from entity @s data.weiqi.last.sq
data modify storage weiqi:visual side set from entity @s data.weiqi.last.side
function weiqi:visual/coord with storage weiqi:visual
function weiqi:visual/stone_name
data modify storage weiqi:visual duration set value 0
data modify storage weiqi:visual stone_y set value 0.24
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function weiqi:visual/falling_init with storage weiqi:visual
function weiqi:visual/select
