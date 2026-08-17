# 只处理本项目拥有的实体标签，不触碰服务器上其他数据包的文本展示实体
execute as @e[type=minecraft:text_display,tag=ct.part] run function cardtable:display/disable_see_through
execute as @e[type=minecraft:text_display,tag=fc.game_entity] run function cardtable:display/disable_see_through
execute as @e[type=minecraft:text_display,tag=fc.transition] run function cardtable:display/disable_see_through
execute as @e[type=minecraft:text_display,tag=lh.transition] run function cardtable:display/disable_see_through
execute as @e[type=minecraft:text_display,tag=lh.game_entity] run function cardtable:display/disable_see_through
execute as @e[type=minecraft:text_display,tag=hb.game_entity] run function cardtable:display/disable_see_through
execute as @e[type=minecraft:text_display,tag=fc.transition.root,tag=cgt_anim_text.positional.animation.center] run function cardtable:display/repair_animation_children
execute as @e[type=minecraft:text_display,tag=lh.transition.root,tag=cgt_anim_text.positional.animation.center] run function cardtable:display/repair_animation_children
