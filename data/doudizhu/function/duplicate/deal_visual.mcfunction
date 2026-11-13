# 共用一个牌盒。两桌按同一动画刻发牌背，各自从本分桌的座位里选接收者。
function doudizhu:duplicate/bind_other
function doudizhu:deal/visual
scoreboard players operation #first_visual dd_ctx = #real_target dd_ctx
scoreboard players operation @e[tag=dd.other_lane,scores={dd_state=1},limit=1] dd_timer = @s dd_timer
execute as @e[tag=dd.other_lane,scores={dd_state=1},limit=1] at @s run function doudizhu:deal/visual
execute if score #real_target dd_ctx matches 1 run scoreboard players set #first_visual dd_ctx 1
execute if score #first_visual dd_ctx matches 1 run function cardtable:animation/deal/sound
