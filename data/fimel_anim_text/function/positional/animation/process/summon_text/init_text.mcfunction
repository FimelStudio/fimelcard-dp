# 添加标签

tag @s add fimel.anim_text.mark

tag @s add fimel.anim_text.positional

tag @s add fimel.anim_text.positional.animation

tag @s add fimel.anim_text.positional.animation.text

# 赋分

scoreboard players operation @s fca_id = #entity.current fca_store

scoreboard players operation @s fca_timer_max = #positional.animation.time.max fca_store

scoreboard players operation @s fca_style = #positional.animation.style fca_store

scoreboard players operation @s fca_timer_start = #positional.animation.time.start fca_store

# 复制数据

rotate @s ~ ~

function fimel_anim_text:positional/animation/process/summon_text/properties

function fimel_anim_text:positional/animation/process/summon_text/specific

# tp修正

execute store success entity @s OnGround byte 1 unless data entity @s {OnGround:1}