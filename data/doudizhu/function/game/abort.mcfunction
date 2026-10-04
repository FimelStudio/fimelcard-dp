scoreboard players operation #ctx dd_ctx = @s dd_id
execute store result storage doudizhu:input table int 1 run scoreboard players get @s dd_id
function doudizhu:input/clear_drops with storage doudizhu:input
execute as @a[tag=dd.player] if score @s dd_id = #ctx dd_ctx run function doudizhu:player/clear_state
execute as @e[tag=dd.card] if score @s dd_id = #ctx dd_ctx run kill @s
execute as @e[type=minecraft:marker,tag=dd.bot] if score @s dd_id = #ctx dd_ctx run kill @s
scoreboard players reset @s dd_humans
scoreboard players reset @s dd_bot_timer
function cardtable:animation/deal/clear
data remove entity @s data.doudizhu
tag @s remove dd.controller
scoreboard players reset @s dd_state
scoreboard players reset @s dd_id
function cardtable:game/return_lobby
tag @e[tag=dd.current] remove dd.current
tag @e[tag=dd.hand] remove dd.hand
