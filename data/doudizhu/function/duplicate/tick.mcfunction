function doudizhu:duplicate/bind_other
execute unless entity @e[tag=dd.other_lane,scores={dd_state=4},limit=1] run return 0
execute unless score @s dd_pair_scored matches 1 run return run function doudizhu:duplicate/score_pair
execute if score @s dd_pred_phase matches 1 run return run function doudizhu:predict/wait
execute if score @s dd_hide_score matches 1 if score @s dd_pred_round matches 1.. if score @s dd_pred_phase matches 0 if score @s dd_round >= @s dd_pred_round run return run function doudizhu:predict/open
scoreboard players remove @s dd_timer 1
execute unless score @s dd_timer matches ..0 run return 0
execute if score @s dd_round < @s dd_limit run return run function doudizhu:duplicate/next
execute if score @s dd_team_one = @s dd_team_two run return run function doudizhu:duplicate/extra
function doudizhu:duplicate/finish_match
