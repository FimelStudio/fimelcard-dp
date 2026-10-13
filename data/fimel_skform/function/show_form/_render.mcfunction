
data modify storage fimel_skform:runtime temp.i set from storage fimel_skform:runtime temp.form[0]

function fimel_skform:show_form/_render/_0

data remove storage fimel_skform:runtime temp.form[0]
execute if data storage fimel_skform:runtime temp.form[0] run function fimel_skform:show_form/_render

