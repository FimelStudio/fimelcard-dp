# 设置参数

tag @s add fimel.anim_text.mark

tag @s add fimel.anim_text.positional

tag @s add fimel.anim_text.positional.typewriter

rotate @s ~ ~

# 复制数据

execute store result entity @s data.sound int 1 run scoreboard players get #positional.typewriter.sound fca_store

execute store result entity @s data.speed int 1 run scoreboard players get #positional.typewriter.speed fca_store

execute store result entity @s data.style int 1 run scoreboard players get #positional.typewriter.style fca_store

execute store result entity @s data.width int 1 run scoreboard players get #positional.typewriter.width fca_store

data modify entity @s data.command set from storage fimel_anim_text:runtime positional.typewriter.command

data modify entity @s data.input set from storage fimel_anim_text:runtime positional.typewriter.input

# 初始化数据

data modify entity @s data.template set value []

# 自定义数据

execute if data storage fimel_anim_text:runtime positional.typewriter.entity_properties{} run function fimel_anim_text:positional/typewriter/start/properties

# 设置分数

scoreboard players set @s fca_timer 0

# tp修正

execute store success entity @s OnGround byte 1 unless data entity @s {OnGround:1}