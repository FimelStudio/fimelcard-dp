

data modify storage fimel_skform:runtime temp.i set from storage fimel_skform:runtime temp.form[0]
#data modify storage fimel_skform:runtime temp.i.form_id set from storage fimel_skform:runtime temp.form_id

execute if data storage fimel_skform:runtime temp.i.key run function fimel_skform:show_form/_scoreboard/_0

data remove storage fimel_skform:runtime temp.form[0]
execute if data storage fimel_skform:runtime temp.form[0] run function fimel_skform:show_form/_scoreboard

