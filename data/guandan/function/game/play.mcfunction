function guandan:game/validate_actor
execute unless score #ok gd_ctx matches 1 run return 0
function guandan:game/select_context
function guandan:cards/analyze
scoreboard players set #ok gd_ctx 0
execute unless score #options gd_ctx matches 1.. run return 0
scoreboard players set #hint_choice gd_ctx -1
execute if score #options gd_ctx matches 2.. if score @s gd_hint matches 1.. run function guandan:hint/find_option
execute if score #options gd_ctx matches 2.. unless score #hint_choice gd_ctx matches 0.. run return 0
scoreboard players set #choice gd_ctx 0
execute if score #hint_choice gd_ctx matches 0.. run scoreboard players operation #choice gd_ctx = #hint_choice gd_ctx
function guandan:game/submit
