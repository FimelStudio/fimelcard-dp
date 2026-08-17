# 第四版将Fast Card牌统一改为带item_model和custom_data的纸牌
# 仅增加新的Q键丢弃统计，不重置牌桌、玩家分数或正在运行的游戏
scoreboard objectives add fc_drop_paper minecraft.dropped:minecraft.paper
scoreboard players set #version fc_ctx 4
