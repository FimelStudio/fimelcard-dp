# 第二版只增加Q键丢弃事件记分项，不重置任何现有牌桌或游戏状态
scoreboard objectives add fc_drop_copper minecraft.dropped:minecraft.copper_ingot
scoreboard objectives add fc_drop_iron minecraft.dropped:minecraft.iron_ingot
scoreboard objectives add fc_drop_gold minecraft.dropped:minecraft.gold_ingot
scoreboard objectives add fc_drop_diamond minecraft.dropped:minecraft.diamond
scoreboard objectives add fc_drop_emerald minecraft.dropped:minecraft.emerald
scoreboard players set #version fc_ctx 2
