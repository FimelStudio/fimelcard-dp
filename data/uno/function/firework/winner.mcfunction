# 由确认获胜的 UNO 控制器调用；不在出完末张但仍待质疑时调用。
# 使用通用真实座椅定位，因此四座、八座和稀疏入座均无需复制坐标。
execute unless entity @s[type=minecraft:marker,tag=un.controller] run return 0
execute unless score @s un_winner matches 1..8 run return 0
scoreboard players operation #u_fw_table un_ctx = @s ct_id
scoreboard players operation #u_fw_seat un_ctx = @s un_winner
scoreboard players set #u_fw_done un_ctx 0
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #u_fw_table un_ctx if score @s ct_seat = #u_fw_seat un_ctx at @s run function uno:firework/launch
# 兼容缺失座椅的测试环境或修复中的牌桌；不使用 nearest 认定胜者。
execute if score #u_fw_done un_ctx matches 0 as @e[tag=un.player] if score @s ct_id = #u_fw_table un_ctx if score @s un_table = #u_fw_table un_ctx if score @s un_seat = #u_fw_seat un_ctx at @s run function uno:firework/launch
return run scoreboard players get #u_fw_done un_ctx
