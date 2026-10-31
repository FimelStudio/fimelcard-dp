# 已完成排名的颜色不能因六点再次行动。
scoreboard players set #rank ac_ctx 0
execute as @e[tag=ac.sides] if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn run scoreboard players operation #rank ac_ctx = @s ac_rank
execute unless score #rank ac_ctx matches 0 run return run function aeroplane_chess:game/next_turn
scoreboard players set @s ac_state 1
scoreboard players set @s ac_wait 10
scoreboard players add @s ac_epoch 1
function aeroplane_chess:ui/refresh
