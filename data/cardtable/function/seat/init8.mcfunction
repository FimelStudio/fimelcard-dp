tag @s add ct.part
tag @s add ct.seat
tag @s add ct.seat8
scoreboard players operation @s ct_id = #seat_owner ct_ctx
scoreboard players operation @s ct_seat = #new_seat ct_ctx
scoreboard players operation @s ct_kind = #new_seat ct_ctx
scoreboard players add @s ct_kind 10
data merge entity @s {width:0.96f,height:0.372f,response:1b}
