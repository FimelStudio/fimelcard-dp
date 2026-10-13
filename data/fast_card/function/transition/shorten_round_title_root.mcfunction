scoreboard players operation #anim_id fc_ctx = @s fca_id
execute as @e[type=minecraft:text_display,tag=fimel.anim_text.positional.animation.text] if score @s fca_id = #anim_id fc_ctx run scoreboard players set @s fca_timer_total 24
