scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
scoreboard players operation #attacker ch_ctx = #side ch_ctx
function chess:engine/attack
execute if score #attacked ch_ctx matches 1 run scoreboard players add #ai_score ch_ctx 250
