
data modify storage fimel_skform:runtime temp.i.form_id set from storage fimel_skform:runtime temp.form_id
# data modify storage fimel_skform:runtime temp.i.storage set from storage fimel_skform:runtime temp.storage_name

execute if data storage fimel_skform:runtime temp.i{type:"int"} run return run function fimel_skform:show_form/_render/_int with storage fimel_skform:runtime temp.i
execute if data storage fimel_skform:runtime temp.i{type:"radio"} run return run function fimel_skform:show_form/_render/_radio with storage fimel_skform:runtime temp.i
execute if data storage fimel_skform:runtime temp.i{type:"checkbox"} run return run function fimel_skform:show_form/_render/_checkbox with storage fimel_skform:runtime temp.i
execute if data storage fimel_skform:runtime temp.i{type:"color"} run return run function fimel_skform:show_form/_render/_color with storage fimel_skform:runtime temp.i
data modify storage fimel_skform:runtime temp.rendered append from storage fimel_skform:runtime temp.form[0]


