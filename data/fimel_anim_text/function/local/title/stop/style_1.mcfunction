# 结束检测

execute unless data storage fimel_anim_text:runtime local.title.template[0] run return run function fimel_anim_text:local/title/stop/default

# 移除文本

data remove storage fimel_anim_text:runtime local.title.template[-1]
data remove storage fimel_anim_text:runtime local.title.template[-1]

# 显示与声音

function fimel_anim_text:local/title/process/sound_out

execute on target run function fimel_anim_text:local/title/process/title