scoreboard players set #occupied dd_ctx 0
$execute as @e[tag=dd.actor,scores={dd_seat=$(seat)}] if score @s dd_id = #ctx dd_ctx run scoreboard players set #occupied dd_ctx 1
$execute if score #occupied dd_ctx matches 0 summon minecraft:marker run function doudizhu:bot/init {seat:$(seat)}
execute if score #occupied dd_ctx matches 0 run scoreboard players remove #missing dd_ctx 1
