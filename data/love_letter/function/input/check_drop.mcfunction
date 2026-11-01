scoreboard players set #drop_owner ll_ctx 0
execute on origin if entity @s[tag=ll.dropper,tag=ll.player] run scoreboard players set #drop_owner ll_ctx 1
execute unless score #drop_owner ll_ctx matches 1 run return 0
execute store result score #tool_action ll_ctx run data get entity @s Item.components."minecraft:custom_data".love_letter.action
kill @s
execute as @a[tag=ll.dropper,limit=1] run function love_letter:input/give
execute if score #tool_action ll_ctx matches 8 as @a[tag=ll.dropper,limit=1] at @s run return run function love_letter:ui/menu
execute as @a[tag=ll.dropper,limit=1] at @s run function love_letter:ui/open
