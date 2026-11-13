# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set #owned dd_ctx 0
execute on origin if entity @s[tag=dd.dropper] run scoreboard players set #owned dd_ctx 1
execute unless score #owned dd_ctx matches 1 run return 0
execute as @a[tag=dd.dropper,limit=1] run function doudizhu:input/return_tool
execute as @a[tag=dd.dropper,limit=1] run function doudizhu:dialog/open
kill @s
