# 速度

execute store result score #positional.animation.speed fca_store run data get storage fimel_anim_text:runtime positional.animation.speed

scoreboard players set #positional.animation.timer.step fca_store 3

scoreboard players operation #positional.animation.timer.step fca_store *= #positional.animation.speed fca_store

scoreboard players operation #positional.animation.timer.step fca_store /= #value.100 fca_store

# 检测反向

execute store result score #positional.animation.reverse fca_store run data get storage fimel_anim_text:runtime positional.animation.reverse

# 复制分数

scoreboard players operation #entity.current fca_store = @s fca_id

scoreboard players operation #positional.animation.time.max fca_store = @s fca_timer_max

scoreboard players operation #positional.animation.style fca_store = @s fca_style

# 检测数量

execute store result score #positional.animation.amount fca_store run data get storage fimel_anim_text:runtime positional.animation.input

scoreboard players operation #positional.animation.amount.odd fca_store = #positional.animation.amount fca_store

scoreboard players operation #positional.animation.amount.odd fca_store %= #value.2 fca_store

execute if score #positional.animation.amount.odd fca_store matches 0 run scoreboard players remove #positional.animation.amount fca_store 2

scoreboard players operation #positional.animation.amount fca_store /= #value.2 fca_store



scoreboard players operation #positional.animation.amount.total fca_store = #positional.animation.amount fca_store

scoreboard players operation #positional.animation.amount.time.total fca_store = #positional.animation.amount fca_store

scoreboard players operation #positional.animation.amount.time.total fca_store *= #positional.animation.timer.step fca_store

scoreboard players add #positional.animation.amount.time.total fca_store 70

#tellraw @a {score:{name:"#positional.animation.amount.time.total",objective:"fca_store"}}

# # 计算total分数

# function fimel_anim_text:positional/animation/start/marker/total

# 开始生成

function fimel_anim_text:positional/animation/start/marker/pos