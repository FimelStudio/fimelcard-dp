# 变换视角

execute unless data storage fimel_anim_text:runtime operation.drop.input.direction.rotation run data modify storage fimel_anim_text:runtime operation.drop.input.direction.rotation set from storage fimel_anim_text:runtime positional.animation.Rotation

# 判断随机性

execute unless data storage fimel_anim_text:runtime operation.drop.input.direction.x_rotation unless data storage fimel_anim_text:runtime operation.drop.input.direction.y_rotation run function fimel_anim_text:operation/drop/rotation/accurate/store

execute if data storage fimel_anim_text:runtime operation.drop.input.direction.x_rotation unless data storage fimel_anim_text:runtime operation.drop.input.direction.y_rotation run function fimel_anim_text:operation/drop/rotation/random.x/store

execute unless data storage fimel_anim_text:runtime operation.drop.input.direction.x_rotation if data storage fimel_anim_text:runtime operation.drop.input.direction.y_rotation run function fimel_anim_text:operation/drop/rotation/random.y/store

execute if data storage fimel_anim_text:runtime operation.drop.input.direction.x_rotation if data storage fimel_anim_text:runtime operation.drop.input.direction.y_rotation run function fimel_anim_text:operation/drop/rotation/random.all/store

# 设置速度属性

execute summon marker run function fimel_anim_text:operation/drop/motion