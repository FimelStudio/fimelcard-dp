## 计算位置

# 文本数量

execute store result score #positional.animation.amount fca_store run data get storage fimel_anim_text:runtime positional.animation.input

# 修正分数

scoreboard players add #positional.animation.amount fca_store 1

# 执行乘法计算

data remove storage fimel_math_light:runtime calculation.multiply.input

data modify storage fimel_math_light:runtime calculation.multiply.input.1 set value 0.228d

data modify storage fimel_math_light:runtime calculation.multiply.input.2 set from storage fimel_anim_text:runtime positional.animation.scale

function fimel_math_light:calculation/multiply

data modify storage fimel_anim_text:runtime positional.animation.shift.amount set from storage fimel_math_light:runtime calculation.multiply.output

#

execute store result storage fimel_math_light:runtime calculation.multiply.input.1 double 0.5 run scoreboard players get #positional.animation.amount fca_store

data modify storage fimel_math_light:runtime calculation.multiply.input.2 set from storage fimel_math_light:runtime calculation.multiply.output

function fimel_math_light:calculation/multiply

data modify storage fimel_anim_text:runtime positional.animation.shift.pos set from storage fimel_math_light:runtime calculation.multiply.output