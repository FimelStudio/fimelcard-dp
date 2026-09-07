clear @s minecraft:paper[minecraft:custom_data~{decrypto:{tool:'guess'}}]
clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}]
give @s minecraft:purple_dye[minecraft:item_name='提交密码（按Q选择）',minecraft:custom_data={decrypto:{tool:'guess'}},minecraft:enchantment_glint_override=true,minecraft:max_stack_size=1]
scoreboard players set @s dc_drop_guess 0
