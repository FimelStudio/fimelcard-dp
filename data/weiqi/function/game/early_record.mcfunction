execute unless score @s go_state matches 1..3 run return 0
scoreboard players set @s go_result 0
data modify entity @s data.weiqi.finalresult set value 0
data modify entity @s data.weiqi.result set value "本场提前结束"
