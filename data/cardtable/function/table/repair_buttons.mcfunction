# 控制器执行；只重建本桌公共按钮，保留游戏状态、设置和结束票。
execute if score @s ct_state matches 0 run function cardtable:menu/render
function cardtable:rules/render
execute if score @s ct_state matches 1 run function cardtable:vote/render
data modify entity @s data.cardtable.button_regions_version set value 1
