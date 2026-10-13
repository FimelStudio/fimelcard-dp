
data modify storage fimel_sklibs:arrays temp.swaOutput set value []
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(target),output:{data:"storage fimel_sklibs:arrays temp.swaTarget"}}
$function fimel_sklibs:skapi_arrays/foreach {i:{data:"storage fimel_sklibs:arrays temp.swaI"},target:$(find),execute:{value:"function fimel_sklibs:skapi_arrays/private/searchwitharray.run1"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:{data:"storage fimel_sklibs:arrays temp.swaOutput"},output:$(output)}
