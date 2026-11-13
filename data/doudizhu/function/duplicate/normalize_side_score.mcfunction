# 重载前已打完、尚未合并的分桌使用了两倍底分。仅转换旧单桌成绩。
execute if data entity @s data.doudizhu.side_unit_scoring run return 0
execute if score @s dd_side_score matches 0 run return 0
scoreboard players set #legacy_side_multiplier dd_ctx 2
scoreboard players operation @s dd_side_score /= #legacy_side_multiplier dd_ctx
data modify entity @s data.doudizhu.side_unit_scoring set value 1b
