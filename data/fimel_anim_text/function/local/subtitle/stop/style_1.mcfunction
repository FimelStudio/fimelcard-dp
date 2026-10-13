# 结束检测

execute unless data storage fimel_anim_text:runtime local.subtitle.template[0] run return run function fimel_anim_text:local/subtitle/stop/default

# 移除文本

data remove storage fimel_anim_text:runtime local.subtitle.template[-1]
data remove storage fimel_anim_text:runtime local.subtitle.template[-1]

# 显示与声音

function fimel_anim_text:local/subtitle/process/sound_out

execute on target run function fimel_anim_text:local/subtitle/process/title