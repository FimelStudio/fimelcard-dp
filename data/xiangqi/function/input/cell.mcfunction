# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #ui_click_table xq_ctx = @s ct_id
scoreboard players operation #target xq_ctx = @s xq_sq
tag @a[tag=xq.actor] remove xq.actor
execute on target if entity @s[type=minecraft:player] run function xiangqi:input/cell_player
data remove entity @s interaction
tag @a[tag=xq.actor] remove xq.actor
