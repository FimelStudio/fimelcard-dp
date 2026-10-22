scoreboard players set @s dd_autopass -1
function doudizhu:input/sync
function doudizhu:player/audience
scoreboard players set @s dd_bot_timer 0
scoreboard players operation #turn dd_ctx = @s dd_turn
scoreboard players operation #phase dd_ctx = @s dd_state
scoreboard players operation #bidmode dd_ctx = @s dd_bidmode
execute as @e[tag=dd.actors] if score @s dd_seat = #turn dd_ctx if score #phase dd_ctx matches 2 unless score #bidmode dd_ctx matches 1..2 run tellraw @a[tag=dd.audience] [{text:"轮到 ",color:"gray"},{selector:"@s",color:"yellow"},{text:" 叫分。按Q打开选择。",color:"gray"}]
execute as @a[tag=dd.audience] if score @s dd_seat = #turn dd_ctx if score #phase dd_ctx matches 3 run tellraw @a[tag=dd.audience] [{text:"轮到 ",color:"gray"},{selector:"@s",color:"yellow"},{text:" 出牌。按Q打开手牌。",color:"gray"}]
execute if score #phase dd_ctx matches 2 if score #bidmode dd_ctx matches 1 as @e[tag=dd.actors] if score @s dd_seat = #turn dd_ctx run tellraw @a[tag=dd.audience] [{text:"轮到 ",color:"gray"},{selector:"@s",color:"yellow"},{text:" 操作，按Q打开选择。",color:"gray"}]
execute if score #phase dd_ctx matches 2 if score #bidmode dd_ctx matches 2 run tellraw @a[tag=dd.audience] {text:"手速制开始！前2秒叫地主×4，超过2秒至5秒×2，超过5秒至15秒×1；超时无人叫则重发。按Q打开面板，人机将在3秒后参与。",color:"gold"}
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
