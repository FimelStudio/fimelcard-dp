
data modify storage fimel_sklibs:arrays temp.l2sM.a set from storage fimel_sklibs:arrays temp.l2sA
data modify storage fimel_sklibs:arrays temp.l2sM.b set from storage fimel_sklibs:arrays temp.l2s[0]
data remove storage fimel_sklibs:arrays temp.l2s[0]

function fimel_sklibs:skapi_arrays/private/l2s_1 with storage fimel_sklibs:arrays temp.l2sM
execute if data storage fimel_sklibs:arrays temp.l2s[0] run function fimel_sklibs:skapi_arrays/private/l2s
