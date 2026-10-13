

execute store result score s2aI fcs_arr_tmp run data get storage fimel_sklibs:arrays temp.s2aI 1

scoreboard players operation s2aIadd1 fcs_arr_tmp = s2aI fcs_arr_tmp
scoreboard players operation s2aIadd1 fcs_arr_tmp += 1 fcs_arr_tmp
# data modify storage fimel_sklibs:arrays temp.s2aTemp set value {start:0,end:0}
execute store result storage fimel_sklibs:arrays temp.s2aTemp.start int 1.0 run scoreboard players get s2aI fcs_arr_tmp
execute store result storage fimel_sklibs:arrays temp.s2aTemp.end int 1.0 run scoreboard players get s2aIadd1 fcs_arr_tmp
function fimel_sklibs:skapi_arrays/private/string2array.run2 with storage fimel_sklibs:arrays temp.s2aTemp

