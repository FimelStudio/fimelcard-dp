# hash 仅用于筛选；候选仍比较完整19行数组，不因哈希碰撞拒绝落子。
data modify storage weiqi:runtime candidates set value []
$data modify storage weiqi:runtime candidates append from entity @s data.weiqi.positions[{hash:$(hash)}]
execute if data storage weiqi:runtime candidates[0] run function weiqi:engine/superko/compare
