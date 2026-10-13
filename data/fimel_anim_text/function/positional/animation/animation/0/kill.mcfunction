scoreboard players operation #entity.current fca_store = @s fca_id

execute as @e[type=text_display,tag=fimel.anim_text.positional.animation.center] if score @s fca_id = #entity.current fca_store run scoreboard players add @s fca_timer 1

kill @s