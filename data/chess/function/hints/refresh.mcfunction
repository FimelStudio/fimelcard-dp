# 单次同步只读探测，不提交走法，也不改写真实棋格。
function chess:hints/clear
execute unless score @s ch_hints matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute unless score @s ch_sel matches 0..63 run return 0
execute if score @s ch_bot = @s ch_turn run return 0
function chess:hints/query
