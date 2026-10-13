# 复制数据

data modify storage fimel_anim_text:runtime storage.output.data set from entity @s data

# 结束检测

execute unless data storage fimel_anim_text:runtime storage.output.data.input[0] run return run function fimel_anim_text:storage/output/stop/stop

# 转移文本

function fimel_anim_text:storage/output/process/txt_trans

# 计算下一刻时间

function fimel_anim_text:storage/output/process/punctuation

# 显示与声音

#execute unless score #storage.output.punctuation fca_store matches 1.. run function fimel_anim_text:storage/output/process/sound

function fimel_anim_text:storage/output/process/store with storage fimel_anim_text:runtime storage.output.data

# 恢复数据

data modify entity @s data set from storage fimel_anim_text:runtime storage.output.data