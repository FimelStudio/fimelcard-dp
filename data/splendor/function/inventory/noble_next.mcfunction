data modify storage splendor:inventory ctx.noble set from storage splendor:inventory work[0]
data remove storage splendor:inventory work[0]
function splendor:inventory/noble_resolve with storage splendor:inventory ctx
execute if data storage splendor:inventory work[0] run function splendor:inventory/noble_next
