data modify storage fimel_anim_text:runtime operation.matrix.value set value [0.004,\
0.024,\
0.070,\
0.144,\
0.244,\
0.380,\
0.570,\
0.820,\
0.985,\
1.033,\
1.016,\
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