scoreboard players add @s dd_round 1
scoreboard players operation @e[tag=dd.other_lane,limit=1] dd_round = @s dd_round
scoreboard players set @s dd_pair_scored 0
execute as @e[tag=dd.other_lane,limit=1] run function doudizhu:team/advance_bye
function doudizhu:team/advance_bye
function doudizhu:duplicate/deal_pair
