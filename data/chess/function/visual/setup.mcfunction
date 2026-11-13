# 新局／新预览入口；重载已有对局请使用 refresh。
data modify entity @s data.chess.captured set value []
scoreboard players set @s ch_wcapt 0
scoreboard players set @s ch_bcapt 0
function chess:visual/refresh
