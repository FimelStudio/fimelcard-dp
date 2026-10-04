function hanabi:name/resolve
data modify storage bullshit:dialog option.label set from storage hanabi:name resolved
scoreboard players operation #option bw_ctx = #action_base bw_ctx
scoreboard players operation #option bw_ctx += @s bw_seat
execute store result storage bullshit:dialog option.value int 1 run scoreboard players get #option bw_ctx
function bullshit:dialog/add_option with storage bullshit:dialog option
