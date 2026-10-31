scoreboard players set #ui_drop_owner xq_ctx 0
execute on origin if entity @s[tag=xq.dropper,tag=xq.player] run scoreboard players set #ui_drop_owner xq_ctx 1
execute unless score #ui_drop_owner xq_ctx matches 1 run return 0
scoreboard players set #ui_tool xq_ctx 0
execute store result score #ui_tool xq_ctx run data get entity @s Item.components."minecraft:custom_data".xiangqi.action
kill @s
execute as @a[tag=xq.dropper,limit=1] run function xiangqi:input/give
execute as @a[tag=xq.dropper,limit=1] at @s run function xiangqi:ui/quick
