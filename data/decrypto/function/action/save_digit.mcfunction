# #choice 为本次选择，dc_pos 为正在填写的第几位；白队先填，黑队后填。
execute unless score @s dc_pos matches 1..3 run return 0
execute unless score #choice dc_ctx matches 1..4 run return 0
execute unless score @s dc_state matches 1 unless score @s dc_state matches 3 unless score @s dc_state matches 5..8 run return 0
# 同时拒绝旧按钮或手动 trigger 提交的重复数字，不推进位置或播放成功音。
function decrypto:dialog/read_used
scoreboard players set #digit_duplicate dc_ctx 0
execute if score #choice dc_ctx = #digit_used1 dc_ctx run scoreboard players set #digit_duplicate dc_ctx 1
execute if score #choice dc_ctx = #digit_used2 dc_ctx run scoreboard players set #digit_duplicate dc_ctx 1
execute if score #digit_duplicate dc_ctx matches 1 as @a[tag=dc.actor] run function decrypto:dialog/digits
execute if score #digit_duplicate dc_ctx matches 1 run return 0
execute if score @s dc_state matches 1 if score @s dc_pos matches 1 run scoreboard players operation @s dc_w1 = #choice dc_ctx
execute if score @s dc_state matches 1 if score @s dc_pos matches 2 run scoreboard players operation @s dc_w2 = #choice dc_ctx
execute if score @s dc_state matches 1 if score @s dc_pos matches 3 run scoreboard players operation @s dc_w3 = #choice dc_ctx
execute if score @s dc_state matches 3 if score @s dc_pos matches 1 run scoreboard players operation @s dc_b1 = #choice dc_ctx
execute if score @s dc_state matches 3 if score @s dc_pos matches 2 run scoreboard players operation @s dc_b2 = #choice dc_ctx
execute if score @s dc_state matches 3 if score @s dc_pos matches 3 run scoreboard players operation @s dc_b3 = #choice dc_ctx
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 1 run scoreboard players operation @s dc_guess1 = #choice dc_ctx
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 2 run scoreboard players operation @s dc_guess2 = #choice dc_ctx
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 3 run scoreboard players operation @s dc_guess3 = #choice dc_ctx
# 确认音仅发给本桌本次输入者，在数字写入后、阶段切换前播放。
scoreboard players operation #ctx dc_ctx = @s dc_id
execute as @a[tag=dc.actor] if score @s dc_id = #ctx dc_ctx at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.4
scoreboard players add @s dc_pos 1
execute if score @s dc_pos matches ..3 as @a[tag=dc.actor] run function decrypto:dialog/digits
execute if score @s dc_state matches 1 if score @s dc_pos matches 4 run function decrypto:round/start_white_prompt
execute if score @s dc_state matches 3 if score @s dc_pos matches 4 run function decrypto:round/start_black_prompt
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 4 as @a[tag=dc.actor] run clear @s minecraft:paper[minecraft:custom_data~{decrypto:{tool:'guess'}}]
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 4 as @a[tag=dc.actor] run clear @s minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}]
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 4 run function decrypto:round/resolve_guess
