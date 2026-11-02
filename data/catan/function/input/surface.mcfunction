# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @s add ca.surface
scoreboard players operation @s ct_id = #input_table ca_ctx
$data merge entity @s {width:$(width),height:0.035f,response:1b}
