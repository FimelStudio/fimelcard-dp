# 复制文本

data modify storage fimel_anim_text:runtime positional.typewriter.template append from storage fimel_anim_text:runtime positional.typewriter.input[0]

# 移除文本

data remove storage fimel_anim_text:runtime positional.typewriter.input[0]

# 检测长度

execute store result score #positional.typewriter.length fca_store run data get storage fimel_anim_text:runtime positional.typewriter.template

execute store result score #positional.typewriter.width fca_store run data get storage fimel_anim_text:runtime positional.typewriter.width

execute if score #positional.typewriter.length fca_store > #positional.typewriter.width fca_store run data remove storage fimel_anim_text:runtime positional.typewriter.template[0]