# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s it_pulse 0
function ito:system/context
scoreboard players set #online it_ctx 0
execute as @a[tag=it.audience] run scoreboard players add #online it_ctx 1
function ito:hud/refresh
