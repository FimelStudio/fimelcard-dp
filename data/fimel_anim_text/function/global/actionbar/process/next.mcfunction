# 结束检测

execute unless data storage fimel_anim_text:runtime global.actionbar.input[0] run return run function fimel_anim_text:global/actionbar/stop/stop

# 转移文本

function fimel_anim_text:global/actionbar/process/txt_trans

# 计算下一刻时间

function fimel_anim_text:global/actionbar/process/punctuation

# 显示与声音

execute unless score #global.actionbar.punctuation fca_store matches 1.. run function fimel_anim_text:global/actionbar/process/sound

function fimel_anim_text:global/actionbar/process/title