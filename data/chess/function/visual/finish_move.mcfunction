scoreboard players operation #vis_table ch_ctx = @s ct_id
execute as @e[tag=ch.man,tag=ch.moving] if score @s ct_id = #vis_table ch_ctx run tag @s remove ch.moving
