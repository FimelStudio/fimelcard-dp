# 特效动画还会生成字符实体和临时标记，需要按动画库实例编号整组删除
execute if entity @s[tag=fimel.anim_text.positional.animation.center] run return run function fast_card:transition/cleanup_animation

# 打字动画只有一个展示实体，可以直接删除
kill @s
