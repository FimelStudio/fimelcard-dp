# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 当前执行者是本次过场动画的中心实体；前置动画库未复制billboard字段，因此按实例编号补正
data modify entity @s billboard set value "vertical"
data modify entity @s see_through set value 0b
scoreboard players operation #transition_anim_id lh_ctx = @s fca_id
execute as @e[type=minecraft:text_display,tag=fimel.anim_text.positional.animation.text] if score @s fca_id = #transition_anim_id lh_ctx run data modify entity @s billboard set value "vertical"
execute as @e[type=minecraft:text_display,tag=fimel.anim_text.positional.animation.text] if score @s fca_id = #transition_anim_id lh_ctx run data modify entity @s see_through set value 0b
