function weiqi:system/context
function weiqi:visual/clear_board
function weiqi:visual/context
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function weiqi:visual/board with storage weiqi:visual
execute positioned ~ ~1.025 ~ summon minecraft:interaction run function weiqi:visual/board_hitbox with storage weiqi:visual
execute as @e[type=minecraft:marker,tag=go.board] run function weiqi:visual/cell
data modify storage weiqi:visual duration set value 0
execute as @e[type=minecraft:marker,tag=go.board] unless score @s go_piece matches 0 run function weiqi:visual/spawn_from_marker
function weiqi:visual/select
