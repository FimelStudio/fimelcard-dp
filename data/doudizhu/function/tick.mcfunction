execute as @a[scores={dd_settings=1..}] run function doudizhu:settings/save
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=4}] at @s run function doudizhu:game/intermission
execute as @a[tag=dd.player,scores={dd_drop_dye=1..}] at @s run function doudizhu:input/drop
execute as @a[tag=dd.player,scores={dd_action=1..}] run function doudizhu:action/handle
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=1}] at @s run function doudizhu:deal/tick
execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=2..3}] at @s run function doudizhu:bot/tick
scoreboard players add #clock dd_ctx 1
execute if score #clock dd_ctx matches 20.. as @a[tag=dd.player] run function doudizhu:player/check_session
execute if score #clock dd_ctx matches 20.. as @e[type=minecraft:marker,tag=dd.controller] at @s run function doudizhu:system/maintenance
execute if score #clock dd_ctx matches 20.. run scoreboard players set #clock dd_ctx 0

execute as @e[type=minecraft:marker,tag=dd.controller] run function doudizhu:input/sync

execute as @e[type=minecraft:marker,tag=dd.controller,scores={dd_state=3}] at @s run function doudizhu:autopass/tick
function doudizhu:music/tick
