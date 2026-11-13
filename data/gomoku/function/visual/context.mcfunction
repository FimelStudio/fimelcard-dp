execute unless data storage gomoku:layout s19c8o1 run function gomoku:visual/load
scoreboard players operation #vis_table gm_ctx = @s ct_id
execute store result storage gomoku:visual size int 1 run scoreboard players get @s gm_size
execute store result storage gomoku:visual cap int 1 run scoreboard players get @s ct_capacity
execute store result storage gomoku:visual orient int 1 run scoreboard players get @s gm_orient
data modify storage gomoku:visual board set value "classic"
data modify storage gomoku:visual palette set value "ebony"
data modify storage gomoku:visual labels set value "coords"
execute if score @s gm_coords matches 0 run data modify storage gomoku:visual labels set value "plain"
execute if score @s gm_board matches 0 run data modify storage gomoku:visual board set value "classic"
execute if score @s gm_board matches 1 run data modify storage gomoku:visual board set value "wood"
execute if score @s gm_palette matches 0 run data modify storage gomoku:visual palette set value "ebony"
function gomoku:visual/layout with storage gomoku:visual
