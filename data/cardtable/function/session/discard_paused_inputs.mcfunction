# @s 为 ct_paused=1 的控制器；在所有游戏 tick 前调用。
scoreboard players operation #pause_table ct_id = @s ct_id
execute as @a[tag=ct.player,scores={ct_paused=1}] if score @s ct_id = #pause_table ct_id run function cardtable:session/discard_paused_player_inputs
# 只丢弃游戏点击，ct.vote / ct.rules / ct.seat 等公共交互完全保留。
execute at @s as @e[type=minecraft:interaction,distance=..6,tag=!ct.vote,tag=!ct.rules,tag=!ct.seat,tag=!ct.menu] if data entity @s interaction run function cardtable:session/check_paused_interaction
execute at @s as @e[type=minecraft:interaction,distance=..6,tag=!ct.vote,tag=!ct.rules,tag=!ct.seat,tag=!ct.menu] if data entity @s attack run function cardtable:session/check_paused_interaction
