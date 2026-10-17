function doudizhu:music/stop
scoreboard players set @s dd_music 2
scoreboard players set @s dd_mtime 623
execute at @s run playsound card:doudizhu.exciting record @s ~ ~ ~ 1 1 1
