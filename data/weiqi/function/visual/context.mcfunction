execute unless data storage weiqi:layout s19c8o1 run function weiqi:visual/load
scoreboard players operation #vis_table go_ctx = @s ct_id
execute store result storage weiqi:visual size int 1 run scoreboard players get @s go_size
execute store result storage weiqi:visual cap int 1 run scoreboard players get @s ct_capacity
execute store result storage weiqi:visual orient int 1 run scoreboard players get @s go_orient
data modify storage weiqi:visual board set value "classic"
execute if score @s go_board matches 1 run data modify storage weiqi:visual board set value "wood"
data modify storage weiqi:visual palette set value "ebony"
data modify storage weiqi:visual labels set value "coords"
execute if score @s go_coords matches 0 run data modify storage weiqi:visual labels set value "plain"
function weiqi:visual/layout with storage weiqi:visual
