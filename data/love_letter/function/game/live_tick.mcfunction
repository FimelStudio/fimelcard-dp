# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function love_letter:targeting/tick
execute if score @s ll_anim matches 1.. run return run function love_letter:game/anim_tick
execute if score @s ll_time_setting matches 0 run return 0
execute if score @s ll_clock matches 1.. run scoreboard players remove @s ll_clock 1
execute if score @s ll_clock matches 0 run function love_letter:game/timeout
