scoreboard players operation #resource ca_ctx = #code ca_ctx
scoreboard players remove #resource ca_ctx 900
execute store result storage catan:direct id int 1 run scoreboard players get #resource ca_ctx
function catan:direct/resource with storage catan:direct
