# 第二轮一旦有人抢，立即确定地主；倍数已由提交函数翻倍。
execute if score #action dd_ctx matches 205 run return run function doudizhu:bid/finish
scoreboard players remove @s dd_bidleft 1
execute if score @s dd_bidleft matches ..0 run return run function doudizhu:bid/finish
function doudizhu:player/audience
scoreboard players operation #turn dd_ctx = @s dd_turn
scoreboard players set #next dd_ctx 9
execute as @e[tag=dd.actors,scores={dd_eligible=1}] if score @s dd_seat > #turn dd_ctx run scoreboard players operation #next dd_ctx < @s dd_seat
execute if score #next dd_ctx matches 9 run function doudizhu:bid/rob_wrap
scoreboard players operation @s dd_turn = #next dd_ctx
execute if score @s dd_bidleft matches 1 run return run function doudizhu:bid/rob_auto_finish
function doudizhu:round/announce
