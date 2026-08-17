# 原版纸丢弃统计只负责判断本刻是否按Q，普通纸不会被当成卡牌
scoreboard players set #drop_event fc_ctx 0
execute if score @s fc_drop_paper matches 1.. run scoreboard players set #drop_event fc_ctx 1
execute unless score #drop_event fc_ctx matches 1 run return 0

# 丢出物仍保留原玩家所有权；在其拾取延迟结束前将卡牌送回玩家脚下并允许立即拾取
tag @s add fc.return_owner
scoreboard players set #return_done fc_ctx 0
execute at @s as @e[type=minecraft:item,distance=..1.75,sort=nearest] if score #return_done fc_ctx matches 0 run function fast_card:pass/check_return_item
function fast_card:pass/reset_drop
tag @s remove fc.return_owner
