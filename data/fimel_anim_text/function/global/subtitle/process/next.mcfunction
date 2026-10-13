# 结束检测

execute unless data storage fimel_anim_text:runtime global.subtitle.input[0] run return run function fimel_anim_text:global/subtitle/stop/stop

# 转移文本

function fimel_anim_text:global/subtitle/process/txt_trans

# 计算下一刻时间

function fimel_anim_text:global/subtitle/process/punctuation

# 显示与声音

execute unless score #global.subtitle.punctuation fca_store matches 1.. run function fimel_anim_text:global/subtitle/process/sound

function fimel_anim_text:global/subtitle/process/title