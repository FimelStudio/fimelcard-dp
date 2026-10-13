
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(find),output:{data:"storage fimel_sklibs:arrays temp.findFind"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(target),output:{data:"storage fimel_sklibs:arrays temp.findTarget"}}
function fimel_sklibs:skapi_arrays/foreach {i:{data:"storage fimel_sklibs:arrays temp.findI"},target:{data:"storage fimel_sklibs:arrays temp.findTarget"},execute:{value:"function fimel_sklibs:skapi_arrays/private/find.run1"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:{score:"findResult fcs_arr_tmp"},output:$(output)}
