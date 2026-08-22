scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run function abraca:player/clear_state
execute as @e[tag=ab.game_entity] if score @s ab_id = #ctx ab_ctx run kill @s
tag @s remove ab.controller
scoreboard players set @s ab_state 0
scoreboard players reset @s ab_id
function cardtable:animation/deal/clear
function cardtable:game/return_lobby
