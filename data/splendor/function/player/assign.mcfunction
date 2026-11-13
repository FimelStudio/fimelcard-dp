scoreboard players operation @s sp_side = #side sp_ctx
execute store result storage splendor:runtime side int 1 run scoreboard players get @s sp_side
execute store result storage splendor:runtime seat int 1 run scoreboard players get @s sp_seat
function splendor:name/capture
function splendor:player/store with storage splendor:runtime
