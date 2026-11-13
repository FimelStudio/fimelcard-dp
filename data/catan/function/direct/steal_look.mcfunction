execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return run function catan:direct/wait
function catan:direct/look
execute unless score #look_side ca_ctx matches 1..4 run return run function catan:direct/look_miss
scoreboard players operation #code ca_ctx = #look_side ca_ctx
scoreboard players add #code ca_ctx 400
execute store result storage catan:direct target int 1 run scoreboard players get #look_side ca_ctx
function catan:direct/steal_check with storage catan:direct
