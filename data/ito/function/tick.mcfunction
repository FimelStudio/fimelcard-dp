# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @a[scores={it_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function ito:settings/save
execute as @a[tag=it.player,scores={it_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function ito:input/submit
execute in minecraft:overworld run function ito:system/tick_dimension
execute in minecraft:the_nether run function ito:system/tick_dimension
execute in minecraft:the_end run function ito:system/tick_dimension
