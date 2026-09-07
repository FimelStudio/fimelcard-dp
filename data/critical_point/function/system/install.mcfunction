scoreboard objectives add cp_id dummy
scoreboard objectives add cp_state dummy
scoreboard objectives add cp_round dummy
scoreboard objectives add cp_threshold dummy
scoreboard objectives add cp_timer dummy
scoreboard objectives add cp_seat dummy
scoreboard objectives add cp_role dummy
scoreboard objectives add cp_play dummy
scoreboard objectives add cp_locked dummy
scoreboard objectives add cp_ready dummy
scoreboard objectives add cp_vote dummy
scoreboard objectives add cp_vote_used dummy
scoreboard objectives add cp_action trigger
scoreboard objectives add cp_drop minecraft.dropped:minecraft.paper
scoreboard objectives add cp_drop_red minecraft.dropped:minecraft.red_dye
scoreboard objectives add cp_drop_lime minecraft.dropped:minecraft.lime_dye
scoreboard objectives add cp_drop_reopen minecraft.dropped:minecraft.purple_dye
scoreboard players set #three cp_ctx 3
scoreboard players set #version cp_ctx 2
tellraw @a [{text:'[临界点] ',color:'red'},{text:'游戏模块安装完成。',color:'green'}]
