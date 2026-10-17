# 人机策略模式；玩家窗口只探测合法性，不能继承让牌策略。
scoreboard players set #bot_probe dd_ctx 0
scoreboard players set @e[tag=dd.hand] dd_selected 0
function doudizhu:bot/search
execute if score #bot_found dd_ctx matches 1 run return run function doudizhu:action/play
scoreboard players set @e[tag=dd.hand] dd_selected 0
function doudizhu:action/pass
