scoreboard players operation #anim_id lh_ctx = @s fca_id
execute as @e[tag=fimel.anim_text.positional.animation] if score @s fca_id = #anim_id lh_ctx run kill @s
