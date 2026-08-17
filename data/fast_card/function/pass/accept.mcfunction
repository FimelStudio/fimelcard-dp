# 计算顺时针下一座位
scoreboard players operation #next_seat fc_ctx = #ctx_turn fc_ctx
scoreboard players add #next_seat fc_ctx 1
execute if score #next_seat fc_ctx matches 5 run scoreboard players set #next_seat fc_ctx 1

# 找到下一名玩家；临时标签全局清理可防止其他牌桌的残留标签被limit选中
tag @a[tag=fc.receiver] remove fc.receiver
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx if score @s fc_seat = #next_seat fc_ctx run tag @s add fc.receiver
execute unless entity @a[tag=fc.receiver,limit=1] run return fail

# 直接把完整物品堆复制到下一家的首个空快捷栏，再删除地面实体
# 先完成收牌再切换回合，当前出牌者始终就是持有5张牌的人
scoreboard players set #target_slot fc_ctx -1
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.0 * run scoreboard players set #target_slot fc_ctx 0
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.1 * run scoreboard players set #target_slot fc_ctx 1
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.2 * run scoreboard players set #target_slot fc_ctx 2
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.3 * run scoreboard players set #target_slot fc_ctx 3
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.4 * run scoreboard players set #target_slot fc_ctx 4
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.5 * run scoreboard players set #target_slot fc_ctx 5
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.6 * run scoreboard players set #target_slot fc_ctx 6
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.7 * run scoreboard players set #target_slot fc_ctx 7
execute if score #target_slot fc_ctx matches -1 unless items entity @a[tag=fc.receiver,limit=1] hotbar.8 * run scoreboard players set #target_slot fc_ctx 8
execute unless score #target_slot fc_ctx matches 0..8 run tellraw @a[tag=fc.sender,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'下一家的快捷栏没有空位，传牌未执行。',color:'red'}]
execute unless score #target_slot fc_ctx matches 0..8 run tag @a[tag=fc.receiver] remove fc.receiver
execute unless score #target_slot fc_ctx matches 0..8 run return fail

execute if score #target_slot fc_ctx matches 0 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.0 from entity @s contents
execute if score #target_slot fc_ctx matches 1 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.1 from entity @s contents
execute if score #target_slot fc_ctx matches 2 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.2 from entity @s contents
execute if score #target_slot fc_ctx matches 3 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.3 from entity @s contents
execute if score #target_slot fc_ctx matches 4 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.4 from entity @s contents
execute if score #target_slot fc_ctx matches 5 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.5 from entity @s contents
execute if score #target_slot fc_ctx matches 6 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.6 from entity @s contents
execute if score #target_slot fc_ctx matches 7 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.7 from entity @s contents
execute if score #target_slot fc_ctx matches 8 run item replace entity @a[tag=fc.receiver,limit=1] hotbar.8 from entity @s contents
scoreboard players set #pass_done fc_ctx 1

# 更新控制器和当前出牌者标签
execute as @e[type=minecraft:marker,tag=fc.controller] if score @s fc_id = #ctx_id fc_ctx run scoreboard players operation @s fc_turn = #next_seat fc_ctx
execute as @a[tag=fc.turn] if score @s fc_id = #ctx_id fc_ctx run tag @s remove fc.turn
execute as @a[tag=fc.receiver,limit=1] run function fast_card:pass/reset_drop
execute as @a[tag=fc.receiver,limit=1] run tag @s add fc.turn

# 把传牌座位写入storage，由控制器上下文执行宏套宏日志
execute store result storage fast_card:debug from int 1 run scoreboard players get #ctx_turn fc_ctx
execute store result storage fast_card:debug to int 1 run scoreboard players get #next_seat fc_ctx
execute as @e[type=minecraft:marker,tag=fc.controller] if score @s fc_id = #ctx_id fc_ctx run function fast_card:debug/log_pass with storage fast_card:debug

# 广播传牌结果
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{selector:'@a[tag=fc.sender,limit=1]',color:'yellow'},{text:' 向 ',color:'gray'},{selector:'@a[tag=fc.receiver,limit=1]',color:'yellow'},{text:' 传出了一张牌。',color:'gray'}]
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.5 1.4

# 重新以控制器为执行者显示下一回合提示
execute as @e[type=minecraft:marker,tag=fc.controller] if score @s fc_id = #ctx_id fc_ctx run function fast_card:util/announce_turn
tag @a[tag=fc.receiver] remove fc.receiver
kill @s
