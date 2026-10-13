# 结束检测

execute unless data storage fimel_anim_text:runtime positional.typewriter.template[0] run return run function fimel_anim_text:positional/typewriter/stop/default

# 移除文本

data remove storage fimel_anim_text:runtime positional.typewriter.template[-1]
data remove storage fimel_anim_text:runtime positional.typewriter.template[0]

# 显示与声音

function fimel_anim_text:positional/typewriter/process/sound_out

function fimel_anim_text:positional/typewriter/process/data