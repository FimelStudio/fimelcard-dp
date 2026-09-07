# #choice 为本次选择，dc_pos 为正在填写的第几位；白队先填，黑队后填。
execute if score @s dc_state matches 1 if score @s dc_pos matches 1 run scoreboard players operation @s dc_w1 = #choice dc_ctx
execute if score @s dc_state matches 1 if score @s dc_pos matches 2 run scoreboard players operation @s dc_w2 = #choice dc_ctx
execute if score @s dc_state matches 1 if score @s dc_pos matches 3 run scoreboard players operation @s dc_w3 = #choice dc_ctx
execute if score @s dc_state matches 3 if score @s dc_pos matches 1 run scoreboard players operation @s dc_b1 = #choice dc_ctx
execute if score @s dc_state matches 3 if score @s dc_pos matches 2 run scoreboard players operation @s dc_b2 = #choice dc_ctx
execute if score @s dc_state matches 3 if score @s dc_pos matches 3 run scoreboard players operation @s dc_b3 = #choice dc_ctx
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 1 run scoreboard players operation @s dc_guess1 = #choice dc_ctx
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 2 run scoreboard players operation @s dc_guess2 = #choice dc_ctx
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 3 run scoreboard players operation @s dc_guess3 = #choice dc_ctx
scoreboard players add @s dc_pos 1
execute if score @s dc_pos matches ..3 as @a[tag=dc.actor] run function decrypto:dialog/digits
execute if score @s dc_state matches 1 if score @s dc_pos matches 4 run function decrypto:round/start_white_prompt
execute if score @s dc_state matches 3 if score @s dc_pos matches 4 run function decrypto:round/start_black_prompt
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 4 as @a[tag=dc.actor] run clear @s minecraft:paper[minecraft:custom_data~{decrypto:{tool:'guess'}}]
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 4 as @a[tag=dc.actor] run clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}]
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 4 run function decrypto:round/resolve_guess
