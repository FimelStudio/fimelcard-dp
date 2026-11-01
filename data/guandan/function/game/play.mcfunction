function guandan:game/validate_actor
execute unless score #ok gd_ctx matches 1 run return 0
function guandan:game/select_context
function guandan:cards/analyze
scoreboard players set #ok gd_ctx 0
execute unless score #options gd_ctx matches 1.. run return 0
execute if score #options gd_ctx matches 2.. run return 0
scoreboard players set #choice gd_ctx 0
function guandan:game/submit
