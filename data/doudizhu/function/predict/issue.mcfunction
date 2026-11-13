function doudizhu:predict/clear
scoreboard players enable @s dd_action
execute if items entity @s hotbar.* * run return run function doudizhu:predict/dialog
tellraw @s {text:"请预测你所在队伍目前的分差。选择对应染料按 Q 丢出，所有真人交齐后会私下告知结果。",color:"yellow"}
function doudizhu:predict/give with storage doudizhu:input prediction
