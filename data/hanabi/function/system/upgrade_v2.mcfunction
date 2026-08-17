# 第二版将本人Actionbar改为实体手牌，并增加F/Q输入统计；不重置正在运行的牌局
scoreboard objectives add hb_drop_card minecraft.dropped:minecraft.paper
scoreboard objectives add hb_drop_hint minecraft.dropped:minecraft.firework_star
scoreboard players set @a[tag=hb.player] hb_drop_card 0
scoreboard players set @a[tag=hb.player] hb_drop_hint 0
scoreboard players set #version hb_ctx 2
tellraw @a[tag=hb.player] [{text:'[花火] ',color:'light_purple'},{text:'操作已升级：手牌按F出牌、按Q弃牌，提示物按Q使用。',color:'green'}]
