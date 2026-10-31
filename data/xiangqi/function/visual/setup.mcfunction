# 新局／新预览入口；重载已有对局请使用 refresh。
data modify entity @s data.xiangqi.captured set value []
scoreboard players set @s xq_rcapt 0
scoreboard players set @s xq_bcapt 0
function xiangqi:visual/refresh
