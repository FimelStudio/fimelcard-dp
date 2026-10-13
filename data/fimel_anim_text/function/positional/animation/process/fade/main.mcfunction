execute store result score #positional.animation.fade.opacity fca_store run data get entity @s data.fade.value

execute store result score #positional.animation.fade.step fca_store run data get entity @s data.fade.step

scoreboard players operation #positional.animation.fade.opacity fca_store -= #positional.animation.fade.step fca_store

#tellraw @a {score:{name:"#positional.animation.fade.opacity",objective:"fca_store"}}

execute if score #positional.animation.fade.opacity fca_store matches 0..15 run return run kill @s

execute store result entity @s data.fade.value byte 1 run scoreboard players get #positional.animation.fade.opacity fca_store

execute store result entity @s text_opacity byte 1 run scoreboard players get #positional.animation.fade.opacity fca_store