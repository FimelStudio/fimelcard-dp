# 设置参数

tag @s add fimel.anim_text.mark

tag @s add fimel.anim_text.positional

tag @s add fimel.anim_text.positional.animation

tag @s add fimel.anim_text.positional.animation.center

rotate @s ~ ~

# 复制数据

data modify entity @s data.command set from storage fimel_anim_text:runtime positional.animation.command

function fimel_anim_text:positional/animation/start/summon/properties

data modify entity @s transformation.scale set from storage fimel_anim_text:runtime positional.animation.transformation.scale

# 设置分数

scoreboard players set @s fca_timer 1

scoreboard players operation @s fca_id = #entity.count fca_store

scoreboard players operation @s fca_timer_total = #positional.animation.amount fca_store

# 设置背景

data modify storage fimel_anim_text:runtime positional.animation.background set value []

function fimel_anim_text:positional/animation/start/background

data modify entity @s text set value {storage:"fimel_anim_text:runtime",nbt:"positional.animation.background",interpret:true}

# tp修正

execute store success entity @s OnGround byte 1 unless data entity @s {OnGround:1}