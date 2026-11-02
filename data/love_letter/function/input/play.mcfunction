# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s ll_pick matches 0..1 run return run function love_letter:input/invalid
scoreboard players operation #slot ll_ctx = @s ll_pick
dialog clear @s
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/play
execute unless score #ok ll_ctx matches 1 run function love_letter:input/invalid
