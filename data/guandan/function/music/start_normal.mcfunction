function guandan:music/stop
scoreboard players set @s gd_music 1
scoreboard players set @s gd_mtime 580
execute at @s run playsound card:doudizhu.normal record @s ~ ~ ~ 1 1 1
