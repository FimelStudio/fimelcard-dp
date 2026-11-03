execute if score @s ct_paused matches 1 run return 0
scoreboard players set @s ma_music_tick 0
execute if score @s ma_music matches 1 run function magical_athlete:sound/play
