

function fimel_sklibs:skapi_arrays/private/jsontext2string_0 with storage fimel_sklibs:arrays temp.jsontext
data modify storage fimel_sklibs:arrays temp.jsontextlist set value []

data modify storage fimel_sklibs:arrays temp.foreachTarget set from storage fimel_sklibs:arrays temp.jsontext
data modify storage fimel_sklibs:arrays temp.foreachTemp.cmd set value "function fimel_sklibs:skapi_arrays/private/jsontext2string_1"
data modify storage fimel_sklibs:arrays temp.foreachTemp.i set value "storage fimel_sklibs:arrays temp.jsontextI"
function fimel_sklibs:skapi_arrays/foreach

data modify storage fimel_sklibs:arrays temp.l2s set from storage fimel_sklibs:arrays temp.jsontextlist
function fimel_sklibs:skapi_arrays/list2string
data modify storage fimel_sklibs:arrays temp.jsontextOutput set from storage fimel_sklibs:arrays temp.l2sA
