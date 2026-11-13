execute unless data storage avalon:chat actions[0] run return 0
data modify storage avalon:chat button set from storage avalon:chat actions[0].label
data modify storage avalon:chat button.color set value "yellow"
data modify storage avalon:chat button.underlined set value 1b
data modify storage avalon:chat button.click_event set value {action:"run_command",command:""}
data modify storage avalon:chat button.click_event.command set from storage avalon:chat actions[0].action.command
function avalon:chat/button with storage avalon:chat
data remove storage avalon:chat actions[0]
function avalon:chat/actions
