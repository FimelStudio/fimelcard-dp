execute as @e[tag=ca.visual,scores={ca_vkind=10}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/fx_tick
execute if score @s ca_vtimer matches 1.. run function catan:visual/event_tick
execute unless score @s ca_vtimer matches 1.. run function catan:visual/start_next
