function guandan:music/stop
scoreboard players set @s gd_music 4
scoreboard players set @s gd_mtime 60
execute at @s run playsound card:doudizhu.lose record @s ~ ~ ~ 1 1 1
