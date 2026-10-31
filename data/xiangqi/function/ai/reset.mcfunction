# 只清理本桌搜索；提交走法后调用时不改规则引擎的临时分数。
scoreboard players set @s xq_aistate 0
scoreboard players set @s xq_aiwait 0
scoreboard players set @s xq_aiepoch -1
data remove entity @s data.xiangqi.ai
