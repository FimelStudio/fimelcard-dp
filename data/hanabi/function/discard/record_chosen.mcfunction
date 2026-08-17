# 当前执行者是本桌控制器，hb.chosen是本次刚进入弃牌堆的权威牌标记
scoreboard players add @s hb_discard_count 1
scoreboard players operation @e[type=minecraft:marker,tag=hb.chosen,limit=1] hb_discard_order = @s hb_discard_count
