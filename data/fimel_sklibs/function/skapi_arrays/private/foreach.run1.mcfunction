
data modify storage fimel_sklibs:arrays temp.foreachI.value set from storage fimel_sklibs:arrays temp.whileStack[-1][0]
##! 执行foreach体{storage fimel_sklibs:arrays temp.whileStack[-1]} 当前I {storage fimel_sklibs:arrays temp.foreachI.value}
data remove storage fimel_sklibs:arrays temp.whileStack[-1][0]
$data modify $(i) set from storage fimel_sklibs:arrays temp.foreachI.value
$$(cmd)
execute if data storage fimel_sklibs:arrays temp.whileStack[-1][0] run function fimel_sklibs:skapi_arrays/private/foreach.run1 with storage fimel_sklibs:arrays temp.foreachTempStack[-1]
