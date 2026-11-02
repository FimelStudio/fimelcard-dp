# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function gomoku:visual/context
data modify storage gomoku:visual duration set value 5
execute as @e[tag=gm.falling] if score @s ct_id = #vis_table gm_ctx if data entity @s data.gomoku_visual{started:0b} run function gomoku:visual/fall
