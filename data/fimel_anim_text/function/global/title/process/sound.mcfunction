# 设置音效分数

scoreboard players operation #operation.sound fca_store = #global.title.sound fca_store

execute if score #operation.next.sound fca_store matches -2147483648.. run scoreboard players operation #operation.sound fca_store = #operation.next.sound fca_store

execute as @a[tag=!fimel.anim_text.replace.title] at @s run function fimel_anim_text:operation/sound/default