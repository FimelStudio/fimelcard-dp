# 对输入整数执行逻辑非：0变为1，其他值变为0。
# 输入输出继续使用SKapi Arrays既有的通用IO结构。

$function fimel_sklibs:skapi_arrays/native/io/io {input:$(input),output:{score:"notInput fcs_arr_tmp"}}
scoreboard players set notResult fcs_arr_tmp 0
execute if score notInput fcs_arr_tmp matches 0 run scoreboard players set notResult fcs_arr_tmp 1
$function fimel_sklibs:skapi_arrays/native/io/io {input:{score:"notResult fcs_arr_tmp"},output:$(output)}
