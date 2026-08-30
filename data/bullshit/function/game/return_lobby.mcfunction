scoreboard players operation #ctx bw_ctx = @s bw_id
execute as @e[type=minecraft:text_display,tag=bw.result] if score @s bw_id = #ctx bw_ctx run kill @s
tag @s remove bw.controller
scoreboard players reset @s bw_id
scoreboard players set @s bw_state 0
function cardtable:game/return_lobby
