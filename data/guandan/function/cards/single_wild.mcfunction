scoreboard players operation #point gd_ctx = #level gd_ctx
scoreboard players set #kind gd_ctx 1
scoreboard players set #size gd_ctx 1
scoreboard players set #high gd_ctx 15
scoreboard players set #power gd_ctx 0
scoreboard players set #suit gd_ctx -1
data modify storage guandan:cards candidate set value {label:"单张 级牌"}
function guandan:cards/append
