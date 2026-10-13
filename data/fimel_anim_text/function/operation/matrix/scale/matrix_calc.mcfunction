# 乘法计算

data modify storage fimel_math_light:runtime calculation.multiply.input.1 set from storage fimel_anim_text:runtime operation.matrix.value[0]

data modify storage fimel_math_light:runtime calculation.multiply.input.2 set from storage fimel_anim_text:runtime operation.matrix.scale

function fimel_math_light:calculation/multiply

data modify storage fimel_anim_text:runtime operation.matrix.temp set value []

data modify storage fimel_anim_text:runtime operation.matrix.temp append from storage fimel_math_light:runtime calculation.multiply.output
data modify storage fimel_anim_text:runtime operation.matrix.temp append from storage fimel_math_light:runtime calculation.multiply.output
data modify storage fimel_anim_text:runtime operation.matrix.temp append from storage fimel_math_light:runtime calculation.multiply.output

# 插入矩阵

data modify storage fimel_anim_text:runtime operation.matrix.output append from storage fimel_anim_text:runtime operation.matrix.temp

# 移除数据

data remove storage fimel_anim_text:runtime operation.matrix.value[0]

# 检测递归

execute if data storage fimel_anim_text:runtime operation.matrix.value[0] run function fimel_anim_text:operation/matrix/scale/matrix_calc