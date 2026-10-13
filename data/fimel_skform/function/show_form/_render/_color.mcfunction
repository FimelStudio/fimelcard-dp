
execute unless data storage fimel_skform:runtime temp.i.default run data modify storage fimel_skform:runtime temp.i.default set value 13027014
$execute unless data storage fimel_skform:runtime temp.storage.$(key) run function fimel_skform:show_form/_render/__init1 with storage fimel_skform:runtime temp.i

$execute store result score dec.input fcs_math run data get storage fimel_skform:runtime temp.storage.$(key) 1.0
function fimel_sklibs:skapi_math/dec2hex

data modify storage fimel_skform:runtime temp.i.hex_color set from storage fimel_sklibs:math temp.hexString

function fimel_skform:show_form/_render/_color/_0 with storage fimel_skform:runtime temp.i

return 1
