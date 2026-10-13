
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(input),output:{data:"storage fimel_sklibs:arrays temp.2str.v"}}
function fimel_sklibs:skapi_arrays/private/tostring_ with storage fimel_sklibs:arrays temp.2str
$function fimel_sklibs:skapi_arrays/native/io/io {input:{data:"storage fimel_sklibs:arrays temp.2strOutput"},output:$(output)}
