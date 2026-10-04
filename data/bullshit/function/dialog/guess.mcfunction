scoreboard players set #action_base bw_ctx 300
function bullshit:dialog/prepare_options
data modify storage bullshit:dialog ui.title set value {text:"指认老实人",color:"yellow"}
scoreboard players set @s bw_action 0
scoreboard players enable @s bw_action
function bullshit:dialog/show_guess with storage bullshit:dialog
