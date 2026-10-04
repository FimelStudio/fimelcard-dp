scoreboard players set @s fc_timer 0
scoreboard players operation #ctx_id fc_ctx = @s fc_id

# 前16张按1、2、3、4号座位循环发放，第17张发给随机首位玩家
scoreboard players operation #deal_seat fc_ctx = @s fc_deal
scoreboard players set #seat_count fc_ctx 4
scoreboard players operation #deal_seat fc_ctx %= #seat_count fc_ctx
scoreboard players add #deal_seat fc_ctx 1
execute if score @s fc_deal matches 16 run scoreboard players operation #deal_seat fc_ctx = @s fc_turn

# 暴露本次发牌序号和目标座位，供发牌动画和调试日志读取
scoreboard players operation #deal_index fc_ctx = @s fc_deal
scoreboard players add #deal_index fc_ctx 1
execute store result storage fast_card:deal index int 1 run scoreboard players get #deal_index fc_ctx
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx if score @s fc_seat = #deal_seat fc_ctx store result storage fast_card:deal seat int 1 run scoreboard players get @s ct_seat
function cardtable:animation/deal/sound

# 从牌盒上方生成真实纸牌，并让它飞向本次接收玩家
function fast_card:deal/one

scoreboard players add @s fc_deal 1
execute if score @s fc_deal matches 17.. run function fast_card:deal/finish
