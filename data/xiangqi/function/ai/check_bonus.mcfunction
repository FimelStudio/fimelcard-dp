scoreboard players operation #attack_sq xq_ctx = #bking xq_ctx
execute if score #side xq_ctx matches -1 run scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx
scoreboard players operation #attacker xq_ctx = #side xq_ctx
function xiangqi:engine/attack
execute if score #attacked xq_ctx matches 1 run scoreboard players add #ai_score xq_ctx 250
