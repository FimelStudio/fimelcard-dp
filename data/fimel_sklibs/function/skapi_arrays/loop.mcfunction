
scoreboard players operation newarrLength fcs_arr_tmp = loopI fcs_arr_tmp
data modify storage fimel_sklibs:arrays temp.newarrFill set value 0
function fimel_sklibs:skapi_arrays/newarray

data modify storage fimel_sklibs:arrays temp.foreachTarget set from storage fimel_sklibs:arrays temp.newarrOutput
data modify storage fimel_sklibs:arrays temp.foreachTemp.cmd set from storage fimel_sklibs:arrays temp.loopcmd
data modify storage fimel_sklibs:arrays temp.foreachTemp.i set value "storage fimel_sklibs:arrays temp.foreachI.value"
function fimel_sklibs:skapi_arrays/foreach