


data modify storage fimel_sklibs:arrays temp.newarrOutput set value []
execute if score newarrLength fcs_arr_tmp matches 1.. run function fimel_sklibs:skapi_arrays/private/newarray_1


