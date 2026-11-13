# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players remove @s dd_timer 1
execute unless score @s dd_timer matches ..0 run return 0
execute if score @s dd_round < @s dd_limit run return run function doudizhu:game/next_round
function doudizhu:game/finish_match
