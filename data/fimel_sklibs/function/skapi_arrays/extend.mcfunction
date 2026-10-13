

data modify storage fimel_sklibs:arrays temp.foreachTarget set from storage fimel_sklibs:arrays temp.extendB
data modify storage fimel_sklibs:arrays temp.foreachTemp.cmd set value "function fimel_sklibs:skapi_arrays/private/extend.run1"
data modify storage fimel_sklibs:arrays temp.foreachTemp.i set value "storage fimel_sklibs:arrays temp.foreachI.value"

function fimel_sklibs:skapi_arrays/foreach
