# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #plane ac_ctx = #ui_action ac_ctx
scoreboard players remove #plane ac_ctx 2
execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/choose
dialog clear @s
