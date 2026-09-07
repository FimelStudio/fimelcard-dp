scoreboard players operation #ctx cp_ctx = @s cp_id
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run clear @s minecraft:red_dye[minecraft:custom_data~{critical_point:{}}]
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run clear @s minecraft:lime_dye[minecraft:custom_data~{critical_point:{}}]
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run clear @s minecraft:purple_dye[minecraft:custom_data~{critical_point:{}}]
