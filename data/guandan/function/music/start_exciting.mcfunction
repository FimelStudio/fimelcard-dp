function guandan:music/stop
scoreboard players set @s gd_music 2
scoreboard players set @s gd_mtime 623
execute at @s run playsound card:doudizhu.exciting record @s ~ ~ ~ 1 1 1
