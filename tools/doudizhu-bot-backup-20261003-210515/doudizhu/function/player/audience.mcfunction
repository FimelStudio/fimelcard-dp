scoreboard players operation #ctx dd_ctx = @s dd_id
tag @a[tag=dd.audience] remove dd.audience
execute as @a[tag=dd.player] if score @s dd_id = #ctx dd_ctx run tag @s add dd.audience
