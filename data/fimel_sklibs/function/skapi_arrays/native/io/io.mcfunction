

# 初始化
$data modify storage fimel_sklibs:arrays temp.ioInput set value $(input)
$data modify storage fimel_sklibs:arrays temp.ioOutput set value $(output)
data modify storage fimel_sklibs:arrays temp.ioTemp set value {input:"",output:"",iScale:1.0,oScale:1.0,oDataType:"int",char1:"",char2:" "}

# 保存参数
data modify storage fimel_sklibs:arrays temp.ioTemp.input set from storage fimel_sklibs:arrays temp.ioInput.value
data modify storage fimel_sklibs:arrays temp.ioTemp.input set from storage fimel_sklibs:arrays temp.ioInput.data
data modify storage fimel_sklibs:arrays temp.ioTemp.input set from storage fimel_sklibs:arrays temp.ioInput.score
data modify storage fimel_sklibs:arrays temp.ioTemp.output set from storage fimel_sklibs:arrays temp.ioOutput.data
data modify storage fimel_sklibs:arrays temp.ioTemp.output set from storage fimel_sklibs:arrays temp.ioOutput.score
data modify storage fimel_sklibs:arrays temp.ioTemp.iScale set from storage fimel_sklibs:arrays temp.ioInput.scale
data modify storage fimel_sklibs:arrays temp.ioTemp.oScale set from storage fimel_sklibs:arrays temp.ioOutput.scale
data modify storage fimel_sklibs:arrays temp.ioTemp.oDataType set from storage fimel_sklibs:arrays temp.ioOutput.dataType

# 检测value是否为字符串，如果是，则在两端加上双引号
execute if data storage fimel_sklibs:arrays temp.ioInput.value run function fimel_sklibs:skapi_arrays/native/io/io.run1

# 检测输入倍率是否为0，如果是，则省略这项参数
execute store result score ioDatatypeTemp fcs_arr_tmp run data get storage fimel_sklibs:arrays temp.ioTemp.iScale 1.0
execute if score ioDatatypeTemp fcs_arr_tmp matches 0 run function fimel_sklibs:skapi_arrays/native/io/io.run2

# 根据输入输出的类型决定下一步操作
execute if data storage fimel_sklibs:arrays temp.ioInput.value if data storage fimel_sklibs:arrays temp.ioOutput.data run function fimel_sklibs:skapi_arrays/native/io/io.i_value.o_data with storage fimel_sklibs:arrays temp.ioTemp
execute if data storage fimel_sklibs:arrays temp.ioInput.value if data storage fimel_sklibs:arrays temp.ioOutput.score run function fimel_sklibs:skapi_arrays/native/io/io.i_value.o_score with storage fimel_sklibs:arrays temp.ioTemp
execute if data storage fimel_sklibs:arrays temp.ioInput.data if data storage fimel_sklibs:arrays temp.ioOutput.data run function fimel_sklibs:skapi_arrays/native/io/io.i_data.o_data with storage fimel_sklibs:arrays temp.ioTemp
execute if data storage fimel_sklibs:arrays temp.ioInput.data if data storage fimel_sklibs:arrays temp.ioOutput.score run function fimel_sklibs:skapi_arrays/native/io/io.i_data.o_score with storage fimel_sklibs:arrays temp.ioTemp
execute if data storage fimel_sklibs:arrays temp.ioInput.score if data storage fimel_sklibs:arrays temp.ioOutput.data run function fimel_sklibs:skapi_arrays/native/io/io.i_score.o_data with storage fimel_sklibs:arrays temp.ioTemp
execute if data storage fimel_sklibs:arrays temp.ioInput.score if data storage fimel_sklibs:arrays temp.ioOutput.score run function fimel_sklibs:skapi_arrays/native/io/io.i_score.o_score with storage fimel_sklibs:arrays temp.ioTemp
