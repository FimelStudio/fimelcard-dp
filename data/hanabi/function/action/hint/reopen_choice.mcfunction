# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s hb_target matches 1 run function hanabi:dialog/hint/choice {seat:1}
execute if score @s hb_target matches 2 run function hanabi:dialog/hint/choice {seat:2}
execute if score @s hb_target matches 3 run function hanabi:dialog/hint/choice {seat:3}
execute if score @s hb_target matches 4 run function hanabi:dialog/hint/choice {seat:4}
execute if score @s hb_target matches 5 run function hanabi:dialog/hint/choice {seat:5}
execute if score @s hb_target matches 6 run function hanabi:dialog/hint/choice {seat:6}
execute if score @s hb_target matches 7 run function hanabi:dialog/hint/choice {seat:7}
execute if score @s hb_target matches 8 run function hanabi:dialog/hint/choice {seat:8}

