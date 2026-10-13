# 复制文本

data modify storage fimel_anim_text:runtime global.title.template append from storage fimel_anim_text:runtime global.title.input[0]

# 移除文本

data remove storage fimel_anim_text:runtime global.title.input[0]

# 检测长度

execute store result score #global.title.length fca_store run data get storage fimel_anim_text:runtime global.title.template

execute if score #global.title.length fca_store matches 18.. run data remove storage fimel_anim_text:runtime global.title.template[0]