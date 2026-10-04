execute if score #found hb_ctx matches 1 run return 0
scoreboard players add @s hb_scan 1
execute if score @s hb_scan matches 9.. run scoreboard players set @s hb_scan 1
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #target_seat hb_ctx = @s hb_scan
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run tag @s add hb.deal_receiver
execute if entity @a[tag=hb.deal_receiver,limit=1] run scoreboard players set #found hb_ctx 1

