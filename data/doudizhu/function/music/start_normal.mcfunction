function doudizhu:music/stop
scoreboard players set @s dd_music 1
scoreboard players set @s dd_mtime 580
execute at @s run playsound card:doudizhu.normal record @s ~ ~ ~ 1 1 1
