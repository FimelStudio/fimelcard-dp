# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #drop_owner ll_ctx 0
execute on origin if entity @s[tag=ll.dropper,tag=ll.player] run scoreboard players set #drop_owner ll_ctx 1
execute unless score #drop_owner ll_ctx matches 1 run return 0
data modify storage love_letter:input dropped set from entity @s Item.components."minecraft:custom_data".love_letter
execute if data storage love_letter:input dropped{hand:1b} as @a[tag=ll.dropper,limit=1] run function love_letter:direct/play with storage love_letter:input dropped
execute if data storage love_letter:input dropped{hand:1b} run return run kill @s
execute store result score #tool_action ll_ctx run data get entity @s Item.components."minecraft:custom_data".love_letter.action
kill @s
execute as @a[tag=ll.dropper,limit=1] run function love_letter:input/give
execute if score #tool_action ll_ctx matches 8 as @a[tag=ll.dropper,limit=1] at @s run return run function love_letter:ui/menu
execute as @a[tag=ll.dropper,limit=1] at @s run function love_letter:ui/open
