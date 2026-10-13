# 设置音效分数

execute store result score #operation.sound fca_store run data get storage fimel_anim_text:runtime local.subtitle.sound

execute on target at @s run function fimel_anim_text:operation/sound/default_out