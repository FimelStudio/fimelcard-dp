
function fimel_sklibs:skapi_arrays/native/io/io.datatype {format:"\"s\"",input:"storage fimel_sklibs:arrays temp.ioTemp.input",output:"ioDatatypeTemp fcs_arr_tmp"}
execute if score ioDatatypeTemp fcs_arr_tmp matches 1 run data modify storage fimel_sklibs:arrays temp.ioTemp.char1 set value "\""
