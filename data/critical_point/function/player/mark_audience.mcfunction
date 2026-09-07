tag @a[tag=cp.audience] remove cp.audience
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run tag @s add cp.audience
