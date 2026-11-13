# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 局数过场、发牌、传牌、抢按、结算以及旧版暂停状态都需要检测掉线
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1..5}] at @s run function fast_card:system/maintenance_one
