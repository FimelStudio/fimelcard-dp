# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #click_table ca_ctx = @s ct_id
execute on target if entity @s[type=minecraft:player] if score @s ca_table = #click_table ca_ctx run function catan:input/aim
data remove entity @s interaction
