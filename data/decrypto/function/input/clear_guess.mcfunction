scoreboard players operation #ctx dc_ctx = @s dc_id
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run clear @s minecraft:paper[minecraft:custom_data~{decrypto:{tool:'guess'}}]
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}]
