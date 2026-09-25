scoreboard players operation #ctx wq_ctx = @s wq_id
tag @a[tag=wq.audience] remove wq.audience
execute as @a[tag=wq.player] if score @s wq_id = #ctx wq_ctx run tag @s add wq.audience
