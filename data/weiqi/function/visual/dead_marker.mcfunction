execute store result storage weiqi:visual sq int 1 run scoreboard players get @s go_sq
function weiqi:visual/coord with storage weiqi:visual
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function weiqi:visual/dead_display with storage weiqi:visual
