# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[type=minecraft:interaction,tag=go.cell] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if data entity @s interaction at @s run function weiqi:input/cell
execute as @a[tag=go.player,scores={go_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function weiqi:input/drop
execute as @a[tag=go.player,scores={go_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function weiqi:input/submit
execute as @a[scores={go_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function weiqi:settings/save
execute as @a[tag=go.player,scores={go_coord=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function weiqi:input/coordinate_submit
