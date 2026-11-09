# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @a[tag=ma.actor] remove ma.actor
tag @e[tag=ma.current] remove ma.current
execute unless entity @s[tag=ct.player,tag=ma.player] run return 0
execute unless score @s ma_table = @s ct_id run return 0
execute unless score @s ma_seat = @s ct_seat run return 0
execute if score @s ct_paused matches 1 run return 0
scoreboard players operation #input_table ma_ctx = @s ma_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ma.controller,distance=0..,scores={ct_game=23,ct_state=1}] if score @s ct_id = #input_table ma_ctx unless score @s ct_paused matches 1 run tag @s add ma.current
execute unless entity @e[tag=ma.current,limit=1] run return 0
tag @s add ma.actor
execute as @e[tag=ma.current,limit=1] at @s run function magical_athlete:system/context
# direct-v2
execute if entity @s[nbt={Health:0.0f}] run tag @s remove ma.actor
