# 第七版加入弃牌时间序号和桌角弃牌堆入口
scoreboard objectives add hb_discard_order dummy
scoreboard objectives add hb_discard_count dummy
execute as @e[type=minecraft:marker,tag=hb.controller] at @s run function hanabi:discard/migrate_table
scoreboard players set #version hb_ctx 7
