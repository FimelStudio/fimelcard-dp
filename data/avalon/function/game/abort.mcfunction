scoreboard players set @s av_state 0
function avalon:context
execute as @a[tag=av.audience] run function avalon:player/clear
execute as @e[tag=av.game_entity] if score @s av_id = #table av_ctx run kill @s
tag @s remove av.controller
data remove entity @s data.avalon
execute at @s run function cardtable:game/return_lobby
