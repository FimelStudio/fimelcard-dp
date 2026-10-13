# 复制数据

data modify storage fimel_anim_text:runtime local.title set from entity @s data

# 结束检测

execute unless data storage fimel_anim_text:runtime local.title.input[0] run return run function fimel_anim_text:local/title/stop/stop

# 转移文本

function fimel_anim_text:local/title/process/txt_trans

# 计算下一刻时间

function fimel_anim_text:local/title/process/punctuation

# 显示与声音

execute unless score #local.title.punctuation fca_store matches 1.. run function fimel_anim_text:local/title/process/sound

execute on target run function fimel_anim_text:local/title/process/title

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime local.title