# SK Form 所需的玩家数据写入兼容接口。
# base_path 为数据根路径，path 为玩家记录内路径，value 为待写入值。

$data modify storage fimel_sklibs:player temp.pdata_call set value {base_path:"$(base_path)",path:"$(path)",value:$(value)}
data modify storage fimel_sklibs:player temp.pdata_call.uuid set from entity @s UUID
function fimel_sklibs:skapi_player/pdata/private/modify with storage fimel_sklibs:player temp.pdata_call
