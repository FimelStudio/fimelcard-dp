function xiangqi:engine/apply_cache with storage xiangqi:engine scratch
scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx
execute if score #side xq_ctx matches -1 run scoreboard players operation #attack_sq xq_ctx = #bking xq_ctx
execute if score #kind xq_ctx matches 6 run scoreboard players operation #attack_sq xq_ctx = #to xq_ctx
scoreboard players operation #attacker xq_ctx = #side xq_ctx
scoreboard players operation #attacker xq_ctx *= #minus xq_ctx
function xiangqi:engine/attack
function xiangqi:engine/restore_cache with storage xiangqi:engine scratch
