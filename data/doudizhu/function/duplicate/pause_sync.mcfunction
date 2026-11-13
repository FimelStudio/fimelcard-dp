function doudizhu:duplicate/bind_other
scoreboard players operation @e[tag=dd.other_lane,limit=1] ct_paused = @s ct_paused
