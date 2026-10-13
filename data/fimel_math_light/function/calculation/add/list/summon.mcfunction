data remove storage fimel_math_light:runtime calculation.add.input[0]

data modify storage fimel_math_light:runtime calculation.add.temp.add set from storage fimel_math_light:runtime calculation.add.input[0]

data modify storage fimel_math_light:runtime calculation.add.output set from entity @s Pos[0]

execute if data storage fimel_math_light:runtime calculation.add.input[0] run function fimel_math_light:calculation/add/list/pos with storage fimel_math_light:runtime calculation.add.temp