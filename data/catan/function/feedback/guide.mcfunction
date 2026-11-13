execute if score @s ct_paused matches 1 run return 0
execute if score @s ca_anim matches 1.. run return 0
execute if score @s ca_vtimer matches 1.. run return 0
execute if score @s ca_state matches 3 as @e[tag=ca.visual,scores={ca_vkind=8}] if score @s ct_id = #table ca_ctx at @s run function catan:feedback/dice_guide
execute if score @s ca_state matches 6 as @e[tag=ca.visual,scores={ca_vkind=7}] if score @s ct_id = #table ca_ctx run data merge entity @s {Glowing:1b,glow_color_override:16766720}
execute unless score @s ca_state matches 6 as @e[tag=ca.visual,scores={ca_vkind=7}] if score @s ct_id = #table ca_ctx run data merge entity @s {Glowing:0b}
