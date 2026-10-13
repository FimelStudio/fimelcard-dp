# 结束检测

execute unless data storage fimel_anim_text:runtime global.title.input[0] run return run function fimel_anim_text:global/title/stop/stop

# 转移文本

function fimel_anim_text:global/title/process/txt_trans

# 计算下一刻时间

function fimel_anim_text:global/title/process/punctuation

# 显示与声音

execute unless score #global.title.punctuation fca_store matches 1.. run function fimel_anim_text:global/title/process/sound

function fimel_anim_text:global/title/process/title