execute store result score #positional.typewriter.fade.step fca_store run data get entity @s text_opacity

execute if score #positional.typewriter.fade.step fca_store matches ..-1 run scoreboard players add #positional.typewriter.fade.step fca_store 256

execute store result entity @s data.fade_opacity int 1 run scoreboard players get #positional.typewriter.fade.step fca_store

scoreboard players operation #positional.typewriter.fade.step fca_store /= #value.15 fca_store

execute store result entity @s data.fade_step int 1 run scoreboard players get #positional.typewriter.fade.step fca_store

#tellraw @a [{nbt:"data.fade_opacity",entity:"@s"},{nbt:"data.fade_step",entity:"@s"}]