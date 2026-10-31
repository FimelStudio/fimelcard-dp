execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.current.f
execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.current.t
scoreboard players set #promo xq_ctx 5
function xiangqi:engine/check_move
execute unless score #legal xq_ctx matches 1 run return 0
function xiangqi:ai/apply_checked
execute if score #piece xq_ctx matches 6 run scoreboard players operation #wking xq_ctx = #to xq_ctx
execute if score #piece xq_ctx matches -6 run scoreboard players operation #bking xq_ctx = #to xq_ctx
scoreboard players operation #side xq_ctx *= #minus xq_ctx
scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx
execute if score #side xq_ctx matches -1 run scoreboard players operation #attack_sq xq_ctx = #bking xq_ctx
scoreboard players operation #attacker xq_ctx = #side xq_ctx
scoreboard players operation #attacker xq_ctx *= #minus xq_ctx
function xiangqi:engine/attack
scoreboard players operation #ai_checked xq_ctx = #attacked xq_ctx
