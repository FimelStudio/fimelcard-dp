function gomoku:system/context
function gomoku:visual/clear_board
function gomoku:visual/context
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function gomoku:visual/board with storage gomoku:visual
execute positioned ~ ~1.025 ~ summon minecraft:interaction run function gomoku:visual/board_hitbox with storage gomoku:visual
execute as @e[type=minecraft:marker,tag=gm.board] run function gomoku:visual/cell
data modify storage gomoku:visual duration set value 0
execute as @e[type=minecraft:marker,tag=gm.board] unless score @s gm_piece matches 0 run function gomoku:visual/spawn_from_marker
function gomoku:visual/select
