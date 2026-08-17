# 发牌完成后以实际持有5张牌的玩家为首位出牌者，消除回合和手牌不同步
scoreboard players set #five_count fc_ctx 0
scoreboard players set #actual_turn fc_ctx 0
tag @a[tag=fc.five_cards] remove fc.five_cards
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:hand/count_cards
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx if score @s fc_count matches 5 run tag @s add fc.five_cards
execute as @a[tag=fc.five_cards] if score @s fc_id = #ctx_id fc_ctx run scoreboard players add #five_count fc_ctx 1
execute as @a[tag=fc.five_cards] if score @s fc_id = #ctx_id fc_ctx run scoreboard players operation #actual_turn fc_ctx = @s fc_seat
execute if score #five_count fc_ctx matches 1 run scoreboard players operation @s fc_turn = #actual_turn fc_ctx
execute unless score #five_count fc_ctx matches 1 run function fast_card:log {text:"发牌校验异常：持有5张牌的玩家数量不是1"}
tag @a[tag=fc.five_cards] remove fc.five_cards
