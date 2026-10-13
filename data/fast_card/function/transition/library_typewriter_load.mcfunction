# 与特效动画适配器相同，只绕过公开load函数的中文宏赋值
execute unless loaded ~ ~ ~ run return fail

function fimel_anim_text:positional/typewriter/start/set
execute if score #positional.typewriter.text fca_store matches 0 run return fail
execute unless score #positional.typewriter.style fca_store matches 0..2 run return fail
execute unless score #positional.typewriter.speed fca_store matches 0.. run return fail
execute summon minecraft:text_display run function fimel_anim_text:positional/typewriter/start/summon
