# 设置参数

tag @s add fimel.anim_text.mark

tag @s add fimel.anim_text.storage

data modify entity @s Tags append from storage fimel_anim_text:runtime storage.output.data.id

# 复制数据

scoreboard players operation @s fca_player_id = #player.current fca_store

execute store result entity @s data.sound int 1 run scoreboard players get #storage.output.sound fca_store

execute store result entity @s data.speed int 1 run scoreboard players get #storage.output.speed fca_store

execute store result entity @s data.style int 1 run scoreboard players get #storage.output.style fca_store

execute store result entity @s data.replace int 1 run scoreboard players get #storage.output.replace fca_store

data modify entity @s data.command set from storage fimel_anim_text:runtime storage.output.data.command

data modify entity @s data.id set from storage fimel_anim_text:runtime storage.output.data.id

data modify entity @s data.input set from storage fimel_anim_text:runtime operation.text.output

data modify entity @s data.template set value []

# 设置分数

scoreboard players set @s fca_timer 0