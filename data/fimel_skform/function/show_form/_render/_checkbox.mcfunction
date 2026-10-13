
$execute unless data storage fimel_skform:runtime temp.storage.$(key) run function fimel_skform:show_form/_render/_checkbox/_init with storage fimel_skform:runtime temp.i

data modify storage fimel_skform:runtime temp.values set from storage fimel_skform:runtime temp.i.values
scoreboard players set fimel.skform.i fcs_lib 0
function fimel_skform:show_form/_render/_checkbox/_0

return 1
