# 从当前阶段已提交的前两位读取，不读取真实密码作为猜测限制。
scoreboard players operation #digit_pos dc_ctx = @s dc_pos
scoreboard players set #digit_used1 dc_ctx 0
scoreboard players set #digit_used2 dc_ctx 0
execute if score @s dc_state matches 1 if score @s dc_pos matches 2..3 run scoreboard players operation #digit_used1 dc_ctx = @s dc_w1
execute if score @s dc_state matches 1 if score @s dc_pos matches 3..3 run scoreboard players operation #digit_used2 dc_ctx = @s dc_w2
execute if score @s dc_state matches 3 if score @s dc_pos matches 2..3 run scoreboard players operation #digit_used1 dc_ctx = @s dc_b1
execute if score @s dc_state matches 3 if score @s dc_pos matches 3..3 run scoreboard players operation #digit_used2 dc_ctx = @s dc_b2
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 2..3 run scoreboard players operation #digit_used1 dc_ctx = @s dc_guess1
execute if score @s dc_state matches 5..8 if score @s dc_pos matches 3..3 run scoreboard players operation #digit_used2 dc_ctx = @s dc_guess2
