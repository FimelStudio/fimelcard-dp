# 兼容制作期间已加载过旧版的存档；保留骰值、移动队列与名次。
scoreboard objectives add ac_finished dummy
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15}] at @s run function aeroplane_chess:system/count_finished
scoreboard players set #version ac_ctx 2
