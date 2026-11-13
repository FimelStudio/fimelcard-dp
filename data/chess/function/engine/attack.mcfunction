scoreboard players set #attacked ch_ctx 0
execute unless score #attack_sq ch_ctx matches 0..63 run return 0
execute store result storage chess:engine attack.sq int 1 run scoreboard players get #attack_sq ch_ctx
function chess:engine/attack_dispatch with storage chess:engine attack
return run scoreboard players get #attacked ch_ctx
