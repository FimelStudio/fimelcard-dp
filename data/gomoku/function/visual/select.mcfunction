function gomoku:visual/context
execute as @e[tag=gm.highlight] if score @s ct_id = #vis_table gm_ctx run kill @s
execute if score @s gm_sel matches 0..360 run function gomoku:visual/selection
execute if score @s gm_mark matches 1 if data entity @s data.gomoku.last.sq run function gomoku:visual/last
data modify storage gomoku:visual winning set value []
data modify storage gomoku:visual winning set from entity @s data.gomoku.win
execute if data storage gomoku:visual winning[0] run function gomoku:visual/win_loop
