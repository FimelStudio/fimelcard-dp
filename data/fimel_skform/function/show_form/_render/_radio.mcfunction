
# $execute unless data storage fimel_skform:runtime temp.storage.$(key) run data modify storage fimel_skform:runtime temp.storage.$(key) set value 0
execute unless data storage fimel_skform:runtime temp.i.default run data modify storage fimel_skform:runtime temp.i.default set value 0
$execute unless data storage fimel_skform:runtime temp.storage.$(key) run function fimel_skform:show_form/_render/__init with storage fimel_skform:runtime temp.i

data modify storage fimel_skform:runtime temp.values set from storage fimel_skform:runtime temp.i.values
scoreboard players set fimel.skform.i fcs_lib 0
function fimel_skform:show_form/_render/_radio/_0

return 1
