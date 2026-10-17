function doudizhu:music/stop
scoreboard players set @s dd_music 4
scoreboard players set @s dd_mtime 60
execute at @s run playsound card:doudizhu.lose record @s ~ ~ ~ 1 1 1
