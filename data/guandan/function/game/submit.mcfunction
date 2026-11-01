function guandan:game/validate_actor
execute unless score #ok gd_ctx matches 1 run return 0
function guandan:game/select_context
function guandan:cards/analyze
function guandan:cards/choose
execute unless score #ok gd_ctx matches 1 run return 0
function guandan:cards/compare
execute unless score #beats gd_ctx matches 1 run return run function guandan:game/reject
function guandan:game/commit
