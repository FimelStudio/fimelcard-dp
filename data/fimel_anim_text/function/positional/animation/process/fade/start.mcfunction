execute store result score #positional.animation.fade.step fca_store run data get entity @s text_opacity

execute if score #positional.animation.fade.step fca_store matches ..-1 run scoreboard players add #positional.animation.fade.step fca_store 256

execute store result entity @s data.fade.value int 1 run scoreboard players get #positional.animation.fade.step fca_store

scoreboard players operation #positional.animation.fade.step fca_store /= #value.15 fca_store

execute store result entity @s data.fade.step int 1 run scoreboard players get #positional.animation.fade.step fca_store