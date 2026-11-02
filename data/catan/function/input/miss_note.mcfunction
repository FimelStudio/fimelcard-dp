# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage catan:ui miss set value "请将准星对准棋盘范围内的目标。"
execute if score @s ca_mode matches 1 run data modify storage catan:ui miss set value "请瞄准六边形地块内部，再按 Q 选择强盗目的地。"
execute if score @s ca_mode matches 2 run data modify storage catan:ui miss set value "请瞄准地块边缘相交的交点，村庄不能放在格子中央。"
execute if score @s ca_mode matches 3 run data modify storage catan:ui miss set value "请瞄准两个交点之间的边中段，道路不能放在交点或格子中央。"
execute if score @s ca_mode matches 4 run data modify storage catan:ui miss set value "请瞄准己方村庄所在交点，再确认升级城市。"
function catan:input/miss_message with storage catan:ui
