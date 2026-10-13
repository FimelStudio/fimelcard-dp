
data modify storage fimel_sklibs:arrays temp.newarrOutput append from storage fimel_sklibs:arrays temp.newarrFill
scoreboard players operation newarrLength fcs_arr_tmp -= 1 fcs_arr_tmp

execute if score newarrLength fcs_arr_tmp matches 1.. run function fimel_sklibs:skapi_arrays/private/newarray_1

