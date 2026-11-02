$execute as @e[tag=ca.visual,scores={ca_vkind=$(kind),ca_vid=$(target)}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/pose with storage catan:visual pose
