# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[tag=ca.visual,scores={ca_vkind=10}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/fx_tick
execute if score @s ca_vtimer matches 1.. run function catan:visual/event_tick
execute unless score @s ca_vtimer matches 1.. run function catan:visual/start_next
