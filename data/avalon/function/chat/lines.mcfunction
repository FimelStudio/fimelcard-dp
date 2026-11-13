execute unless data storage avalon:chat lines[0] run return 0
data modify storage avalon:chat line set from storage avalon:chat lines[0]
function avalon:chat/line with storage avalon:chat line
data remove storage avalon:chat lines[0]
function avalon:chat/lines
