tag @s add fimel.anim_text.positional.animation.obfuscasted

data modify entity @s text.obfuscated set value true

execute store result score #operation.sound fca_store run data get storage fimel_anim_text:runtime positional.animation.sound

execute at @s run function fimel_anim_text:operation/sound/positional_out