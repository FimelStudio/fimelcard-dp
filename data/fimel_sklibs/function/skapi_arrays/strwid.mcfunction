
data modify storage fimel_sklibs:arrays temp.s2aInput set from storage fimel_sklibs:arrays temp.strwid
function fimel_sklibs:skapi_arrays/string2list

scoreboard players set strwid0 fcs_arr_tmp 0
scoreboard players set strwid1 fcs_arr_tmp 0

data modify storage fimel_sklibs:arrays temp.foreachTarget set from storage fimel_sklibs:arrays temp.s2aOutput
data modify storage fimel_sklibs:arrays temp.foreachTemp.cmd set value "function fimel_sklibs:skapi_arrays/private/strwid_0 with storage fimel_sklibs:arrays temp.foreachI"
data modify storage fimel_sklibs:arrays temp.foreachTemp.i set value "storage fimel_sklibs:arrays temp.foreachI.value"
function fimel_sklibs:skapi_arrays/foreach


