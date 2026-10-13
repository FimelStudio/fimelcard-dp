
#tellraw @a [{nbt:"data.fade_opacity",entity:"@s"},{nbt:"data.fade_step",entity:"@s"}]
#tellraw @a [{score: {name:"#positional.typewriter.fade.opacity",objective:"fca_store"}},{score: {name:"#positional.typewriter.fade.step",objective:"fca_store"}}]

execute store result score #positional.typewriter.fade.opacity fca_store run data get entity @s data.fade_opacity

execute store result score #positional.typewriter.fade.step fca_store run data get entity @s data.fade_step

scoreboard players operation #positional.typewriter.fade.opacity fca_store -= #positional.typewriter.fade.step fca_store

execute store result entity @s text_opacity byte 1 run scoreboard players get #positional.typewriter.fade.opacity fca_store

execute store result entity @s data.fade_opacity byte 1 run scoreboard players get #positional.typewriter.fade.opacity fca_store

#tellraw @a [{score: {name:"#positional.typewriter.fade.opacity",objective:"fca_store"}},"///",{entity:"@s",nbt:"data.fade_opacity"}]