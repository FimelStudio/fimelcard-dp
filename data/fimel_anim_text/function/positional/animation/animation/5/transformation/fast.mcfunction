data modify storage fimel_anim_text:runtime operation.matrix.value set value [2.770,\
2.390,\
2.050,\
1.760,\
1.510,\
1.310,\
1.151,\
1.039,\
0.972,\
0.950,\
0.962,\
1.000]

data modify storage fimel_anim_text:runtime operation.matrix.scale set from storage fimel_anim_text:runtime positional.animation.scale

# 计算矩阵倍率

function fimel_anim_text:operation/matrix/scale1/start

data modify storage fimel_anim_text:runtime positional.animation.transformation.interpolation set from storage fimel_anim_text:runtime operation.matrix.output

# 声音分值

data modify storage fimel_anim_text:runtime positional.animation.transformation.sound set value 10

# 时间分数

scoreboard players set #positional.animation.time.max fca_store 12

scoreboard players set #positional.animation.time.start fca_store 0