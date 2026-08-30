function bullshit:dialog/prepare_options
data modify storage bullshit:dialog name1 merge value {click_event:{action:'run_command',command:'trigger bw_action set 301'}}
data modify storage bullshit:dialog name2 merge value {click_event:{action:'run_command',command:'trigger bw_action set 302'}}
data modify storage bullshit:dialog name3 merge value {click_event:{action:'run_command',command:'trigger bw_action set 303'}}
data modify storage bullshit:dialog name4 merge value {click_event:{action:'run_command',command:'trigger bw_action set 304'}}
function bullshit:dialog/show_guess with storage bullshit:dialog
scoreboard players enable @s bw_action
