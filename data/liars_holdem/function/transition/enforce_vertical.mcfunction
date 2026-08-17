# 当前执行者是本次过场动画的中心实体；前置动画库未复制billboard字段，因此按实例编号补正
data modify entity @s billboard set value "vertical"
data modify entity @s see_through set value 0b
scoreboard players operation #transition_anim_id lh_ctx = @s cgt.AnimText.entity.count
execute as @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.text] if score @s cgt.AnimText.entity.count = #transition_anim_id lh_ctx run data modify entity @s billboard set value "vertical"
execute as @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.text] if score @s cgt.AnimText.entity.count = #transition_anim_id lh_ctx run data modify entity @s see_through set value 0b
