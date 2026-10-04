function doudizhu:player/audience
scoreboard players set #next dd_ctx 9
scoreboard players operation #turn dd_ctx = @s dd_turn
# 使用最小值运算累积，不能依赖execute分支预先求值的动态上界。
execute as @e[tag=dd.actors] if score @s dd_seat > #turn dd_ctx run scoreboard players operation #next dd_ctx < @s dd_seat
execute if score #next dd_ctx matches 9 run function doudizhu:round/wrap
scoreboard players operation @s dd_turn = #next dd_ctx
function doudizhu:round/announce
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
