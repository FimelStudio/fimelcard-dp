function guandan:music/stop
scoreboard players set @s gd_music 3
scoreboard players set @s gd_mtime 76
execute at @s run playsound card:doudizhu.win record @s ~ ~ ~ 1 1 1
