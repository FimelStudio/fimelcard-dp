# SK Form 所需的玩家数据读取兼容接口。
# output 为完整的数据目标路径；目标在读取前会被清除，避免沿用上一位玩家的数据。

$data modify storage fimel_sklibs:player temp.pdata_call set value {base_path:"$(base_path)",path:"$(path)",output:"$(output)"}
data modify storage fimel_sklibs:player temp.pdata_call.uuid set from entity @s UUID
function fimel_sklibs:skapi_player/pdata/private/get with storage fimel_sklibs:player temp.pdata_call
