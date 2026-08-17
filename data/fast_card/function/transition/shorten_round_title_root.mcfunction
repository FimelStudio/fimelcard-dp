scoreboard players operation #anim_id fc_ctx = @s cgt.AnimText.entity.count
execute as @e[type=minecraft:text_display,tag=cgt_anim_text.positional.animation.text] if score @s cgt.AnimText.entity.count = #anim_id fc_ctx run scoreboard players set @s cgt.AnimText.entity.timer.total 24
