scoreboard players operation #match dd_ctx = @s ct_id
tag @a[tag=dd.audience] remove dd.audience
execute as @a[tag=dd.player,tag=ct.player] if score @s ct_id = #match dd_ctx run tag @s add dd.audience
