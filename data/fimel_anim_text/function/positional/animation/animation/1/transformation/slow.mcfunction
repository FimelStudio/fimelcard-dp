data modify storage fimel_anim_text:runtime operation.matrix.value set value [0.001,\
0.004,\
0.011,\
0.024,\
0.045,\
0.070,\
0.104,\
0.144,\
0.193,\
0.244,\
0.302,\
0.380,\
0.470,\
0.570,\
0.700,\
0.820,\
0.918,\
0.985,\
1.021,\
1.033,\
1.026,\
1.000]

data modify storage fimel_anim_text:runtime operation.matrix.scale set from storage fimel_anim_text:runtime positional.animation.scale

# 计算矩阵倍率

function fimel_anim_text:operation/matrix/scale0/start

data modify storage fimel_anim_text:runtime positional.animation.transformation.interpolation set from storage fimel_anim_text:runtime operation.matrix.output

# 声音分值

data modify storage fimel_anim_text:runtime positional.animation.transformation.sound set value 20

# 时间分数

scoreboard players set #positional.animation.time.max fca_store 22

scoreboard players set #positional.animation.time.start fca_store 0