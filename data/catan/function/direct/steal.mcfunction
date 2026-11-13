scoreboard players operation #target ca_ctx = #code ca_ctx
scoreboard players remove #target ca_ctx 400
execute store result storage catan:direct target int 1 run scoreboard players get #target ca_ctx
function catan:ui/steal with storage catan:direct
