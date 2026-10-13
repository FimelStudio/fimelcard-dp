# 复制文本

data modify storage fimel_anim_text:runtime local.actionbar.template append from storage fimel_anim_text:runtime local.actionbar.input[0]

# 移除文本

data remove storage fimel_anim_text:runtime local.actionbar.input[0]

# 检测长度

execute store result score #local.actionbar.length fca_store run data get storage fimel_anim_text:runtime local.actionbar.template

execute if score #local.actionbar.length fca_store matches 45.. run data remove storage fimel_anim_text:runtime local.actionbar.template[0]