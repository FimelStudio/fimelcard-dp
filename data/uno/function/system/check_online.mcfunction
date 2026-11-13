# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function uno:system/context
scoreboard players set @s un_clock 0
scoreboard players set #u_online un_ctx 0
execute as @e[tag=un.audience,tag=ct.player] if score @s ct_id = #table un_ctx run scoreboard players add #u_online un_ctx 1
