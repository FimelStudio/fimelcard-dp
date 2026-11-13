# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if entity @s[nbt={Health:0.0f}] run scoreboard players set @s sp_idrop 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute if score @s sp_ifull matches 1.. run scoreboard players remove @s sp_ifull 1
function splendor:inventory/sync
scoreboard players set @s sp_idrop 0
