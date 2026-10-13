
execute store result storage fimel_skform:runtime temp.i.index int 1 run scoreboard players get fimel.skform.i fcs_lib

function fimel_skform:show_form/_render/_checkbox/_1 with storage fimel_skform:runtime temp.i

execute unless data storage fimel_skform:runtime temp.i.fg_0 run data modify storage fimel_skform:runtime temp.i.fg_0 set value "#FFFFFF"
execute unless data storage fimel_skform:runtime temp.i.fg_1 run data modify storage fimel_skform:runtime temp.i.fg_1 set value "#00FFFF"

execute if score fimel.skform.i_storage fcs_lib matches 1 run function fimel_skform:show_form/_render/_checkbox/_3 with storage fimel_skform:runtime temp.i
execute unless score fimel.skform.i_storage fcs_lib matches 1 run function fimel_skform:show_form/_render/_checkbox/_4 with storage fimel_skform:runtime temp.i

data modify storage fimel_skform:runtime temp.rendered append value {type:"text",text:"\u00a7r"}

data remove storage fimel_skform:runtime temp.values[0]
scoreboard players add fimel.skform.i fcs_lib 1
execute if data storage fimel_skform:runtime temp.values[0] run function fimel_skform:show_form/_render/_checkbox/_0
