# 控制器、实体和牌局状态
scoreboard objectives add lh_id dummy
scoreboard objectives add lh_state dummy
scoreboard objectives add lh_phase dummy
scoreboard objectives add lh_timer dummy
scoreboard objectives add lh_limit dummy
scoreboard objectives add lh_round dummy
scoreboard objectives add lh_dealer dummy
scoreboard objectives add lh_turn dummy
scoreboard objectives add lh_scan dummy
scoreboard objectives add lh_deal dummy
scoreboard objectives add lh_total dummy
scoreboard objectives add lh_active dummy
scoreboard objectives add lh_alive_count dummy
scoreboard objectives add lh_flipped dummy
scoreboard objectives add lh_allin dummy
scoreboard objectives add lh_auto dummy
scoreboard objectives add lh_return dummy

# 四个座位的整场存活状态保存在控制器上，便于处理离线玩家
scoreboard objectives add lh_a1 dummy
scoreboard objectives add lh_a2 dummy
scoreboard objectives add lh_a3 dummy
scoreboard objectives add lh_a4 dummy

# 卡牌实体和临时计算
scoreboard objectives add lh_card dummy
scoreboard objectives add lh_rank dummy
scoreboard objectives add lh_suit dummy
scoreboard objectives add lh_slot dummy
scoreboard objectives add lh_seat dummy
scoreboard objectives add lh_hand_count dummy

# 玩家当前局状态
scoreboard objectives add lh_alive dummy
scoreboard objectives add lh_fold dummy
scoreboard objectives add lh_wait dummy
scoreboard objectives add lh_done dummy
scoreboard objectives add lh_bullets dummy
scoreboard objectives add lh_swap dummy
scoreboard objectives add lh_swap_slot dummy
scoreboard objectives add lh_swap_pending dummy
scoreboard objectives add lh_drop_retry dummy
scoreboard objectives add lh_pending_gun dummy

# 左轮判定
scoreboard objectives add lh_gun_seat dummy
scoreboard objectives add lh_gun_result dummy
scoreboard objectives add lh_gun_time dummy

# 七张牌最佳牌型及五级比较键
scoreboard objectives add lh_cat dummy
scoreboard objectives add lh_value dummy
scoreboard objectives add lh_k1 dummy
scoreboard objectives add lh_k2 dummy
scoreboard objectives add lh_k3 dummy
scoreboard objectives add lh_k4 dummy
scoreboard objectives add lh_k5 dummy
scoreboard objectives add lh_b1 dummy
scoreboard objectives add lh_b2 dummy
scoreboard objectives add lh_b3 dummy
scoreboard objectives add lh_b4 dummy
scoreboard objectives add lh_b5 dummy
scoreboard objectives add lh_place dummy
scoreboard objectives add lh_in_showdown dummy
scoreboard objectives add lh_is_winner dummy
scoreboard objectives add lh_shown dummy

# 摊牌逐人亮牌流程保存在控制器上
scoreboard objectives add lh_show_seat dummy
scoreboard objectives add lh_show_count dummy
scoreboard objectives add lh_show_phase dummy

# 设置、规则跳转和换牌Dialog均通过普通玩家可用的trigger提交
scoreboard objectives add lh_settings trigger
scoreboard objectives add lh_help trigger
scoreboard objectives add lh_swap_pick trigger
scoreboard objectives add lh_set_table dummy

# Q键丢弃门控：纸牌、跟注物品和弃牌物品分别统计
scoreboard objectives add lh_drop_card minecraft.dropped:minecraft.paper
scoreboard objectives add lh_drop_call minecraft.dropped:minecraft.lime_dye
scoreboard objectives add lh_drop_fold minecraft.dropped:minecraft.red_dye

scoreboard players set #clock lh_ctx 0
scoreboard players set #two lh_ctx 2
scoreboard players set #twenty lh_ctx 20
scoreboard players set #base lh_ctx 15
scoreboard players set #version lh_ctx 4
tellraw @a [{text:'[赌命德州扑克] ',color:'red'},{text:'游戏模块安装完成。',color:'green'}]
