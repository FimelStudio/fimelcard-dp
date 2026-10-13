# 复制文本

data modify storage fimel_anim_text:runtime local.title.template append from storage fimel_anim_text:runtime local.title.input[0]

# 移除文本

data remove storage fimel_anim_text:runtime local.title.input[0]

# 检测长度

execute store result score #local.title.length fca_store run data get storage fimel_anim_text:runtime local.title.template

execute if score #local.title.length fca_store matches 18.. run data remove storage fimel_anim_text:runtime local.title.template[0]