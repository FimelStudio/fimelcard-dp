function doudizhu:predict/clear
scoreboard players enable @s dd_action
tellraw @s {text:"请预测你所在队伍目前的分差。选择对应染料按 Q 丢出，八人交齐后会私下告知结果。",color:"yellow"}
scoreboard players set #used_main dd_ctx 0
execute store result score #used_main dd_ctx run data get entity @s Inventory
execute if score #used_main dd_ctx matches 29.. run return run function doudizhu:predict/dialog
function doudizhu:predict/give with storage doudizhu:input prediction
