# 单次同步只读探测，不提交走法，也不改写真实棋格。
function xiangqi:hints/clear
execute unless score @s xq_hints matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute unless score @s xq_sel matches 0..89 run return 0
execute if score @s xq_bot = @s xq_turn run return 0
function xiangqi:hints/query
