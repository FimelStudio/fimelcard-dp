# 结束检测

execute unless data storage fimel_anim_text:runtime storage.output.data.template[0] run return run function fimel_anim_text:storage/output/stop/default

# 移除文本

data remove storage fimel_anim_text:runtime storage.output.data.template[-1]
data remove storage fimel_anim_text:runtime storage.output.data.template[-1]

# 显示与声音

#function fimel_anim_text:storage/output/process/sound_out

function fimel_anim_text:storage/output/process/store with storage fimel_anim_text:runtime storage.output.data