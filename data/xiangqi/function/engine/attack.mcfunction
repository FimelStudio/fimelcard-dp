scoreboard players set #attacked xq_ctx 0
execute unless score #attack_sq xq_ctx matches 0..89 run return 0
execute unless score #attacker xq_ctx matches -1 unless score #attacker xq_ctx matches 1 run return 0
execute store result storage xiangqi:engine attack.sq int 1 run scoreboard players get #attack_sq xq_ctx
execute store result storage xiangqi:engine attack.side int 1 run scoreboard players get #attacker xq_ctx
function xiangqi:engine/attack_dispatch with storage xiangqi:engine attack
return run scoreboard players get #attacked xq_ctx
