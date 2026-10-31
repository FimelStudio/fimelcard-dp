# 将死优先于第75回合和重复。不会改真实棋格、行棋方、历史或时钟。
function chess:system/context
function chess:engine/cache
scoreboard players set @s ch_result 0
scoreboard players set @s ch_reason 0
execute unless score #cache_ok ch_ctx matches 1 run return run function chess:engine/invalid_board
scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
scoreboard players operation #attacker ch_ctx = #side ch_ctx
scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
function chess:engine/attack
scoreboard players operation @s ch_check = #attacked ch_ctx
function chess:engine/has_move
execute if score #found ch_ctx matches 0 if score @s ch_check matches 1 run function chess:engine/mate
execute if score #found ch_ctx matches 0 if score @s ch_check matches 0 run function chess:engine/draw {reason:2}
execute unless score @s ch_result matches 0 run return 1
function chess:engine/material
execute if score #dead ch_ctx matches 1 run function chess:engine/draw {reason:3}
execute unless score @s ch_result matches 0 run return 1
execute if score @s ch_repetition matches 5.. run function chess:engine/draw {reason:4}
execute unless score @s ch_result matches 0 run return 1
execute if score @s ch_half matches 150.. run function chess:engine/draw {reason:5}
return run scoreboard players get @s ch_result
