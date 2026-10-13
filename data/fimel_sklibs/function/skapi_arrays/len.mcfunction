# 返回列表或字符串的数据长度，参数格式与其他SKapi Arrays函数一致。

$function fimel_sklibs:skapi_arrays/native/io/io {input:$(input),output:{score:"lenResult fcs_arr_tmp"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:{score:"lenResult fcs_arr_tmp"},output:$(output)}
