execute if score @s bw_used matches 1 run tellraw @s {text:"本轮已经使用过“净他喵扯淡！”。",color:"red"}
execute if score @s bw_used matches 1 run return 0
scoreboard players set #action_base bw_ctx 400
function bullshit:dialog/prepare_options
data modify storage bullshit:dialog ui.title set value {text:"净他喵扯淡！",color:"red"}
scoreboard players set @s bw_action 0
scoreboard players enable @s bw_action
function bullshit:dialog/show_call with storage bullshit:dialog
