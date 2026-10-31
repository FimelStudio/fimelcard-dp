scoreboard players set #ui_drop_owner gm_ctx 0
execute on origin if entity @s[tag=gm.dropper,tag=gm.player] run scoreboard players set #ui_drop_owner gm_ctx 1
execute unless score #ui_drop_owner gm_ctx matches 1 run return 0
scoreboard players set #ui_tool gm_ctx 0
execute store result score #ui_tool gm_ctx run data get entity @s Item.components."minecraft:custom_data".gomoku.action
kill @s
execute as @a[tag=gm.dropper,limit=1] run function gomoku:input/give
execute as @a[tag=gm.dropper,limit=1] at @s run function gomoku:ui/quick
