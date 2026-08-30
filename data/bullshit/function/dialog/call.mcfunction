execute if score @s bw_used matches 1 run tellraw @s [{text:'[瞎掰王] ',color:'yellow'},{text:'本轮已经使用过“净他喵扯淡！”。',color:'red'}]
execute if score @s bw_used matches 1 run return 0
function bullshit:dialog/prepare_options
data modify storage bullshit:dialog name1 merge value {click_event:{action:'run_command',command:'trigger bw_action set 401'}}
data modify storage bullshit:dialog name2 merge value {click_event:{action:'run_command',command:'trigger bw_action set 402'}}
data modify storage bullshit:dialog name3 merge value {click_event:{action:'run_command',command:'trigger bw_action set 403'}}
data modify storage bullshit:dialog name4 merge value {click_event:{action:'run_command',command:'trigger bw_action set 404'}}
function bullshit:dialog/show_call with storage bullshit:dialog
scoreboard players enable @s bw_action
