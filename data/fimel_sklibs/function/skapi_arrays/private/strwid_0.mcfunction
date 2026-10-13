


scoreboard players set strwid_a fcs_arr_tmp 8
$execute if data storage fimel_sklibs:arrays temp.strwiddb."$(value)" store result score strwid_a fcs_arr_tmp run data get storage fimel_sklibs:arrays temp.strwiddb."$(value)" 1

scoreboard players operation strwid0 fcs_arr_tmp += strwid_a fcs_arr_tmp
scoreboard players add strwid0 fcs_arr_tmp 1
