scoreboard players set #owned dd_ctx 0
execute on origin if entity @s[tag=dd.dropper] run scoreboard players set #owned dd_ctx 1
execute unless score #owned dd_ctx matches 1 run return 0
execute as @a[tag=dd.dropper,limit=1] run function doudizhu:input/return_tool
execute as @a[tag=dd.dropper,limit=1] run function doudizhu:dialog/open
kill @s
