
function fimel_sklibs:skapi_arrays/equal {a:{data:"storage fimel_sklibs:arrays temp.findI"},b:{data:"storage fimel_sklibs:arrays temp.findFind"},output:{score:"findResult fcs_arr_tmp"}}
execute if score findResult fcs_arr_tmp matches 1 run return run function fimel_sklibs:skapi_arrays/break
