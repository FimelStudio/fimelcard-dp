data modify storage xiangqi:runtime sides.red set value {selector:"@a[tag=xq.audience,scores={xq_side=1}]"}
data modify storage xiangqi:runtime sides.black set value {selector:"@a[tag=xq.audience,scores={xq_side=-1}]"}
execute if score @s xq_bot matches 1 if score @s xq_level matches 1 run data modify storage xiangqi:runtime sides.red set value {text:"简单人机",color:"aqua"}
execute if score @s xq_bot matches -1 if score @s xq_level matches 1 run data modify storage xiangqi:runtime sides.black set value {text:"简单人机",color:"aqua"}
execute if score @s xq_bot matches 1 if score @s xq_level matches 2 run data modify storage xiangqi:runtime sides.red set value {text:"普通人机",color:"aqua"}
execute if score @s xq_bot matches -1 if score @s xq_level matches 2 run data modify storage xiangqi:runtime sides.black set value {text:"普通人机",color:"aqua"}
execute if score @s xq_bot matches 1 if score @s xq_level matches 3 run data modify storage xiangqi:runtime sides.red set value {text:"困难人机",color:"aqua"}
execute if score @s xq_bot matches -1 if score @s xq_level matches 3 run data modify storage xiangqi:runtime sides.black set value {text:"困难人机",color:"aqua"}
function xiangqi:game/announce_sides_text with storage xiangqi:runtime sides
