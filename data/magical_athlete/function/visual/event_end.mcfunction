execute as @e[tag=ma.event_prop] if score @s ct_id = #vis_table ma_ctx run kill @s
execute unless data entity @s data.magical_athlete.visual_queue[0] run function magical_athlete:game/after_animation
