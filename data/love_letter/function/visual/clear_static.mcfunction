scoreboard players operation #vis_table ll_ctx = @s ct_id
execute as @e[tag=ll.visual,tag=!ll.fx,tag=!ll.box] if score @s ct_id = #vis_table ll_ctx run kill @s
