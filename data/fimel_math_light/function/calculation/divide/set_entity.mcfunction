data modify storage fimel_math_light:runtime calculation.divide.mat set value [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0]

data modify storage fimel_math_light:runtime calculation.divide.mat[10] set from storage fimel_math_light:runtime calculation.divide.input.1

data modify storage fimel_math_light:runtime calculation.divide.mat[-1] set from storage fimel_math_light:runtime calculation.divide.input.2

data modify entity @s transformation set from storage fimel_math_light:runtime calculation.divide.mat

data modify storage fimel_math_light:runtime calculation.divide.output set from entity @s transformation.scale[2]

kill @s