function hanabi:name/resolve
data modify storage critical_point:dialog option.label set from storage hanabi:name resolved
scoreboard players operation #option cp_ctx = @s cp_seat
scoreboard players add #option cp_ctx 200
execute store result storage critical_point:dialog option.value int 1 run scoreboard players get #option cp_ctx
function critical_point:dialog/add_option with storage critical_point:dialog option
