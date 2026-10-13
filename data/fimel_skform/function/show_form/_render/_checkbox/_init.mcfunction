
execute store result score newarrLength fcs_arr_tmp run data get storage fimel_skform:runtime temp.i.values
data modify storage fimel_sklibs:arrays temp.newarrFill set value 0
function fimel_sklibs:skapi_arrays/newarray

$data modify storage fimel_skform:runtime temp.storage.$(key) set from storage fimel_sklibs:arrays temp.newarrOutput
data modify storage fimel_skform:runtime temp.i.newarray set from storage fimel_sklibs:arrays temp.newarrOutput
function fimel_skform:show_form/_render/_checkbox/_init_1 with storage fimel_skform:runtime temp.i

