## 设置数据

# 设置速度参数

scoreboard players set #positional.animation.speed_ fca_store 100

execute if data storage fimel_anim_text:runtime positional.animation.data.speed store result score #positional.animation.speed_ fca_store run data get storage fimel_anim_text:runtime positional.animation.data.speed

scoreboard players set #positional.animation.speed fca_store 10000

scoreboard players operation #positional.animation.speed fca_store /= #positional.animation.speed_ fca_store

execute store result storage fimel_anim_text:runtime positional.animation.speed int 1 run scoreboard players get #positional.animation.speed fca_store

# 声音

data modify storage fimel_anim_text:runtime positional.animation.sound set value 1

execute if data storage fimel_anim_text:runtime positional.animation.data.sound run data modify storage fimel_anim_text:runtime positional.animation.sound set from storage fimel_anim_text:runtime positional.animation.data.sound

# 动画样式

data modify storage fimel_anim_text:runtime positional.animation.style set value 0

scoreboard players set #positional.animation.style fca_store 0

execute if data storage fimel_anim_text:runtime positional.animation.data.style run function fimel_anim_text:positional/animation/start/style

# 反向

data modify storage fimel_anim_text:runtime positional.animation.reverse set value 0

scoreboard players set #positional.animation.reverse fca_store 0

execute if data storage fimel_anim_text:runtime positional.animation.data.reverse run function fimel_anim_text:positional/animation/start/reverse

# 缩放

data modify storage fimel_anim_text:runtime positional.animation.scale set value 1.0

execute if data storage fimel_anim_text:runtime positional.animation.data.scale run function fimel_anim_text:positional/animation/start/set_scale

# 内联命令

data modify storage fimel_anim_text:runtime positional.animation.command set value ""

execute if data storage fimel_anim_text:runtime positional.animation.data.command run data modify storage fimel_anim_text:runtime positional.animation.command set from storage fimel_anim_text:runtime positional.animation.data.command

# 实体属性

data remove storage fimel_anim_text:runtime positional.animation.entity_properties

execute if data storage fimel_anim_text:runtime positional.animation.data.entity_properties run data modify storage fimel_anim_text:runtime positional.animation.entity_properties set from storage fimel_anim_text:runtime positional.animation.data.entity_properties

# transformation

data remove storage fimel_anim_text:runtime positional.animation.transformation

# 掉落动画

data remove storage fimel_anim_text:runtime positional.animation.drop

execute if data storage fimel_anim_text:runtime positional.animation.data.drop run data modify storage fimel_anim_text:runtime positional.animation.drop set from storage fimel_anim_text:runtime positional.animation.data.drop

# 文本检测

scoreboard players set #positional.animation.text fca_store 1

execute unless data storage fimel_anim_text:runtime positional.animation.data.text run return run scoreboard players set #positional.animation.text fca_store 0

# 文本预处理

scoreboard players set #positional.animation.analyse fca_store 1

execute if data storage fimel_anim_text:runtime positional.animation.data.analyse store result score #positional.animation.analyse fca_store run data get storage fimel_anim_text:runtime positional.animation.data.analyse

execute if score #positional.animation.analyse fca_store matches 0 run return run function fimel_anim_text:positional/animation/start/analyse_test

function fimel_anim_text:positional/animation/start/analyse
