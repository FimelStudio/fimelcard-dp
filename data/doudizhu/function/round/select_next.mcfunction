scoreboard players set #next dd_ctx 9
scoreboard players operation #turn dd_ctx = @s dd_turn
# 从在场玩家中按座号顺序找下一人。
execute as @e[tag=dd.actors] if score @s dd_seat > #turn dd_ctx run scoreboard players operation #next dd_ctx < @s dd_seat
execute if score #next dd_ctx matches 9 run function doudizhu:round/wrap
scoreboard players operation @s dd_turn = #next dd_ctx
