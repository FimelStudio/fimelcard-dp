
scoreboard players set searchIndex fcs_arr_tmp 0
data modify storage fimel_sklibs:arrays temp.searchOutput set value []
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(find),output:{data:"storage fimel_sklibs:arrays temp.searchFind"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(target),output:{data:"storage fimel_sklibs:arrays temp.searchTarget"}}
function fimel_sklibs:skapi_arrays/foreach {i:{data:"storage fimel_sklibs:arrays temp.searchI"},target:{data:"storage fimel_sklibs:arrays temp.searchTarget"},execute:{value:"function fimel_sklibs:skapi_arrays/private/search.run1"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:{data:"storage fimel_sklibs:arrays temp.searchOutput"},output:$(output)}
