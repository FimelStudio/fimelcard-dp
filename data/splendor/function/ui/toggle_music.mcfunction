# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s sp_music 1
execute if score @s sp_music matches 2.. run scoreboard players set @s sp_music 0
function splendor:sound/stop
execute if score @s sp_music matches 1 run function splendor:sound/start
