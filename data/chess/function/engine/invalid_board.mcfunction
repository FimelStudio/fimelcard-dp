# 数据受损时隔离本桌；禁止沿用上一桌缓存继续下棋。
scoreboard players set @s ch_result 3
scoreboard players set @s ch_reason 11
scoreboard players set @s ch_check 0
return 3
