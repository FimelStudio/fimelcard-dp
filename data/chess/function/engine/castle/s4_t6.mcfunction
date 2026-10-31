execute unless score #side ch_ctx matches 1 run return 0
execute unless score #b7 ch_ctx matches 4 run return 0
scoreboard players operation #right ch_ctx = #castle ch_ctx
scoreboard players operation #right ch_ctx %= #two ch_ctx
execute unless score #right ch_ctx matches 1 run return 0
execute unless score #b5 ch_ctx matches 0 run return 0
execute unless score #b6 ch_ctx matches 0 run return 0
scoreboard players set #attacker ch_ctx -1
scoreboard players set #attack_sq ch_ctx 4
function chess:engine/attack
execute if score #attacked ch_ctx matches 1 run return 0
scoreboard players set #attack_sq ch_ctx 5
function chess:engine/attack
execute if score #attacked ch_ctx matches 1 run return 0
scoreboard players set #rook_from ch_ctx 7
scoreboard players set #rook_to ch_ctx 5
scoreboard players set #shape ch_ctx 1
