scoreboard players operation #vis_table xq_ctx = @s ct_id
execute as @e[tag=xq.man,tag=xq.moving] if score @s ct_id = #vis_table xq_ctx run tag @s remove xq.moving
