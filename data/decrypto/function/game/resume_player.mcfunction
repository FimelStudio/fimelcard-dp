execute unless items entity @s hotbar.* minecraft:book[minecraft:custom_data~{decrypto:{tool:'notes'}}] unless items entity @s inventory.* minecraft:book[minecraft:custom_data~{decrypto:{tool:'notes'}}] unless items entity @s weapon.offhand minecraft:book[minecraft:custom_data~{decrypto:{tool:'notes'}}] run function decrypto:input/give_notes
scoreboard players set #resume_authorized dc_ctx 0
execute if score #resume_state dc_ctx matches 1 if score #resume_mode dc_ctx matches 4 if score @s dc_seat matches 1 run scoreboard players set #resume_authorized dc_ctx 1
execute if score #resume_state dc_ctx matches 1 if score #resume_mode dc_ctx matches 3 if score @s dc_encoder matches 1 run scoreboard players set #resume_authorized dc_ctx 1
execute if score #resume_state dc_ctx matches 3 if score @s dc_seat matches 3 run scoreboard players set #resume_authorized dc_ctx 1
execute if score #resume_state dc_ctx matches 5 if score #resume_mode dc_ctx matches 4 if entity @s[scores={dc_team=2,dc_encoder=0}] run scoreboard players set #resume_authorized dc_ctx 1
execute if score #resume_state dc_ctx matches 5 if score #resume_mode dc_ctx matches 3 if score @s dc_team matches 2 run scoreboard players set #resume_authorized dc_ctx 1
execute if score #resume_state dc_ctx matches 6..7 if entity @s[scores={dc_team=1,dc_encoder=0}] run scoreboard players set #resume_authorized dc_ctx 1
execute if score #resume_state dc_ctx matches 8 if entity @s[scores={dc_team=2,dc_encoder=0}] run scoreboard players set #resume_authorized dc_ctx 1
execute unless score #resume_authorized dc_ctx matches 1 run return 0
execute if score #resume_state dc_ctx matches 5..8 unless items entity @s hotbar.* minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}] unless items entity @s inventory.* minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}] unless items entity @s weapon.offhand minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}] run function decrypto:input/give_guess
execute if score @s dc_action matches 0 run function decrypto:dialog/digits
