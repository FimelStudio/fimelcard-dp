scoreboard players operation #table it_ctx = @s ct_id
execute as @e[tag=it.card] if score @s ct_id = #table it_ctx run kill @s
execute as @e[tag=it.part] if score @s ct_id = #table it_ctx run kill @s
execute as @e[tag=it.visual] if score @s ct_id = #table it_ctx run kill @s
execute store result storage ito:input table int 1 run scoreboard players get @s ct_id
function ito:input/clear_drops with storage ito:input
tag @s remove it.controller
data remove entity @s data.ito
scoreboard players reset @s it_state
