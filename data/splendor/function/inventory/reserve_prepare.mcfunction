$data modify storage splendor:inventory ctx.id set from storage splendor:inventory player.reserve[$(slot)]
$data modify storage splendor:inventory ctx.reserve_slot set value $(slot)
function splendor:inventory/reserve_resolve with storage splendor:inventory ctx
