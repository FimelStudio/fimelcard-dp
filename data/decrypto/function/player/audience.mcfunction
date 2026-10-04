scoreboard players operation #ctx dc_ctx = @s dc_id
tag @a[tag=dc.audience] remove dc.audience
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tag @s add dc.audience
