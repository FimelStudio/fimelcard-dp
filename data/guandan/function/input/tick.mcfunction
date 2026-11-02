# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @a[tag=gd.player,scores={gd_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function guandan:input/drop
execute as @a[tag=gd.player,scores={gd_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function guandan:input/submit
execute as @a[scores={gd_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function guandan:settings/save
execute as @a[tag=gd.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function guandan:input/sync_turn_tool
