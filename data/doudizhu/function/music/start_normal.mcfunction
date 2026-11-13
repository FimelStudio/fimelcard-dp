# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function doudizhu:music/stop
scoreboard players set @s dd_music 1
scoreboard players set @s dd_mtime 580
execute at @s run playsound card:doudizhu.normal record @s ~ ~ ~ 1 1 1
