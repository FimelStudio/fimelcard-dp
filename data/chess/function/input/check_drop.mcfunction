# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #ui_drop_owner ch_ctx 0
execute on origin if entity @s[tag=ch.dropper,tag=ch.player] run scoreboard players set #ui_drop_owner ch_ctx 1
execute unless score #ui_drop_owner ch_ctx matches 1 run return 0
scoreboard players set #ui_tool ch_ctx 0
execute store result score #ui_tool ch_ctx run data get entity @s Item.components."minecraft:custom_data".chess.action
kill @s
execute as @a[tag=ch.dropper,limit=1] run function chess:input/give
execute as @a[tag=ch.dropper,limit=1] at @s run function chess:ui/quick
