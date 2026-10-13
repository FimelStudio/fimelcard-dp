
# foreach(i(data), target(data), execute(func))

##! 执行foreach头部 {storage fimel_sklibs:arrays temp.foreachTemp}
execute unless data storage fimel_sklibs:arrays temp.foreachTarget[0] run return run function fimel_sklibs:skapi_arrays/private/info {type:2,text:"被遍历的列表为空列表"}
data modify storage fimel_sklibs:arrays temp.whileStack append from storage fimel_sklibs:arrays temp.foreachTarget
data modify storage fimel_sklibs:arrays temp.foreachTempStack append value {i:"",cmd:""}
data modify storage fimel_sklibs:arrays temp.foreachTempStack[-1].i set from storage fimel_sklibs:arrays temp.foreachTemp.i
data modify storage fimel_sklibs:arrays temp.foreachTempStack[-1].cmd set from storage fimel_sklibs:arrays temp.foreachTemp.cmd
function fimel_sklibs:skapi_arrays/private/foreach.run1 with storage fimel_sklibs:arrays temp.foreachTempStack[-1]
data remove storage fimel_sklibs:arrays temp.whileStack[-1]
data remove storage fimel_sklibs:arrays temp.foreachTempStack[-1]



