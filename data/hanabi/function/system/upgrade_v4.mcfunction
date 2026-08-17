# 第四版将其他玩家手牌从Bossbar迁移到BetterTitle左侧独立面板。
scoreboard objectives add hb_panel dummy
scoreboard objectives add hb_prev_panel dummy
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2}] at @s run function hanabi:bar/remove_all
scoreboard players set #version hb_ctx 4
tellraw @a[tag=hb.player] [{text:'[花火] ',color:'light_purple'},{text:'其他玩家的手牌已迁移到屏幕左侧面板。',color:'green'}]
