# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s sp_htimer matches 1.. run return 0
scoreboard players remove @s sp_htimer 1
execute if score @s sp_htimer matches 0 run function splendor:hud/build
