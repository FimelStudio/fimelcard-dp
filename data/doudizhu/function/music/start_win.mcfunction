function doudizhu:music/stop
scoreboard players set @s dd_music 3
scoreboard players set @s dd_mtime 76
execute at @s run playsound card:doudizhu.win record @s ~ ~ ~ 1 1 1
