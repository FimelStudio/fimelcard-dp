# 黑白信号染料用后不补发；已出牌、已准备、已投票状态保持。
scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players operation #resume_state cp_ctx = @s cp_state
scoreboard players operation #resume_vote_used cp_ctx = @s cp_vote_used
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx at @s run function critical_point:game/resume_player
