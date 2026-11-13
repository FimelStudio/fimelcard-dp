scoreboard objectives add ct_ch_epoch dummy
scoreboard objectives add ct_ch_nonce dummy
scoreboard objectives add ct_ch_load dummy
scoreboard objectives add ct_ch_table dummy
scoreboard objectives add ct_ch_game dummy
scoreboard objectives add ct_ch_seen dummy
scoreboard objectives add ct_ch_seat dummy
scoreboard objectives add ct_chair_pick trigger
scoreboard players add #chair_load ct_ctx 1
execute unless score #chair_serial ct_ctx matches 1..99999999 run scoreboard players set #chair_serial ct_ctx 1
scoreboard players set #chair_ten ct_ctx 10
scoreboard players reset * ct_chair_pick
scoreboard players reset * ct_ch_nonce
function cardtable:chairs/layout/load
