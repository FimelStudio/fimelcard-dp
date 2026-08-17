# 第三版：增加最佳五张牌记录和逐人摊牌展示状态
scoreboard objectives add lh_b1 dummy
scoreboard objectives add lh_b2 dummy
scoreboard objectives add lh_b3 dummy
scoreboard objectives add lh_b4 dummy
scoreboard objectives add lh_b5 dummy
scoreboard objectives add lh_place dummy
scoreboard objectives add lh_in_showdown dummy
scoreboard objectives add lh_is_winner dummy
scoreboard objectives add lh_shown dummy
scoreboard objectives add lh_show_seat dummy
scoreboard objectives add lh_show_count dummy
scoreboard objectives add lh_show_phase dummy
scoreboard players set #version lh_ctx 3

# 旧版正在进行的摊牌缺少最佳五张牌记录，安全结束当前小局后重新发牌
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=14..15}] at @s run function liars_holdem:round/end
tellraw @a[tag=lh.player] [{text:'[赌命德州扑克] ',color:'red'},{text:'摊牌展示系统已升级。',color:'green'}]
