# 复制数据

data modify storage fimel_anim_text:runtime positional.typewriter set from entity @s data

# 结束检测

execute unless data storage fimel_anim_text:runtime positional.typewriter.input[0] run return run function fimel_anim_text:positional/typewriter/stop/stop

# 转移文本

function fimel_anim_text:positional/typewriter/process/txt_trans

# 计算下一刻时间

function fimel_anim_text:positional/typewriter/process/punctuation

# 显示与声音

execute unless score #positional.typewriter.punctuation fca_store matches 1.. run function fimel_anim_text:positional/typewriter/process/sound

function fimel_anim_text:positional/typewriter/process/data

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.typewriter