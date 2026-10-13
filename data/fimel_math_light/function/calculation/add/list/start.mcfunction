data modify storage fimel_math_light:runtime calculation.add.temp.start set from storage fimel_math_light:runtime calculation.add.input[0]

data remove storage fimel_math_light:runtime calculation.add.input[0]

data modify storage fimel_math_light:runtime calculation.add.temp.add set from storage fimel_math_light:runtime calculation.add.input[0]

execute positioned 0.0 0.0 0.0 summon marker run function fimel_math_light:calculation/add/list/pos1