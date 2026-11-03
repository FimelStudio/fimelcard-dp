execute if score @s ct_paused matches 1 run return 0
function magical_athlete:sound/context
execute as @a[tag=ma.sound_audience] at @s run playsound magical_athlete:roll master @s ~ ~ ~ 0.5 1
