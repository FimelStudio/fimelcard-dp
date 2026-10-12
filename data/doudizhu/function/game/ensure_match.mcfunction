# 旧版本正在进行的对局按单局比赛接续，不重置现有比赛。
execute unless score @s dd_round matches 1..32 run scoreboard players set @s dd_round 1
execute unless score @s dd_limit matches 1..32 run scoreboard players set @s dd_limit 1
