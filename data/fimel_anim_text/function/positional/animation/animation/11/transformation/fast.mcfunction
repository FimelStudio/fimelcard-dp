data modify storage fimel_anim_text:runtime operation.matrix.value set value [1.4985,\
1.4835,\
1.4325,\
1.3440,\
1.2105,\
1.0470,\
0.7950,\
0.4500,\
0.1230,\
-0.0315,\
-0.0160,\
0.0000]

data modify storage fimel_anim_text:runtime operation.matrix.scale set from storage fimel_anim_text:runtime positional.animation.scale

# 计算矩阵倍率

function fimel_anim_text:operation/matrix/scale1.0/start

data modify storage fimel_anim_text:runtime positional.animation.transformation.interpolation set from storage fimel_anim_text:runtime operation.matrix.output

# 声音分值

data modify storage fimel_anim_text:runtime positional.animation.transformation.sound set value 10

# 时间分数

scoreboard players set #positional.animation.time.max fca_store 12

scoreboard players set #positional.animation.time.start fca_store 0