# 首次随机选轮空座位，重发沿用该局的叫分顺序。
scoreboard players set @s dd_out 0
function doudizhu:player/audience
execute unless score @s dd_bidbye matches 1..8 run scoreboard players operation @s dd_bidbye = @e[tag=dd.actors,sort=random,limit=1] dd_seat
scoreboard players set @e[tag=dd.actors] dd_points 0
scoreboard players operation @s dd_out = @s dd_bidbye
