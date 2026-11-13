function magical_athlete:sound/stop
execute unless score @s ct_paused matches 1 run function magical_athlete:sound/start
