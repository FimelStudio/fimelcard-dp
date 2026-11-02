execute if score #r2 ca_ctx matches ..0 run return run function catan:engine/error {id:6}
execute if score #r3 ca_ctx matches ..0 run return run function catan:engine/error {id:6}
execute if score #r4 ca_ctx matches ..0 run return run function catan:engine/error {id:6}
scoreboard players remove #r2 ca_ctx 1
scoreboard players add #bank2 ca_ctx 1
scoreboard players remove #r3 ca_ctx 1
scoreboard players add #bank3 ca_ctx 1
scoreboard players remove #r4 ca_ctx 1
scoreboard players add #bank4 ca_ctx 1
function catan:engine/save_resources with storage catan:engine request
function catan:engine/save_bank
scoreboard players set #valid ca_ctx 1
