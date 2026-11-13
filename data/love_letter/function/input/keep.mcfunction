# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #keep ll_ctx = #ui_action ll_ctx
scoreboard players remove #keep ll_ctx 300
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/keep
