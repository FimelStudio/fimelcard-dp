# 无动能返回

execute unless data storage fimel_anim_text:runtime operation.drop.input.motion run return run function fimel_anim_text:operation/drop/default

# 检测是否为列表

execute if data storage fimel_anim_text:runtime operation.drop.input.motion[] run return run function fimel_anim_text:operation/drop/list

# 处理含不同方向、速度的掉落

execute if data storage fimel_anim_text:runtime operation.drop.input.motion run function fimel_anim_text:operation/drop/rotation