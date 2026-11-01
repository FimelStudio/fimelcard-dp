scoreboard players set #kind gd_ctx 4
scoreboard players set #size gd_ctx 5
scoreboard players set #point gd_ctx 6
scoreboard players set #high gd_ctx 6
scoreboard players set #power gd_ctx 0
scoreboard players set #suit gd_ctx -1
execute if score #level gd_ctx matches 6 run scoreboard players set #high gd_ctx 15
data modify storage guandan:cards candidate set value {"label":"三带二 6"}
function guandan:cards/append
