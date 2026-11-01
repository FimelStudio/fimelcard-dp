execute if score @s gd_state matches 5 run return 0
scoreboard players set @s gd_matchwin 2
execute if score @s gd_team0 > @s gd_team1 run scoreboard players set @s gd_matchwin 0
execute if score @s gd_team1 > @s gd_team0 run scoreboard players set @s gd_matchwin 1
function guandan:round/match_over
