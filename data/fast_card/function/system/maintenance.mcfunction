# 局数过场、发牌、传牌、抢按、结算以及旧版暂停状态都需要检测掉线
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1..5}] at @s run function fast_card:system/maintenance_one
