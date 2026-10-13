
$function fimel_sklibs:skapi_arrays/search {find:$(find),target:$(target),output:{data:"storage fimel_sklibs:arrays temp.searchCountTemp"}}
$function fimel_sklibs:skapi_arrays/len {input:{data:"storage fimel_sklibs:arrays temp.searchCountTemp"},output:$(output)}