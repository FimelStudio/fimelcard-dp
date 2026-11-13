execute as @a[tag=ma.sound_audience] at @s run playsound magical_athlete:bgm record @s ~ ~ ~ 0.16 1
scoreboard players set @s ma_music_tick 640
data modify entity @s data.ma_sound.track set value 0
