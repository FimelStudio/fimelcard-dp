


$data modify storage fimel_sklibs:arrays temp.runcmds set from storage fimel_sklibs:runtime sk_sche.event[{time:$(time)}].cmd
$data remove storage fimel_sklibs:runtime sk_sche.event[{time:$(time)}]
function fimel_sklibs:skapi_arrays/runcmds
