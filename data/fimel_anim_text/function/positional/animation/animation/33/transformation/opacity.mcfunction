# 淡出

scoreboard players set #positional.animation.fade.step fca_store 255

execute if data storage fimel_anim_text:runtime positional.animation.data.entity_properties.text_opacity store result score #positional.animation.fade.step fca_store run data get storage fimel_anim_text:runtime positional.animation.data.entity_properties.text_opacity

execute if score #positional.animation.fade.step fca_store matches ..-1 run scoreboard players add #positional.animation.fade.step fca_store 256

execute store result storage fimel_anim_text:runtime positional.animation.transformation.out.value int 1 run scoreboard players get #positional.animation.fade.step fca_store

scoreboard players operation #positional.animation.fade.step fca_store /= #value.15 fca_store

execute store result storage fimel_anim_text:runtime positional.animation.transformation.out.step int 1 run scoreboard players get #positional.animation.fade.step fca_store

data modify storage fimel_anim_text:runtime positional.animation.transformation.out_2 set from storage fimel_anim_text:runtime positional.animation.transformation.out

data modify storage fimel_anim_text:runtime positional.animation.transformation.out.value set value 0

data modify storage fimel_anim_text:runtime positional.animation.transformation.out_1 set from storage fimel_anim_text:runtime positional.animation.transformation.out

#tellraw @a {storage:"fimel_anim_text:runtime",nbt:"positional.animation.transformation"}