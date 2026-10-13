# 复制文本

data modify storage fimel_anim_text:runtime local.subtitle.template append from storage fimel_anim_text:runtime local.subtitle.input[0]

# 移除文本

data remove storage fimel_anim_text:runtime local.subtitle.input[0]

# 检测长度

execute store result score #local.subtitle.length fca_store run data get storage fimel_anim_text:runtime local.subtitle.template

execute if score #local.subtitle.length fca_store matches 32.. run data remove storage fimel_anim_text:runtime local.subtitle.template[0]