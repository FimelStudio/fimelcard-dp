scoreboard players remove @s dd_timer 1
execute unless score @s dd_timer matches ..0 run return 0
execute if score @s dd_round < @s dd_limit run return run function doudizhu:game/next_round
function doudizhu:game/finish_match
