# 前置文本动画库会为一个中心实体生成若干子文本；按动画实例编号只修复本实例
scoreboard players operation #occlusion_anim ct_ctx = @s cgt.AnimText.entity.count
execute as @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.text] if score @s cgt.AnimText.entity.count = #occlusion_anim ct_ctx run function cardtable:display/disable_see_through
