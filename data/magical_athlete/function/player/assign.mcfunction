scoreboard players operation @s ma_side = #side ma_ctx
execute store result storage magical_athlete:runtime side int 1 run scoreboard players get @s ma_side
execute store result storage magical_athlete:runtime seat int 1 run scoreboard players get @s ma_seat
function magical_athlete:name/capture
function magical_athlete:player/store with storage magical_athlete:runtime
