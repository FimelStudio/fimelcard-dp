scoreboard players operation #anim_id lh_ctx = @s cgt.AnimText.entity.count
execute as @e[tag=cgt_anim_text.positional.animation] if score @s cgt.AnimText.entity.count = #anim_id lh_ctx run kill @s
