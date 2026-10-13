# 设置音效分数

execute store result score #operation.sound fca_store run data get storage fimel_anim_text:runtime local.subtitle.sound

execute if score #operation.next.sound fca_store matches -2147483648.. run scoreboard players operation #operation.sound fca_store = #operation.next.sound fca_store

execute on target at @s run function fimel_anim_text:operation/sound/default