scoreboard objectives add sk_ctx dummy
execute unless score #version sk_ctx matches 1.. run function skull:system/install
execute unless score #serial sk_ctx matches 0.. run scoreboard players set #serial sk_ctx 0
scoreboard players set #hundred sk_ctx 100
execute as @e[type=minecraft:marker,tag=sk.controller,scores={sk_state=1..7}] at @s run function skull:game/resume
