# Q 归位、开局、重载和界面推进都复用同一资格判定，不清掉常驻菜单。
execute unless entity @s[tag=ac.player,tag=ct.player] run return 0
execute unless score @s ac_table = @s ct_id run return 0
function aeroplane_chess:input/sync_turn_tool
execute store result storage aeroplane_chess:input table int 1 run scoreboard players get @s ac_table
function aeroplane_chess:input/tools with storage aeroplane_chess:input
