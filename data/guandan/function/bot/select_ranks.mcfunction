execute unless data storage guandan:bot need[0] run return 0
execute store result score #bot_rank gd_ctx run data get storage guandan:bot need[0]
data remove storage guandan:bot need[0]
scoreboard players set #bot_card gd_ctx 999
execute as @e[tag=gd.cards,scores={gd_sel=0}] if score @s gd_owner = #actor gd_ctx if score @s gd_point = #bot_rank gd_ctx run scoreboard players operation #bot_card gd_ctx < @s gd_id
execute if score #bot_card gd_ctx matches 999 if score #bot_rank gd_ctx matches 2..14 as @e[tag=gd.cards,scores={gd_sel=0,gd_wild=1}] if score @s gd_owner = #actor gd_ctx run scoreboard players operation #bot_card gd_ctx < @s gd_id
execute if score #bot_card gd_ctx matches 999 run scoreboard players set #bot_valid gd_ctx 0
execute as @e[tag=gd.cards,scores={gd_sel=0}] if score @s gd_owner = #actor gd_ctx if score @s gd_id = #bot_card gd_ctx run scoreboard players set @s gd_sel 1
function guandan:bot/select_ranks
