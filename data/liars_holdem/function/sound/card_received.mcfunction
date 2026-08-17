# 接牌声只发给本张手牌的接收者；两张手牌用不同音高形成递进
execute if score #hand_slot lh_ctx matches 1 as @a[tag=lh.deal_receiver] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:entity.item.pickup player @s ~ ~ ~ 0.45 1.15
execute if score #hand_slot lh_ctx matches 2 as @a[tag=lh.deal_receiver] if score @s lh_id = #ctx_id lh_ctx at @s run playsound minecraft:entity.item.pickup player @s ~ ~ ~ 0.45 1.40
