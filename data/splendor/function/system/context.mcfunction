scoreboard players operation #table sp_ctx = @s ct_id
tag @e[tag=sp.current] remove sp.current
tag @a[tag=sp.audience] remove sp.audience
tag @s add sp.current
execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #table sp_ctx if score @s ct_id = #table sp_ctx run tag @s add sp.audience
