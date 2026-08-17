scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.audience] remove lh.audience
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.audience
$tellraw @a[tag=lh.audience] $(chat)
tag @a[tag=lh.audience] remove lh.audience
