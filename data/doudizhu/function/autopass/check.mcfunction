function doudizhu:action/context
execute unless entity @e[tag=dd.current,scores={dd_state=3},limit=1] run return run function doudizhu:action/clear_context
function doudizhu:dialog/can_play
execute if score #can_play dd_ctx matches 0 run scoreboard players set @e[tag=dd.current,limit=1] dd_autopass 100
execute if score #can_play dd_ctx matches 0 run tellraw @s {text:"[斗地主] 没有能压过上一手的牌，5秒后自动不出；也可提前选择不出。",color:"yellow"}
function doudizhu:action/clear_context
