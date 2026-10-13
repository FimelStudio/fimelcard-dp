# 结束检测

execute unless data storage fimel_anim_text:runtime global.subtitle.template[0] run return run function fimel_anim_text:global/subtitle/stop/default

# 移除文本

data remove storage fimel_anim_text:runtime global.subtitle.template[0]
data remove storage fimel_anim_text:runtime global.subtitle.template[-1]

# 显示与声音

function fimel_anim_text:global/subtitle/process/sound_out

function fimel_anim_text:global/subtitle/process/title