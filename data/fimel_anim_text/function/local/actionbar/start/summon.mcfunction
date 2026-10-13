# 设置参数

tag @s add fimel.anim_text.mark

tag @s add fimel.anim_text.local.actionbar

data modify entity @s width set value 0

data modify entity @s height set value 0

data modify entity @s interaction set from storage fimel_anim_text:runtime local.actionbar.player

# 复制数据

scoreboard players operation @s fca_player_id = #player.current fca_store

execute store result entity @s data.sound int 1 run scoreboard players get #local.actionbar.sound fca_store

execute store result entity @s data.speed int 1 run scoreboard players get #local.actionbar.speed fca_store

execute store result entity @s data.style int 1 run scoreboard players get #local.actionbar.style fca_store

execute store result entity @s data.replace int 1 run scoreboard players get #local.actionbar.replace fca_store

data modify entity @s data.command set from storage fimel_anim_text:runtime local.actionbar.command

data modify entity @s data.input set from storage fimel_anim_text:runtime operation.text.output

data modify entity @s data.template set value []

# debug

#tellraw @a {entity:"@s",nbt:"data.style"}

# 设置分数

scoreboard players set @s fca_timer 0