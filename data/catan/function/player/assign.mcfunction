scoreboard players operation @s ca_side = #side ca_ctx
execute store result storage catan:runtime side int 1 run scoreboard players get @s ca_side
execute store result storage catan:runtime seat int 1 run scoreboard players get @s ca_seat
function catan:name/capture
function catan:player/store with storage catan:runtime
