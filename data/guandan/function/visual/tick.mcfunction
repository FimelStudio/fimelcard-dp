# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #vis_table gd_ctx = @s ct_id
execute as @e[tag=gd.fx] if score @s ct_id = #vis_table gd_ctx run function guandan:visual/fx_tick
