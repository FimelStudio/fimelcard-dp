execute if score @s gd_music matches 1.. run stopsound @s record card:doudizhu.normal
execute if score @s gd_music matches 1.. run stopsound @s record card:doudizhu.exciting
execute if score @s gd_music matches 1.. run stopsound @s record card:doudizhu.win
execute if score @s gd_music matches 1.. run stopsound @s record card:doudizhu.lose
scoreboard players set @s gd_music 0
scoreboard players set @s gd_mtime 0
