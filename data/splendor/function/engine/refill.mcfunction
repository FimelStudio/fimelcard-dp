$data modify storage splendor:engine state.market[$(slot)] set value -1
$execute unless data storage splendor:engine state.deck$(tier)[0] run return 0
$data modify storage splendor:engine state.market[$(slot)] set from storage splendor:engine state.deck$(tier)[0]
$data remove storage splendor:engine state.deck$(tier)[0]
