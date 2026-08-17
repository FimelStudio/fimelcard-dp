# 移除本数据包生成的游戏牌，不触碰玩家其他物品
function fast_card:util/clear_cards
function fast_card:pass/reset_drop

# 只清理Fast Card运行期标签；通用牌桌身份和骑乘关系继续保留
tag @s remove fc.player
tag @s remove fc.turn
tag @s remove fc.pressed
tag @s remove fc.winner
tag @s remove fc.ranked
tag @s remove fc.rank_pick
tag @s remove fc.receiver
tag @s remove fc.sender
tag @s remove fc.clicker

# 清理本局分数
scoreboard players reset @s fc_id
scoreboard players reset @s fc_seat
scoreboard players reset @s fc_score
scoreboard players reset @s fc_order
scoreboard players reset @s fc_count
scoreboard players reset @s fc_aux
scoreboard players reset @s fc_result
scoreboard players reset @s fc_delta
