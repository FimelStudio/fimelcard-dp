# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function weiqi:visual/context
data modify storage weiqi:visual duration set value 5
execute as @e[tag=go.falling] if score @s ct_id = #vis_table go_ctx if data entity @s data.weiqi_visual{started:0b} run function weiqi:visual/fall
