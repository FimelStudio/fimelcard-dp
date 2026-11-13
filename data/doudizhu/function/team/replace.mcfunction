# 地主的队友离场。若其已轮空，原来的三副手牌保持原持有人。
scoreboard players operation #lord_seat dd_ctx = @s dd_lord
scoreboard players set #lord_team dd_ctx 0
execute as @e[tag=dd.actors] if score @s dd_seat = #lord_seat dd_ctx run scoreboard players operation #lord_team dd_ctx = @s dd_team
scoreboard players operation #landlord_partner dd_ctx = @s dd_out
execute as @e[tag=dd.actor] if score @s dd_id = #ctx dd_ctx if score @s dd_team = #lord_team dd_ctx unless score @s dd_seat = #lord_seat dd_ctx run scoreboard players operation #landlord_partner dd_ctx = @s dd_seat
execute if score @s dd_out = #landlord_partner dd_ctx run return 0
scoreboard players operation #incoming dd_ctx = @s dd_out
execute as @e[tag=dd.card] if score @s dd_id = #ctx dd_ctx if score @s dd_owner = #landlord_partner dd_ctx run scoreboard players set @s dd_selected 0
execute as @e[tag=dd.card] if score @s dd_id = #ctx dd_ctx if score @s dd_owner = #landlord_partner dd_ctx run scoreboard players operation @s dd_owner = #incoming dd_ctx
execute as @e[tag=dd.actor] if score @s dd_id = #ctx dd_ctx if score @s dd_seat = #landlord_partner dd_ctx run tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 是地主的队友，本局转为轮空。",color:"gray"}]
execute as @e[tag=dd.actor] if score @s dd_id = #ctx dd_ctx if score @s dd_seat = #incoming dd_ctx run tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 接手这副牌，与队友一起当农民。",color:"gray"}]
scoreboard players operation @s dd_out = #landlord_partner dd_ctx
function doudizhu:player/audience
