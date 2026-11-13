tag @s add gd.card
tag @s add gd.cards
scoreboard players operation @s ct_id = #table gd_ctx
scoreboard players operation @s gd_id = #build gd_ctx
scoreboard players operation @s gd_type = #build gd_ctx
scoreboard players operation @s gd_type %= #fiftyfour gd_ctx
scoreboard players set @s gd_owner -1
scoreboard players set @s gd_sel 0
scoreboard players set @s gd_used 0
function guandan:cards/normalize
