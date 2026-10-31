scoreboard players set @s xq_reason 4
scoreboard players set @s xq_result 3
execute if data entity @s data.xiangqi.history[{meta:1,loser:1}] run scoreboard players set @s xq_result 2
execute if data entity @s data.xiangqi.history[{meta:1,loser:-1}] run scoreboard players set @s xq_result 1
