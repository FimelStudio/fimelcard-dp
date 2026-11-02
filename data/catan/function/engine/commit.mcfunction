function catan:engine/cache
function catan:engine/stats
scoreboard players add #epoch ca_ctx 1
execute store result storage catan:engine state.epoch int 1 run scoreboard players get #epoch ca_ctx
execute store result storage catan:engine state.last.epoch int 1 run scoreboard players get #epoch ca_ctx
data modify entity @s data.catan set from storage catan:engine state
scoreboard players set #error ca_ctx 0
scoreboard players set #ok ca_ctx 1
