function gomoku:visual/context
data modify storage gomoku:visual duration set value 0
execute as @e[tag=gm.falling] if score @s ct_id = #vis_table gm_ctx run function gomoku:visual/fall
execute as @e[tag=gm.falling] if score @s ct_id = #vis_table gm_ctx run tag @s remove gm.falling
execute as @e[tag=gm.retracting] if score @s ct_id = #vis_table gm_ctx run kill @s
function gomoku:visual/select
