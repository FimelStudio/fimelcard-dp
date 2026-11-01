scoreboard players set #drop_owner gd_ctx 0
execute on origin if entity @s[tag=gd.dropper,tag=gd.player] run scoreboard players set #drop_owner gd_ctx 1
execute unless score #drop_owner gd_ctx matches 1 run return 0
execute store result score #tool_action gd_ctx run data get entity @s Item.components."minecraft:custom_data".guandan.action
execute store result score #tool_table gd_ctx run data get entity @s Item.components."minecraft:custom_data".guandan.table
kill @s
execute unless score @a[tag=gd.dropper,limit=1] gd_table = #tool_table gd_ctx run return 0
execute as @a[tag=gd.dropper,limit=1] run function guandan:input/give
execute if score #tool_action gd_ctx matches 8 as @a[tag=gd.dropper,limit=1] at @s run return run function guandan:ui/menu
execute as @a[tag=gd.dropper,limit=1] at @s run function guandan:ui/open
