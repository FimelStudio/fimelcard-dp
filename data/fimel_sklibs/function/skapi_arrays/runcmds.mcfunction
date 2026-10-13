

data modify storage fimel_sklibs:arrays temp.foreachTarget set from storage fimel_sklibs:arrays temp.runcmds
data modify storage fimel_sklibs:arrays temp.foreachTemp.cmd set value "function fimel_sklibs:skapi_arrays/private/runcmds.run1 with storage fimel_sklibs:arrays temp.runcmdsI"
data modify storage fimel_sklibs:arrays temp.foreachTemp.i set value "storage fimel_sklibs:arrays temp.runcmdsI.value"
function fimel_sklibs:skapi_arrays/foreach

