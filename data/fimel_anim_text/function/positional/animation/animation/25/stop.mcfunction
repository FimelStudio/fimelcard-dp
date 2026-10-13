# 计算分数

scoreboard players operation #positional.animation.time_total fca_store = @s fca_timer_total

scoreboard players add #positional.animation.time_total fca_store 55

scoreboard players operation #entity.current fca_store = @s fca_id

# 选择分组文本

execute as @e[type=text_display,tag=fimel.anim_text.positional.animation.text] if score @s fca_id = #entity.current fca_store run scoreboard players operation @s fca_timer_total = #positional.animation.time_total fca_store

kill @s