function doudizhu:duplicate/bind_other
execute as @e[tag=dd.other_lane,scores={dd_state=1},limit=1] at @s run function doudizhu:deal/complete
