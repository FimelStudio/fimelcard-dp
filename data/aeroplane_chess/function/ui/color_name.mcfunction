# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @e[tag=ac.current,limit=1] ac_turn matches 0 run data modify storage aeroplane_chess:ui color set value "红"
execute if score @e[tag=ac.current,limit=1] ac_turn matches 1 run data modify storage aeroplane_chess:ui color set value "蓝"
execute if score @e[tag=ac.current,limit=1] ac_turn matches 2 run data modify storage aeroplane_chess:ui color set value "绿"
execute if score @e[tag=ac.current,limit=1] ac_turn matches 3 run data modify storage aeroplane_chess:ui color set value "黄"
execute if score @e[tag=ac.current,limit=1] ac_state matches 5 if score @e[tag=ac.current,limit=1] ac_winner matches 0 run data modify storage aeroplane_chess:ui color set value "红"
execute if score @e[tag=ac.current,limit=1] ac_state matches 5 if score @e[tag=ac.current,limit=1] ac_winner matches 1 run data modify storage aeroplane_chess:ui color set value "蓝"
execute if score @e[tag=ac.current,limit=1] ac_state matches 5 if score @e[tag=ac.current,limit=1] ac_winner matches 2 run data modify storage aeroplane_chess:ui color set value "绿"
execute if score @e[tag=ac.current,limit=1] ac_state matches 5 if score @e[tag=ac.current,limit=1] ac_winner matches 3 run data modify storage aeroplane_chess:ui color set value "黄"
execute if score @s ac_color matches 0 run data modify storage aeroplane_chess:ui own set value "红"
execute if score @s ac_color matches 1 run data modify storage aeroplane_chess:ui own set value "蓝"
execute if score @s ac_color matches 2 run data modify storage aeroplane_chess:ui own set value "绿"
execute if score @s ac_color matches 3 run data modify storage aeroplane_chess:ui own set value "黄"
