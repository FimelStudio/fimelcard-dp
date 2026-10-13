

data modify storage fimel_skform:runtime temp.j set from storage fimel_skform:runtime temp.form[0]
#data modify storage fimel_skform:runtime temp.i.form_id set from storage fimel_skform:runtime temp.form_id

execute if data storage fimel_skform:runtime temp.j.key run function fimel_skform:tick/_reset/_scoreboard/_0

data remove storage fimel_skform:runtime temp.form[0]
execute if data storage fimel_skform:runtime temp.form[0] run function fimel_skform:tick/_reset/_scoreboard

