data modify storage fimel_anim_text:runtime operation.matrix.value set value [2.770,\
2.570,\
2.390,\
2.220,\
2.050,\
1.900,\
1.760,\
1.630,\
1.510,\
1.405,\
1.310,\
1.225,\
1.151,\
1.090,\
1.039,\
1.000,\
0.972,\
0.955,\
0.950,\
0.956,\
0.972,\
1.000]

data modify storage fimel_anim_text:runtime operation.matrix.scale set from storage fimel_anim_text:runtime positional.animation.scale

# 计算矩阵倍率

function fimel_anim_text:operation/matrix/scale1/start

data modify storage fimel_anim_text:runtime positional.animation.transformation.interpolation set from storage fimel_anim_text:runtime operation.matrix.output

# 声音分值

data modify storage fimel_anim_text:runtime positional.animation.transformation.sound set value 20

# 时间分数

scoreboard players set #positional.animation.time.max fca_store 22

scoreboard players set #positional.animation.time.start fca_store 0