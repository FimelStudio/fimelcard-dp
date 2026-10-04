function doudizhu:player/audience
scoreboard players set @s dd_bot_timer 0
scoreboard players operation #turn dd_ctx = @s dd_turn
scoreboard players operation #phase dd_ctx = @s dd_state
execute as @e[tag=dd.actors] if score @s dd_seat = #turn dd_ctx if score #phase dd_ctx matches 2 run tellraw @a[tag=dd.audience] [{text:"轮到 ",color:"gray"},{selector:"@s",color:"yellow"},{text:" 叫分。按Q打开手牌。",color:"gray"}]
execute as @a[tag=dd.audience] if score @s dd_seat = #turn dd_ctx if score #phase dd_ctx matches 3 run tellraw @a[tag=dd.audience] [{text:"轮到 ",color:"gray"},{selector:"@s",color:"yellow"},{text:" 出牌。按Q打开手牌。",color:"gray"}]
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
