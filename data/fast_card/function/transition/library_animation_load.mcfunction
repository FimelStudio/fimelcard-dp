# 文本动画库公开load函数会把整个参数再次经过宏文本，Windows服务端会损坏中文
# 本适配器只跳过那一次宏赋值，其余初始化、计算与动画执行仍全部调用动画库
execute unless loaded ~ ~ ~ run return fail

function fimel_anim_text:positional/animation/start/set
function fimel_anim_text:positional/animation/start/transformation/index
function fimel_anim_text:positional/animation/start/calc_pos

execute if score #positional.animation.text fca_store matches 0 run return fail
execute unless score #positional.animation.style fca_store matches 0..35 run return fail
execute unless score #positional.animation.speed fca_store matches 0.. run return fail

scoreboard players add #entity.count fca_store 1
execute summon minecraft:text_display run function fimel_anim_text:positional/animation/start/summon/summon_center
execute if score #positional.animation.reverse fca_store matches 0 run return run function fimel_anim_text:positional/animation/start/pos1 with storage fimel_anim_text:runtime positional.animation.shift
execute if score #positional.animation.reverse fca_store matches 1 run return run function fimel_anim_text:positional/animation/start/pos2 with storage fimel_anim_text:runtime positional.animation.shift
