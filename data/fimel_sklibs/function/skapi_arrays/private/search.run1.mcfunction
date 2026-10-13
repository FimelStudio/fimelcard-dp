
function fimel_sklibs:skapi_arrays/equal {a:{data:"storage fimel_sklibs:arrays temp.searchI"},b:{data:"storage fimel_sklibs:arrays temp.searchFind"},output:{score:"searchResult fcs_arr_tmp"}}
# tellraw @a [{"score":{"name": "searchResult","objective": "fcs_arr_tmp"}}]
execute if score searchResult fcs_arr_tmp matches 1 run function fimel_sklibs:skapi_arrays/private/search.run2
scoreboard players add searchIndex fcs_arr_tmp 1
