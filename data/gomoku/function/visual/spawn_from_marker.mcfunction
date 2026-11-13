execute store result storage gomoku:visual sq int 1 run scoreboard players get @s gm_sq
execute store result storage gomoku:visual side int 1 run scoreboard players get @s gm_piece
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/stone_name
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function gomoku:visual/stone_init with storage gomoku:visual
