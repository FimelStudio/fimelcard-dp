
data modify storage fimel_sklibs:arrays temp.s2aTemp set value {start:0,end:0}


execute store result score s2alen fcs_arr_tmp run data get storage fimel_sklibs:arrays temp.s2aInput
execute store result storage fimel_sklibs:arrays temp.s2aStringLength int 1 run scoreboard players get s2alen fcs_arr_tmp

scoreboard players set rangeStart fcs_arr_tmp 0
execute store result score rangeStop fcs_arr_tmp run data get storage fimel_sklibs:arrays temp.s2aStringLength 1
scoreboard players set rangeStep fcs_arr_tmp 1
function fimel_sklibs:skapi_arrays/range
data modify storage fimel_sklibs:arrays temp.s2aStringRange set from storage fimel_sklibs:arrays temp.rangeOutput

data modify storage fimel_sklibs:arrays temp.s2aOutput set value []

data modify storage fimel_sklibs:arrays temp.foreachTarget set from storage fimel_sklibs:arrays temp.s2aStringRange
data modify storage fimel_sklibs:arrays temp.foreachTemp.cmd set value "function fimel_sklibs:skapi_arrays/private/string2array.run1"
data modify storage fimel_sklibs:arrays temp.foreachTemp.i set value "storage fimel_sklibs:arrays temp.s2aI"
function fimel_sklibs:skapi_arrays/foreach
