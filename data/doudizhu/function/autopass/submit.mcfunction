# 到期再次校验当前回合与合法性，避免旧计时器误过牌。
function doudizhu:action/context
execute unless entity @e[tag=dd.current,scores={dd_state=3},limit=1] run return run function doudizhu:action/clear_context
execute unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run return run function doudizhu:action/clear_context
function doudizhu:dialog/can_play
execute if score #can_play dd_ctx matches 1 run return run function doudizhu:action/clear_context
dialog clear @s
scoreboard players set @s dd_action 0
function doudizhu:action/pass
function doudizhu:action/clear_context
