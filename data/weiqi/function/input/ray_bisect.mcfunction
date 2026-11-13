# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #ray_mid go_ctx = #ray_low go_ctx
scoreboard players operation #ray_mid go_ctx += #ray_high go_ctx
scoreboard players set #ray_two go_ctx 2
scoreboard players operation #ray_mid go_ctx /= #ray_two go_ctx
function weiqi:input/ray_probe
execute if score #ray_below go_ctx matches 1 run scoreboard players operation #ray_high go_ctx = #ray_mid go_ctx
execute if score #ray_below go_ctx matches 0 run scoreboard players operation #ray_low go_ctx = #ray_mid go_ctx
scoreboard players remove #ray_count go_ctx 1
execute if score #ray_count go_ctx matches 1.. run function weiqi:input/ray_bisect
