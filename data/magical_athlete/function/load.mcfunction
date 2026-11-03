scoreboard objectives add ma_ctx dummy
execute unless score #version ma_ctx matches 1.. run function magical_athlete:system/install
function magical_athlete:engine/install
scoreboard players set #factor ma_ctx 10000
scoreboard players set #hundred ma_ctx 100
scoreboard players add #ui_load ma_ctx 1
scoreboard players reset * ma_action
scoreboard players reset * ma_nonce
function magical_athlete:settings/load
function magical_athlete:ui/load
function magical_athlete:visual/load
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23}] at @s run function magical_athlete:system/reload
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23}] at @s run function magical_athlete:system/reload
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_game=23}] at @s run function magical_athlete:system/reload

scoreboard objectives add ma_dye minecraft.dropped:minecraft.purple_dye

scoreboard objectives add ma_choicepage dummy

scoreboard objectives add ma_choiceepoch dummy

scoreboard objectives add ma_chatturn dummy

scoreboard objectives add ma_chatpending dummy

scoreboard objectives add ma_chatstate dummy

scoreboard objectives add ma_chatround dummy

scoreboard objectives add ma_notice dummy
