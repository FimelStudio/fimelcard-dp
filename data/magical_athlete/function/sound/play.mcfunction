execute if score @s ct_paused matches 1 run return 0
execute unless score @s ma_music matches 1 run return 0
function magical_athlete:sound/context
execute as @a[tag=ma.sound_audience] at @s run playsound magical_athlete:bgm record @s ~ ~ ~ 0.16 1
scoreboard players set @s ma_music_tick 640
