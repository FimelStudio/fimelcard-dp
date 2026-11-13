# Controller; caller has already validated the lobby setting request.
execute unless score @s ct_state matches 0 run return fail
function cardtable:chairs/layout/normalize
scoreboard players set @s ct_clver 0
function cardtable:chairs/layout/ensure
scoreboard players add @s ct_ch_epoch 1
