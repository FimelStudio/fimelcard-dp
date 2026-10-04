execute as @a[tag=dd.player,scores={dd_drop=1..}] at @s run function doudizhu:input/drop
execute as @a[tag=dd.player,scores={dd_action=1..}] run function doudizhu:action/handle
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=1}] at @s run function doudizhu:deal/tick
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=2..3}] at @s run function doudizhu:bot/tick
scoreboard players add #clock dd_ctx 1
execute if score #clock dd_ctx matches 20.. as @a[tag=dd.player] run function doudizhu:player/check_session
execute if score #clock dd_ctx matches 20.. as @e[type=minecraft:marker,tag=dd.controller] at @s run function doudizhu:system/maintenance
execute if score #clock dd_ctx matches 20.. run scoreboard players set #clock dd_ctx 0
