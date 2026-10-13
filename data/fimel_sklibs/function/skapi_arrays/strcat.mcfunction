
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(a),output:{data:"storage fimel_sklibs:arrays temp.strcatArgs.a"}}
$function fimel_sklibs:skapi_arrays/native/io/io {input:$(b),output:{data:"storage fimel_sklibs:arrays temp.strcatArgs.b"}}

function fimel_sklibs:skapi_arrays/private/strcat.run1 with storage fimel_sklibs:arrays temp.strcatArgs

$function fimel_sklibs:skapi_arrays/native/io/io {input:{data:"storage fimel_sklibs:arrays temp.strcatOutput"},output:$(a)}