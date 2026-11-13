# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result storage abraca:pile p1 int 1 run scoreboard players get @s ab_play_1
execute store result storage abraca:pile p2 int 1 run scoreboard players get @s ab_play_2
execute store result storage abraca:pile p3 int 1 run scoreboard players get @s ab_play_3
execute store result storage abraca:pile p4 int 1 run scoreboard players get @s ab_play_4
execute store result storage abraca:pile p5 int 1 run scoreboard players get @s ab_play_5
execute store result storage abraca:pile p6 int 1 run scoreboard players get @s ab_play_6
execute store result storage abraca:pile p7 int 1 run scoreboard players get @s ab_play_7
execute store result storage abraca:pile p8 int 1 run scoreboard players get @s ab_play_8
function abraca:ui/show_pile with storage abraca:pile
