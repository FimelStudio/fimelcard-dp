scoreboard players operation #gift gd_ctx = @s gd_giftid
execute as @e[tag=gd.cards] if score @s gd_id = #gift gd_ctx run scoreboard players operation #value gd_ctx = @s gd_strength
scoreboard players operation @s gd_strength = #value gd_ctx
