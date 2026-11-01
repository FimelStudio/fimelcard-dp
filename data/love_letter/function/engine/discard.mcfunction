# 执行者为参与者；弃牌只记公开牌与间谍，不触发该角色技能。
execute unless score #discard ll_ctx matches 0..9 run return 0
execute store result storage love_letter:runtime card int 1 run scoreboard players get #discard ll_ctx
data modify entity @s data.discards append from storage love_letter:runtime card
execute if score #discard ll_ctx matches 0 run scoreboard players set @s ll_spy 1
