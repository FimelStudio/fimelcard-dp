# 设置音效分数

scoreboard players operation #operation.sound fca_store = #global.subtitle.sound fca_store

execute as @a[tag=!fimel.anim_text.replace.subtitle] at @s run function fimel_anim_text:operation/sound/default_out