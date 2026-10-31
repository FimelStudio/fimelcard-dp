# HUD 仅新增私有面板目标，保留真实牌组、分数、队列及当前回合。
scoreboard objectives add un_panel dummy
scoreboard objectives add un_prev_panel dummy
scoreboard objectives add un_hud_dirty dummy
scoreboard players set #version un_ctx 3
