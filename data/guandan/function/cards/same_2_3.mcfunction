scoreboard players set #kind gd_ctx 2
scoreboard players set #size gd_ctx 2
scoreboard players set #point gd_ctx 3
scoreboard players set #high gd_ctx 3
scoreboard players set #power gd_ctx 0
scoreboard players set #suit gd_ctx -1
execute if score #level gd_ctx matches 3 run scoreboard players set #high gd_ctx 15
data modify storage guandan:cards candidate set value {"label":"对子 3"}
function guandan:cards/append
