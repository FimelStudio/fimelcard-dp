
# say max

execute store result score fimel.skform.max fcs_lib run data get storage fimel_skform:runtime temp.scoreboards[0].max 1
execute store result score fimel.skform.now fcs_lib run data get storage fimel_skform:runtime temp.args_tri.value 1

# execute if score fimel.skform.now fcs_lib > fimel.skform.max fcs_lib run say max chaecked

execute if score fimel.skform.now fcs_lib > fimel.skform.max fcs_lib run scoreboard players operation fimel.skform.now fcs_lib = fimel.skform.max fcs_lib

execute store result storage fimel_skform:runtime temp.args_tri.value int 1 run scoreboard players get fimel.skform.now fcs_lib


