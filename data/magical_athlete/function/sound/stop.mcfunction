function magical_athlete:sound/context
execute as @a[tag=ma.sound_audience] run function magical_athlete:sound/stop_player
scoreboard players set @s ma_music_tick 0
