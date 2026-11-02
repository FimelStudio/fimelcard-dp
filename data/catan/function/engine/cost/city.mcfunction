execute if score #r3 ca_ctx matches ..1 run return run function catan:engine/error {id:6}
execute if score #r4 ca_ctx matches ..2 run return run function catan:engine/error {id:6}
scoreboard players remove #r3 ca_ctx 2
scoreboard players add #bank3 ca_ctx 2
scoreboard players remove #r4 ca_ctx 3
scoreboard players add #bank4 ca_ctx 3
function catan:engine/save_resources with storage catan:engine request
function catan:engine/save_bank
scoreboard players set #valid ca_ctx 1
