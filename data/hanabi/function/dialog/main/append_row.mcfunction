# 直接从本桌权威手牌构造该座位的公开牌面，不依赖距离选择器
$scoreboard players set #row_seat hb_ctx $(seat)
$data modify storage hanabi:dialog row_piece set value {text:"$(seat)号座位　",color:"white",extra:[]}
scoreboard players set #row_added hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=1}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/main/append_public_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=2}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/main/append_public_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=3}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/main/append_public_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=4}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/main/append_public_card
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=5}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #row_seat hb_ctx run function hanabi:dialog/main/append_public_card
execute unless score #row_added hb_ctx matches 1.. run return 0
data modify storage hanabi:dialog rows.extra append from storage hanabi:dialog row_piece
data modify storage hanabi:dialog rows.extra append value {text:"\n"}
