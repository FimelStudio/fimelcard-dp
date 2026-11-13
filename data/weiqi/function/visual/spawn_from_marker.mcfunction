execute store result storage weiqi:visual sq int 1 run scoreboard players get @s go_sq
execute store result storage weiqi:visual side int 1 run scoreboard players get @s go_piece
function weiqi:visual/coord with storage weiqi:visual
function weiqi:visual/stone_name
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function weiqi:visual/stone_init with storage weiqi:visual
