# 第七版加入弃牌时间序号和桌角弃牌堆入口
scoreboard objectives add hb_discard_order dummy
scoreboard objectives add hb_discard_count dummy
execute as @e[type=minecraft:marker,tag=hb.controller] at @s run function hanabi:discard/migrate_table
scoreboard players set #version hb_ctx 7
tellraw @a [{text:"[花火] ",color:"light_purple"},{text:"弃牌堆已升级为按弃牌先后排序的五列Dialog。",color:"green"}]
