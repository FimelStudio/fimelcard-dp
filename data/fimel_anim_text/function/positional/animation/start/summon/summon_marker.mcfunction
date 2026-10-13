# 设置参数

tag @s add fimel.anim_text.mark

tag @s add fimel.anim_text.positional

tag @s add fimel.anim_text.positional.animation

tag @s add fimel.anim_text.positional.animation.marker

rotate @s ~ ~

# 复制数据

data modify entity @s data set from storage fimel_anim_text:runtime positional.animation

data remove entity @s data.data

data modify entity @s data.Rotation set from entity @s Rotation

# 设置分数

scoreboard players set @s fca_timer 0

scoreboard players operation @s fca_id = #entity.count fca_store

scoreboard players operation @s fca_timer_max = #positional.animation.time.max fca_store

scoreboard players operation @s fca_style = #positional.animation.style fca_store

# 检测样式生成模式

execute unless score #positional.animation.style fca_store matches 28..35 run return fail

function fimel_anim_text:positional/animation/start/marker/start