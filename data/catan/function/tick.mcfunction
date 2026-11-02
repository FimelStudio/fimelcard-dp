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
