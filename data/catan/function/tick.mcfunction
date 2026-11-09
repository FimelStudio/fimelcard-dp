# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @a[scores={ca_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function catan:settings/save
execute as @a[scores={ca_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] run function catan:ui/handle
execute as @a[tag=ca.player,scores={ca_drop=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function catan:input/drop
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21,ct_state=1}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function catan:game/tick
execute as @a[tag=ca.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] unless entity @s[tag=ct.player] run function catan:player/clear_state

execute as @a[tag=ca.player,scores={ca_dye=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function catan:direct/dye_drop

execute as @e[type=minecraft:item] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if items entity @s contents *[minecraft:custom_data~{catan:{resource:1b}}] run function catan:direct/resource_drop
# direct-v2
execute as @e[type=minecraft:item] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if items entity @s contents *[minecraft:custom_data~{catan:{tool:1b}}] run function catan:direct/recover_drop
