scoreboard players set #kind gd_ctx 8
scoreboard players set #size gd_ctx 4
scoreboard players set #point gd_ctx 9
scoreboard players set #high gd_ctx 9
scoreboard players set #power gd_ctx 4
scoreboard players set #suit gd_ctx -1
execute if score #level gd_ctx matches 9 run scoreboard players set #high gd_ctx 15
data modify storage guandan:cards candidate set value {"label":"4张炸弹 9"}
function guandan:cards/append
