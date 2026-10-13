data modify storage fimel_math_light:runtime calculation.multiply.mat set value [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0]

data modify storage fimel_math_light:runtime calculation.multiply.mat[-1] set from storage fimel_math_light:runtime calculation.multiply.input.2

data modify entity @s transformation set from storage fimel_math_light:runtime calculation.multiply.mat

data modify storage fimel_math_light:runtime calculation.multiply.input._2 set from entity @s transformation.scale[0]

# 乘法

data modify storage fimel_math_light:runtime calculation.multiply.mat set value [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0]

data modify storage fimel_math_light:runtime calculation.multiply.mat[10] set from storage fimel_math_light:runtime calculation.multiply.input.1

data modify storage fimel_math_light:runtime calculation.multiply.mat[-1] set from storage fimel_math_light:runtime calculation.multiply.input._2

data modify entity @s transformation set from storage fimel_math_light:runtime calculation.multiply.mat

data modify storage fimel_math_light:runtime calculation.multiply.output set from entity @s transformation.scale[2]

kill @s