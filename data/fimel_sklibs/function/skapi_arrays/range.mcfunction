
# range(start, stop, step, output(data))


execute if score rangeStep fcs_arr_tmp matches 0 run return run function fimel_sklibs:skapi_arrays/private/info {type:2,text:"请求一个不为0的步长值"}

data modify storage fimel_sklibs:arrays temp.rangeOutput set value []
function fimel_sklibs:skapi_arrays/private/range_



