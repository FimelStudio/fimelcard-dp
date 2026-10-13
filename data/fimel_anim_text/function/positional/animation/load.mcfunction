## 未加载跳出

execute unless loaded ~ ~ ~ run return run execute if score #settings.tip.error fca_store matches 1 run function fimel_anim_text:positional/tip/fail/unloaded

## 输入数据

$data modify storage fimel_anim_text:runtime positional.animation.data set value $(data)

## 设置数据

function fimel_anim_text:positional/animation/start/set

## 获取动画插值

function fimel_anim_text:positional/animation/start/transformation/index

## 计算位置

function fimel_anim_text:positional/animation/start/calc_pos

## 错误跳出

execute if score #positional.animation.text fca_store matches 0 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:positional/tip/fail/no_input

execute unless score #positional.animation.style fca_store matches 0..35 if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:positional/tip/fail/false_style

execute unless score #positional.animation.speed fca_store matches 0.. if score #settings.tip.error fca_store matches 1 run return run function fimel_anim_text:positional/tip/fail/false_speed

execute if score #operation.split.verify.change fca_store matches 1 if score #settings.tip.warn fca_store matches 1 run function fimel_anim_text:positional/tip/warn/irregular_input

## 执行操作

scoreboard players add #entity.count fca_store 1

# 生成实体

execute summon text_display run function fimel_anim_text:positional/animation/start/summon/summon_center

# 生成位移实体

#tellraw @a {score:{name:"#positional.animation.reverse",objective:"fca_store"}}

execute if score #positional.animation.reverse fca_store matches 0 run return run function fimel_anim_text:positional/animation/start/pos1 with storage fimel_anim_text:runtime positional.animation.shift

execute if score #positional.animation.reverse fca_store matches 1 run return run function fimel_anim_text:positional/animation/start/pos2 with storage fimel_anim_text:runtime positional.animation.shift