
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(a),output:{data:"storage fimel_sklibs:arrays temp.equalA"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(b),output:{data:"storage fimel_sklibs:arrays temp.equalB"}}
execute store success score equalResult fcs_arr_tmp run data modify storage fimel_sklibs:arrays temp.equalA set from storage fimel_sklibs:arrays temp.equalB
function fimel_sklibs:skapi_arrays/not {input:{score:"equalResult fcs_arr_tmp"},output:{score:"equalResult fcs_arr_tmp"}}
# tellraw @a [{"score":{"name": "equalResult","objective": "fcs_arr_tmp"}}]
$function fimel_sklibs:skapi_arrays/native/io/io {input:{score:"equalResult fcs_arr_tmp"},output:$(output)}