data modify storage splendor:inventory count.id set from storage splendor:inventory work[0]
data remove storage splendor:inventory work[0]
function splendor:inventory/count_card_id with storage splendor:inventory count
execute if data storage splendor:inventory work[0] run function splendor:inventory/count_card
