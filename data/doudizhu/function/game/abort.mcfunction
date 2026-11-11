execute if score @s dd_lane matches 1 run function doudizhu:duplicate/abort_other
function doudizhu:game/clear
execute at @s run function cardtable:game/return_lobby
tag @e[tag=dd.current] remove dd.current
tag @e[tag=dd.hand] remove dd.hand
