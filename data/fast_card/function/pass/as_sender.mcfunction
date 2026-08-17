# 只有当前玩家本刻确实丢过纸，且丢牌后恰好剩4张游戏牌，才检查地面牌
tag @s add fc.sender
function fast_card:hand/count_cards
scoreboard players set #drop_event fc_ctx 0
execute if score @s fc_drop_paper matches 1.. run scoreboard players set #drop_event fc_ctx 1
execute if score #drop_event fc_ctx matches 1 if score @s fc_count matches 4 at @s as @e[type=minecraft:item,distance=..1.5,sort=nearest] if score #pass_done fc_ctx matches 0 run function fast_card:pass/check_item
function fast_card:pass/reset_drop
tag @s remove fc.sender
