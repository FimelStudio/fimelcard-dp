# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players remove @s ll_timer 1
execute if score @s ll_timer matches 1.. run return 0
execute if score @s ll_state matches 4 run return run function love_letter:game/cleanup
function love_letter:system/context
scoreboard players operation @s ll_first = @e[tag=ll.board,scores={ll_won=1},sort=random,limit=1] ll_seat
function love_letter:game/round_begin
