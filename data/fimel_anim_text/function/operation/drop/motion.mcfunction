# 设置朝向

data modify entity @s Rotation set from storage fimel_anim_text:runtime operation.drop.rotation.output

# 设置速度

function fimel_anim_text:operation/drop/default

execute if data storage fimel_anim_text:runtime operation.drop.input.motion.max if data storage fimel_anim_text:runtime operation.drop.input.motion.min run return run function fimel_anim_text:operation/drop/motion/random

function fimel_anim_text:operation/drop/motion/accurate