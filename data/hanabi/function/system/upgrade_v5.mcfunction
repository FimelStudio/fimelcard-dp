# 第五版加入桌级提示/失误上限、彩色风暴、奖励牌接口与独立设置trigger
scoreboard objectives add hb_clue_max dummy
scoreboard objectives add hb_strike_max dummy
scoreboard objectives add hb_mstack dummy
scoreboard objectives add hb_storm dummy
scoreboard objectives add hb_reward dummy
scoreboard objectives add hb_settings trigger
scoreboard objectives add hb_set_table dummy
execute as @e[type=minecraft:marker,tag=ct.controller] run function hanabi:game/init_table
scoreboard players add @e[type=minecraft:marker,tag=hb.controller] hb_mstack 0
scoreboard players add @e[type=minecraft:marker,tag=hb.game_entity] hb_reward 0
scoreboard players set #version hb_ctx 5
tellraw @a [{text:'[花火] ',color:'light_purple'},{text:'已加入可配置提示/失误上限与“彩色风暴”扩展。',color:'green'}]
