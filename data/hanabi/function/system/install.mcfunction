# 控制器、牌桌实例和阶段
scoreboard objectives add hb_id dummy
scoreboard objectives add hb_state dummy
scoreboard objectives add hb_phase dummy
scoreboard objectives add hb_timer dummy
scoreboard objectives add hb_players dummy
scoreboard objectives add hb_turn dummy
scoreboard objectives add hb_hand_size dummy
scoreboard objectives add hb_deal dummy
scoreboard objectives add hb_total dummy
scoreboard objectives add hb_scan dummy

# 牌库、手牌和提示知识
scoreboard objectives add hb_card dummy
scoreboard objectives add hb_color dummy
scoreboard objectives add hb_rank dummy
scoreboard objectives add hb_seat dummy
scoreboard objectives add hb_slot dummy
scoreboard objectives add hb_hand_count dummy
scoreboard objectives add hb_known_c dummy
scoreboard objectives add hb_known_n dummy
scoreboard objectives add hb_deck_count dummy

# 公共资源、烟花进度和末轮
scoreboard objectives add hb_clues dummy
scoreboard objectives add hb_clue_max dummy
scoreboard objectives add hb_strikes dummy
scoreboard objectives add hb_strike_max dummy
scoreboard objectives add hb_final dummy
scoreboard objectives add hb_score dummy
scoreboard objectives add hb_wstack dummy
scoreboard objectives add hb_rstack dummy
scoreboard objectives add hb_bstack dummy
scoreboard objectives add hb_ystack dummy
scoreboard objectives add hb_gstack dummy
scoreboard objectives add hb_mstack dummy
scoreboard objectives add hb_storm dummy
scoreboard objectives add hb_reason dummy
scoreboard objectives add hb_reward dummy
scoreboard objectives add hb_tool_hint dummy
scoreboard objectives add hb_tool_restore dummy
scoreboard objectives add hb_option dummy
scoreboard objectives add hb_pending_slot dummy
scoreboard objectives add hb_discard_order dummy
scoreboard objectives add hb_discard_count dummy
scoreboard objectives add hb_reward_left dummy
scoreboard objectives add hb_reward_pending dummy

# Dialog、物品栏认知态与每名观察者的独立BetterTitle面板
scoreboard objectives add hb_action trigger
scoreboard objectives add hb_settings trigger
scoreboard objectives add hb_set_table dummy
scoreboard objectives add hb_target dummy
scoreboard objectives add hb_self dummy
scoreboard objectives add hb_panel dummy
scoreboard objectives add hb_prev_panel dummy

# 实体物品输入：纸牌Q出牌、烟火之星Q打开提示；F键直接检测副手
scoreboard objectives add hb_drop_card minecraft.dropped:minecraft.paper
scoreboard objectives add hb_drop_hint minecraft.dropped:minecraft.firework_star
scoreboard objectives add hb_drop_reward minecraft.dropped:minecraft.purple_dye

scoreboard players set #clock hb_ctx 0
scoreboard players set #version hb_ctx 9
tellraw @a [{text:'[花火] ',color:'light_purple'},{text:'游戏模块安装完成。',color:'green'}]
