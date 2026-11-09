# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @a[scores={sp_settings=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function splendor:settings/save
execute as @a[scores={sp_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function splendor:ui/handle
execute as @e[type=minecraft:item] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if items entity @s contents *[minecraft:custom_data~{splendor:{asset:1b}}] at @s run function splendor:inventory/item_drop
execute as @a[tag=sp.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function splendor:inventory/tick
execute as @e[type=minecraft:interaction,tag=sp.hit] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if data entity @s attack at @s run function splendor:direct/left
execute as @e[type=minecraft:interaction,tag=sp.hit] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] if data entity @s interaction at @s run function splendor:direct/click
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function splendor:game/tick
execute as @a[tag=sp.player] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] unless entity @s[tag=ct.player] run function splendor:player/clear_state
