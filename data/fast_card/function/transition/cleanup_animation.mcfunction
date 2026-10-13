scoreboard players operation #anim_id fc_ctx = @s fca_id
execute as @e[tag=fimel.anim_text.positional.animation] if score @s fca_id = #anim_id fc_ctx run kill @s
