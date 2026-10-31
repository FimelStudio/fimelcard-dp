# 只清理本桌搜索；提交走法后调用时不改规则引擎的临时分数。
scoreboard players set @s ch_aistate 0
scoreboard players set @s ch_aiwait 0
scoreboard players set @s ch_aiepoch -1
data remove entity @s data.chess.ai
