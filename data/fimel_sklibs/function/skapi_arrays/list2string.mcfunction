


data modify storage fimel_sklibs:arrays temp.l2sA set from storage fimel_sklibs:arrays temp.l2s[0]
data remove storage fimel_sklibs:arrays temp.l2s[0]

execute if data storage fimel_sklibs:arrays temp.l2s[0] run function fimel_sklibs:skapi_arrays/private/l2s


