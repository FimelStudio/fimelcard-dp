execute store result score #from ch_ctx run data get entity @s data.chess.ai.current.f
execute store result score #to ch_ctx run data get entity @s data.chess.ai.current.t
scoreboard players set #promo ch_ctx 5
function chess:engine/check_move
execute unless score #legal ch_ctx matches 1 run return 0
function chess:ai/apply_checked
execute if score #piece ch_ctx matches 6 run scoreboard players operation #wking ch_ctx = #to ch_ctx
execute if score #piece ch_ctx matches -6 run scoreboard players operation #bking ch_ctx = #to ch_ctx
function chess:ai/rights
scoreboard players set #ep ch_ctx -1
scoreboard players operation #ai_distance ch_ctx = #to ch_ctx
scoreboard players operation #ai_distance ch_ctx -= #from ch_ctx
execute if score #kind ch_ctx matches 1 if score #ai_distance ch_ctx matches 16 run function chess:ai/ep_white
execute if score #kind ch_ctx matches 1 if score #ai_distance ch_ctx matches -16 run function chess:ai/ep_black
scoreboard players operation #side ch_ctx *= #minus ch_ctx
scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
scoreboard players operation #attacker ch_ctx = #side ch_ctx
scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
function chess:engine/attack
scoreboard players operation #ai_checked ch_ctx = #attacked ch_ctx
