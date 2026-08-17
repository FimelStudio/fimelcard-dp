# 游戏实例与状态
scoreboard objectives add fc_id dummy
scoreboard objectives add fc_state dummy
scoreboard objectives add fc_prev dummy
scoreboard objectives add fc_seat dummy
scoreboard objectives add fc_kind dummy
scoreboard objectives add fc_joined dummy
scoreboard objectives add fc_round dummy
scoreboard objectives add fc_max dummy
scoreboard objectives add fc_rule dummy
scoreboard objectives add fc_turn dummy
scoreboard objectives add fc_press dummy
scoreboard objectives add fc_mode dummy
scoreboard objectives add fc_timer dummy
scoreboard objectives add fc_phase dummy
scoreboard objectives add fc_deal dummy

# 玩家、牌组和临时计算
scoreboard objectives add fc_score dummy
scoreboard objectives add fc_order dummy
scoreboard objectives add fc_card dummy
scoreboard objectives add fc_count dummy
scoreboard objectives add fc_aux dummy
scoreboard objectives add fc_result dummy
scoreboard objectives add fc_rank dummy
scoreboard objectives add fc_delta dummy

# 游戏设置对话框：首位1表示乱按忽略、2表示立即判负，后续数字为局数；另存打开时的牌桌编号
scoreboard objectives add fc_settings trigger
scoreboard objectives add fc_set_table dummy

# 玩家主动丢弃纸的统计，仅用作Q键事件门控
scoreboard objectives add fc_drop_paper minecraft.dropped:minecraft.paper

# 初始化持久化系统值
scoreboard players set #next_id fc_ctx 0
scoreboard players set #clock fc_ctx 0
scoreboard players set #version fc_ctx 5

tellraw @a [{text:'[Fast Card] ',color:'gold'},{text:'数据包安装完成。',color:'green'}]
