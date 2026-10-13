# 复制文本

data modify storage fimel_anim_text:runtime storage.output.data.template append from storage fimel_anim_text:runtime storage.output.data.input[0]

# 移除文本

data remove storage fimel_anim_text:runtime storage.output.data.input[0]

# 检测长度

execute store result score #storage.output.data.length fca_store run data get storage fimel_anim_text:runtime storage.output.data.template

execute if score #storage.output.data.length fca_store matches 45.. run data remove storage fimel_anim_text:runtime storage.output.data.template[0]