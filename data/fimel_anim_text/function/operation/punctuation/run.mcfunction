# 重置分数

scoreboard players set #operation.punctuation fca_store 0

scoreboard players reset #operation.next.sound fca_store

scoreboard players set #operation.next.has_sound fca_store 0

scoreboard players set #operation.delay fca_store 3

# 标点赋值 | 硬编码赋值

function fimel_anim_text:operation/punctuation/punctuation

execute if score #operation.next.has_sound fca_store matches 1.. run function fimel_anim_text:operation/punctuation/sound/has_soun

# debug

#tellraw @a {score:{name:"#operation.punctuation",objective:"fca_store"}}

# 速度倍率

scoreboard players operation #operation.delay fca_store *= #operation.speed fca_store

scoreboard players operation #operation.delay fca_store /= #value.100 fca_store