scoreboard objectives add bw_id dummy
scoreboard objectives add bw_state dummy
scoreboard objectives add bw_timer dummy
scoreboard objectives add bw_round dummy
scoreboard objectives add bw_turn dummy
scoreboard objectives add bw_seat dummy
scoreboard objectives add bw_role dummy
scoreboard objectives add bw_score dummy
scoreboard objectives add bw_question dummy
scoreboard objectives add bw_used dummy
scoreboard objectives add bw_bs dummy
scoreboard objectives add bw_action trigger
scoreboard objectives add bw_drop minecraft.dropped:minecraft.paper
scoreboard objectives add bw_drop_dye minecraft.dropped:minecraft.lime_dye
scoreboard players set #version bw_ctx 2
tellraw @a [{text:'[瞎掰王] ',color:'yellow'},{text:'基础游戏模块安装完成。',color:'green'}]
