execute if score #found hb_ctx matches 1 run return 0
scoreboard players add @s hb_scan 1
execute if score @s hb_scan matches 9.. run scoreboard players set @s hb_scan 1
scoreboard players operation #target_seat hb_ctx = @s hb_scan
# 牌库见底后手牌会逐渐减少；已经没有普通手牌的座位自动跳过
scoreboard players set #seat_cards hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run scoreboard players add #seat_cards hb_ctx 1
execute if score #seat_cards hb_ctx matches 1.. as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run tag @s add hb.turn
execute as @a[tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set #found hb_ctx 1
