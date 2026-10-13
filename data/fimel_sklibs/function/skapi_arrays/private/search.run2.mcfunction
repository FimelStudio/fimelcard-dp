
data modify storage fimel_sklibs:arrays temp.searchOutput append value 0
execute store result storage fimel_sklibs:arrays temp.searchOutput[-1] int 1.0 run scoreboard players get searchIndex fcs_arr_tmp
