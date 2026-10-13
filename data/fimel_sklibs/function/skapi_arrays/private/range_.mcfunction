

execute store result storage fimel_sklibs:arrays temp.rangeCurrentValue int 1.0 run scoreboard players get rangeStart fcs_arr_tmp
data modify storage fimel_sklibs:arrays temp.rangeOutput append from storage fimel_sklibs:arrays temp.rangeCurrentValue
scoreboard players operation rangeStart fcs_arr_tmp += rangeStep fcs_arr_tmp
execute if score rangeStart fcs_arr_tmp < rangeStop fcs_arr_tmp run function fimel_sklibs:skapi_arrays/private/range_