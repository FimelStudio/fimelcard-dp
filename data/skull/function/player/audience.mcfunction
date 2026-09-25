tag @a[tag=sk.audience] remove sk.audience
scoreboard players operation #ctx sk_ctx = @s sk_id
execute as @a[tag=sk.player] if score @s sk_id = #ctx sk_ctx run tag @s add sk.audience
