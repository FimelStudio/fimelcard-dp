
data modify storage fimel_sklibs:math temp.hexList set value []

function fimel_sklibs:skapi_math/private/dec2hex/_1

data modify storage fimel_sklibs:arrays temp.l2s set from storage fimel_sklibs:math temp.hexList
function fimel_sklibs:skapi_arrays/list2string
data modify storage fimel_sklibs:math temp.hexString set from storage fimel_sklibs:arrays temp.l2sA
