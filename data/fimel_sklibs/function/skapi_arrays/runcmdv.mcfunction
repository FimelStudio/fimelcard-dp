


data modify storage fimel_sklibs:arrays temp.foreachTarget set from storage fimel_sklibs:arrays temp.runcmdv
data modify storage fimel_sklibs:arrays temp.foreachTemp.i set value "storage fimel_sklibs:arrays temp.runcmdvI"
data modify storage fimel_sklibs:arrays temp.foreachTemp.cmd set value "function fimel_sklibs:skapi_arrays/private/runcmdv.run1 with storage fimel_sklibs:arrays temp.runcmdvI"
function fimel_sklibs:skapi_arrays/foreach

# function fimel_sklibs:skapi_arrays/runcmdv {cmdv:{value:[{cmd:"say 1",args:{}}]}}



